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
                require('conform').format({ async = true }, function(err, did_edit)
                    if err ~= nil then
                        print('Format error: ' .. tostring(err))
                    elseif did_edit == true then
                        print('Formatted')
                    else
                        print('Not formatted')
                    end
                    -- Ensure always go back to normal mode.
                    vim.api.nvim_input('<ESC>')
                end)
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
            javascript = { 'deno_fmt' },
            json = { 'jq' },
            lua = { 'stylua' },
            markdown = { 'deno_fmt' },
            python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
            rust = { 'rustfmt' },
            sh = { 'shfmt' },
            typescript = { 'deno_fmt' },
            yaml = { 'yamlfmt' },
            zsh = { 'shfmt' },
        },
        formatters = {
            shfmt = {
                -- Indent 2 spaces to follow Google Shell Style Guide:
                -- https://google.github.io/styleguide/shellguide.html#indentation
                -- Other arguments:
                --   -bn: Binary ops like && and | may start a line.
                --   -ci: Switch cases will be indented.
                --   -sr: Redirect operators will be followed by a space.
                append_args = { '-i', '2', '-bn', '-ci', '-sr' },
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
