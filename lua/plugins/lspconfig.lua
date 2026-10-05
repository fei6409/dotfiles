-- LSP configuration
-- https://github.com/neovim/nvim-lspconfig

---@class LspSpec
---@field bin? string Binary name if different from LSP server name.
---@field config? table Additional LSP settings passed to vim.lsp.config.

---@type table<string, LspSpec>
local servers = {
    bashls = {
        bin = 'bash-language-server',
        config = {
            filetypes = { 'sh', 'zsh', 'bash' },
            settings = {
                bashIde = {
                    -- Ignore SC2034: foo appears unused. Verify it or export it.
                    shellcheckArguments = '-e SC2034,',
                },
            },
        },
    },
    clangd = {
        bin = 'clangd',
        config = {
            cmd = {
                'clangd',
                '--clang-tidy',
                '--background-index',
                '--completion-style=detailed',
            },
        },
    },
    lua_ls = {
        bin = 'lua-language-server',
    },
    ruff = {
        bin = 'ruff',
    },
    rust_analyzer = {
        bin = 'rust-analyzer',
    },
    yamlls = {
        bin = 'yaml-language-server',
    },
}

-- Collect servers available on host vs missing
local lsp_enabled = {}
local lsp_missing = {}

for name, spec in pairs(servers) do
    local bin = spec.bin or name
    if vim.fn.executable(bin) == 1 then
        table.insert(lsp_enabled, name)
    else
        table.insert(lsp_missing, name)
    end
end

return {
    {
        'mason-org/mason.nvim',
        cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', 'MasonUninstall', 'MasonLog' },
        opts = {},
    },
    {
        'mason-org/mason-lspconfig.nvim',
        cond = #lsp_missing > 0,
        event = 'VeryLazy',
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        opts = {
            ensure_installed = lsp_missing,
            automatic_enable = true,
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'saghen/blink.cmp',
        },
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            -- Apply custom configs to servers.
            for name, spec in pairs(servers) do
                if spec.config then vim.lsp.config(name, spec.config) end
            end

            -- Enable only servers available on host.
            vim.lsp.enable(lsp_enabled)

            -- Show error codes on non-current lines; expand full messages via virtual_lines on current line.
            vim.diagnostic.config {
                severity_sort = true,
                virtual_text = {
                    current_line = false,
                    format = function(d) return d.code and string.format('[%s]', d.code) or '' end,
                },
                virtual_lines = {
                    current_line = true,
                    format = function(d) return d.code and string.format('[%s] %s', d.code, d.message) or d.message end,
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
                    -- "[d"   (Normal)         |vim.diagnostic.jump({ count = -1 })|
                    -- "]d"   (Normal)         |vim.diagnostic.jump({ count = 1 })|
                    -- "gd"   (Normal)         Go to local definition
                    -- "gD"   (Normal)         Go to global definition
                    -- "K"    (Normal)         |vim.lsp.buf.hover()|
                    -- <C-s>  (Insert)         |vim.lsp.buf.signature_help()|

                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    local keyset = vim.keymap.set
                    local opts = function(desc) return { buffer = args.buf, silent = true, desc = desc } end

                    -- Custom keymaps:
                    keyset('n', 'gk', vim.diagnostic.open_float, opts('LSP: Show line diagnostics'))
                    keyset('n', 'grd', vim.lsp.buf.definition, opts('LSP: Go to definition'))
                    keyset('n', 'grt', vim.lsp.buf.type_definition, opts('LSP: Go to type definition'))

                    if client and client:supports_method('textDocument/inlayHint', args.buf) then
                        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                        keyset('n', 'grh', function()
                            local is_enabled = vim.lsp.inlay_hint.is_enabled { bufnr = args.buf }
                            vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = args.buf })
                        end, opts('LSP: Toggle inlay hints'))
                    end

                    -- Opt out of 'formatexpr'
                    vim.bo[args.buf].formatexpr = nil
                end,
            })
        end,
    },
}
