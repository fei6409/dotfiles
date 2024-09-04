-- LSP config
-- setup reference: https://youtu.be/puWgHa7k3SY

LSP_SERVER = {
    'bashls',
    'clangd',
    'denols',
    'gopls',
    'jsonls',
    'lua_ls',
    'marksman',
    -- 'pyright',
    'ruff',
    'yamlls',
}

return {
    -- Order matters, mason must come first before nvim-lspconfig
    {
        'williamboman/mason.nvim',
        -- event = 'VeryLazy',
        opts = {},
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
        },
        event = 'VeryLazy',
        opts = {
            ensure_installed = LSP_SERVER,
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/nvim-cmp',
        },
        event = 'VeryLazy',
        config = function()
            -- nvim-cmp supports more types of completion candidates,
            -- so users must override the capabilities sent to the
            -- server such that it can provide these candidates during
            -- a completion request.
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require 'lspconfig'

            -- Override floating window border.
            -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
            local handlers = {
                ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
                ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
            }

            -- Bulk-setup LSP servers
            for _, lsp in ipairs(LSP_SERVER) do
                lspconfig[lsp].setup {
                    capabilities = capabilities,
                    handlers = handlers,
                }
            end

            -- LSP servers that need extra configuration
            lspconfig.bashls.setup {
                capabilities = capabilities,
                handlers = handlers,
                filetypes = { 'sh', 'zsh', 'bash' },
                settings = {
                    bashIde = {
                        -- SC2034: foo appears unused. Verify it or export it.
                        shellcheckArguments = '-e SC2034,',
                    },
                },
            }
            lspconfig.lua_ls.setup {
                capabilities = capabilities,
                handlers = handlers,
                settings = {
                    Lua = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        runtime = { version = 'LuaJIT' },
                        -- Get the language server to recognize the `vim` global
                        diagnostics = { globals = { 'vim' } },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                            -- No third-party check: https://github.com/neovim/nvim-lspconfig/issues/1700
                            checkThirdParty = false,
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = { enable = false },
                    },
                },
            }

            -- show shellcheck error code in diagnostic
            -- https://github.com/bash-lsp/bash-language-server/issues/752
            local diag_format = function(d)
                return string.format('%s [%s]', d.message, d.code)
            end
            vim.diagnostic.config {
                virtual_text = {
                    format = diag_format,
                },
                float = {
                    border = 'rounded',
                },
            }

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local keyset = vim.keymap.set
                    local opts = function(desc)
                        return { buffer = ev.buf, silent = true, desc = desc }
                    end

                    keyset('n', '<space>d', vim.diagnostic.open_float, opts 'Diagnostic open float window')
                    keyset('n', '[d', vim.diagnostic.goto_next, opts 'Diagnostic goto next')
                    keyset('n', ']d', vim.diagnostic.goto_prev, opts 'Diagnostic goto prev')

                    keyset('n', 'K', vim.lsp.buf.hover, opts 'LSP hover')
                    keyset('n', 'gD', vim.lsp.buf.declaration, opts 'LSP declaration')
                    keyset('n', 'gd', vim.lsp.buf.definition, opts 'LSP definition')
                    keyset('n', 'gi', vim.lsp.buf.implementation, opts 'LSP implementation')
                    keyset('n', 'gt', vim.lsp.buf.type_definition, opts 'LSP type definition')
                    keyset('n', 'gr', vim.lsp.buf.references, opts 'LSP references')

                    keyset('n', '<leader>k', vim.lsp.buf.signature_help, opts 'LSP signature help')
                    keyset('n', '<leader>rn', vim.lsp.buf.rename, opts 'LSP rename')
                    keyset({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts 'LSP code action')
                    -- Replaced by conform.nvim
                    -- keyset({ 'n', 'v' }, '<leader>f', function()
                    --     vim.lsp.buf.format { async = true }
                    --     -- ensure always go back to normal mode
                    --     vim.api.nvim_input('<ESC>')
                    -- end, opts('LSP format'))

                    keyset('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts 'LSP add workspace folder')
                    keyset('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts 'LSP remove workspace folder')
                    keyset('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts 'LSP list workspace folder')
                end,
            })
        end,
    },
}
