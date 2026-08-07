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
        config = {
            settings = {
                Lua = {
                    -- Specify the Lua version (usually LuaJIT for Neovim)
                    runtime = { version = 'LuaJIT' },
                    -- Recognize the 'vim' global variable
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

            -- Show shellcheck error codes in diagnostics.
            -- See: https://github.com/bash-lsp/bash-language-server/issues/752
            vim.diagnostic.config {
                virtual_text = {
                    format = function(args) return string.format('%s [%s]', args.message, args.code) end,
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
                    local opts = function(desc) return { buffer = args.buf, silent = true, desc = desc } end

                    keyset('n', 'gk', vim.diagnostic.open_float, opts('vim.diagnostic.open_float()'))
                    keyset('n', 'grd', vim.lsp.buf.definition, opts('vim.lsp.buf.definition()'))
                    keyset('n', 'grt', vim.lsp.buf.type_definition, opts('vim.lsp.buf.type_definition()'))

                    -- Opt out of 'formatexpr'
                    vim.bo[args.buf].formatexpr = nil
                end,
            })
        end,
    },
}
