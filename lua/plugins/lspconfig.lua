-- LSP config
-- setup reference: https://youtu.be/puWgHa7k3SY
return {
    -- Order matters, mason must come first before nvim-lspconfig
    {
        'williamboman/mason.nvim',
        opts = {},
    },
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {
            ensure_installed = {
                'bashls',
                'clangd',
                'jsonls',
                'lua_ls',
                'marksman',
                'pyright',
                'ruby_ls',
                'yamlls',
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/nvim-cmp',
        },
        config = function()
            require('lspconfig').bashls.setup {
                filetypes = { 'sh', 'zsh', 'bash' },
                settings = {
                    bashIde = {
                        -- SC2034: foo appears unused. Verify it or export it.
                        shellcheckArguments = '-e SC2034,',
                    },
                },
            }
            require('lspconfig').clangd.setup {}
            require('lspconfig').gopls.setup {}
            require('lspconfig').jsonls.setup {}
            require('lspconfig').lua_ls.setup {
                settings = {
                    Lua = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        runtime = { version = 'LuaJIT', },
                        -- Get the language server to recognize the `vim` global
                        diagnostics = { globals = { 'vim' }, },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                            -- No third-party check: https://github.com/neovim/nvim-lspconfig/issues/1700
                            checkThirdParty = false,
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = { enable = false, },
                    },
                },
            }
            require('lspconfig').marksman.setup {}
            require('lspconfig').pyright.setup {}
            require('lspconfig').ruby_ls.setup {}
            require('lspconfig').yamlls.setup {}

            -- show shellcheck error code in diagnostic
            -- https://github.com/bash-lsp/bash-language-server/issues/752
            local diag_format = function(d)
                return string.format('%s [%s]', d.message, d.code)
            end
            vim.diagnostic.config({
                virtual_text = {
                    format = diag_format,
                },
                float = {
                    format = diag_format,
                },
            })

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
                    local opts = { buffer = ev.buf }
                    keyset('n', 'K', vim.lsp.buf.hover, opts)
                    keyset('n', 'gD', vim.lsp.buf.declaration, opts)
                    keyset('n', 'gd', vim.lsp.buf.definition, opts)
                    keyset('n', 'gt', vim.lsp.buf.type_definition, opts)
                    keyset('n', 'gi', vim.lsp.buf.implementation, opts)
                    keyset('n', 'gr', vim.lsp.buf.references, opts)

                    keyset('n', '<leader>dn', vim.diagnostic.goto_next, opts)
                    keyset('n', '<leader>dp', vim.diagnostic.goto_prev, opts)

                    keyset('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    keyset('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    keyset('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    keyset('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    keyset('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    keyset({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    keyset({ 'n', 'v' }, '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                        -- ensure always go back to normal mode
                        vim.api.nvim_input('<ESC>')
                    end, opts)
                end,
            })
        end,
    },
}
