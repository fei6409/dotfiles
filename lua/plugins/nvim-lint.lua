-- lightweight linter
-- https://github.com/mfussenegger/nvim-lint
return {
    'mfussenegger/nvim-lint',
    event = 'VeryLazy',
    config = function()
        local lint = require('lint')

        -- ignore undefined variable 'vim'
        lint.linters.luacheck.args = {
            '--globals',
            'vim',
        }

        -- skip shellcheck as bashls runs it
        lint.linters_by_ft = {
            lua = { 'luacheck' },
            -- markdown = { 'vale' },
        }

        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            group = vim.api.nvim_create_augroup('fei_lint', { clear = true }),
            callback = function() lint.try_lint() end,
        })
    end,
}
