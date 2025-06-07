-- LSP Formatter
-- https://github.com/stevearc/conform.nvim
return {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format { async = true }
                -- Ensure always go back to normal mode.
                vim.api.nvim_input '<ESC>'
            end,
            mode = { 'n', 'v' },
            desc = 'Conform: Format Buffer',
        },
    },
    opts = {
        formatters_by_ft = {
            c = { 'clang-format' },
            cpp = { 'clang-format' },
            go = { 'gofmt' },
            lua = { 'stylua' },
            markdown = { 'deno_fmt' },
            python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
            rust = { 'rustfmt' },
            sh = { 'shfmt' },
            yaml = { 'yq', 'yamlfmt', stop_after_first = true },
            zsh = { 'shfmt' },
        },
        formatters = {
            shfmt = {
                -- Indent 2 spaces.
                prepend_args = { '-i', '2' },
            },
            deno_fmt = {
                append_args = { '--indent-width', '4' },
            },
        },
        default_format_opts = {
            -- Fall back to LSP formatting if no formatters are available.
            lsp_format = 'fallback',
        },
        notify_no_formatters = true,
        notify_on_error = true,
    },
    init = function()
        -- Overwrite the default formatexpr for `gq`.
        vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
