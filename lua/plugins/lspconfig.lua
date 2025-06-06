-- LSP configuration
-- https://github.com/neovim/nvim-lspconfig

-- Setup references: https://youtu.be/puWgHa7k3SY
local lsp_servers = {
    'bashls',
    'clangd',
    'denols',
    'jsonls',
    'lua_ls',
    'marksman',
    'ruff',
    'rust_analyzer',
    'yamlls',
}

-- Add gopls if Go is installed
if vim.fn.executable 'go' == 1 then
    table.insert(lsp_servers, 'gopls')
end

-- LSP servers with additional configs
local lsp_configs = {
    bashls = {
        filetypes = { 'sh', 'zsh', 'bash' },
        settings = {
            bashIde = {
                -- Ignore SC2034: foo appears unused. Verify it or export it.
                shellcheckArguments = '-e SC2034,',
            },
        },
    },
    lua_ls = {
        settings = {
            Lua = {
                -- Specify the Lua version (usually LuaJIT for Neovim)
                runtime = { version = 'LuaJIT' },
                --  Recognize the 'vim' global variable
                diagnostics = { globals = { 'vim' } },
                -- Include Neovim runtime files in the workspace
                workspace = {
                    library = { vim.env.VIMRUNTIME },
                    -- Disable third-party checks. See: https://github.com/neovim/nvim-lspconfig/issues/1700
                    checkThirdParty = false,
                },
                -- Disable telemetry data
                telemetry = { enable = false },
            },
        },
    },
}

return {
    {
        'mason-org/mason-lspconfig.nvim',
        event = 'VeryLazy',
        dependencies = {
            { 'mason-org/mason.nvim', opts = {} },
            'neovim/nvim-lspconfig',
        },
        opts = { ensure_installed = lsp_servers },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- 'mason-org/mason-lspconfig.nvim',
            'saghen/blink.cmp',
        },
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            --  Enable all LSP servers at once (requires Neovim 0.11+).
            vim.lsp.enable(lsp_servers)

            for name, conf in pairs(lsp_configs) do
                vim.lsp.config(name, conf)
            end

            -- Show shellcheck error codes in diagnostics.
            -- See: https://github.com/bash-lsp/bash-language-server/issues/752
            vim.diagnostic.config {
                virtual_text = {
                    format = function(args)
                        return string.format('%s [%s]', args.message, args.code)
                    end,
                },
            }

            -- Use LspAttach autocommand to map keys after the language server attaches to the buffer.
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(args)
                    -- Default keymaps:
                    -- "grn"  (Normal)         |vim.lsp.buf.rename()|
                    -- "gra"  (Normal/Visual)  |vim.lsp.buf.code_action()|
                    -- "grr"  (Normal)         |vim.lsp.buf.references()|
                    -- "gri"  (Normal)         |vim.lsp.buf.implementation()|
                    -- "gO"   (Normal)         |vim.lsp.buf.document_symbol()|
                    -- "[d"   (Normal)         |vim.diagnostic.goto_next()|
                    -- "]d"   (Normal)         |vim.diagnostic.goto_prev()|
                    -- "gd"   (Normal)         Go to local definition
                    -- "gD"   (Normal)         Go to global definition
                    -- "K"    (Normal)         |vim.lsp.buf.hover()|
                    -- <C-s>  (Insert)         |vim.lsp.buf.signature_help()|
                    --
                    -- Custom keymaps:
                    -- "gk"   (Normal)         |vim.diagnostic.open_float()|
                    -- "grd"  (Normal)         |vim.lsp.buf.definition()|
                    -- "grt"  (Normal)         |vim.lsp.buf.type_definition()|

                    local keyset = vim.keymap.set
                    local opts = function(desc)
                        return { buffer = args.buf, silent = true, desc = desc }
                    end

                    keyset('n', 'gk', vim.diagnostic.open_float, opts 'Diagnostic open float window')
                    keyset('n', 'grd', vim.lsp.buf.definition, opts 'vim.lsp.buf.definition()')
                    keyset('n', 'grt', vim.lsp.buf.type_definition, opts 'vim.lsp.buf.type_definition()')

                    -- Opt out of 'formatexpr'
                    vim.bo[args.buf].formatexpr = nil
                end,
            })
        end,
    },
}
