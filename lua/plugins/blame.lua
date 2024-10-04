-- Fugitive-style Git blame visualizer
-- https://github.com/FabijanZulj/blame.nvim/
return {
    'FabijanZulj/blame.nvim',
    -- 'fei6409/blame.nvim',
    -- branch = 'focus_blame',
    keys = {
        {
            '<leader>b',
            function()
                vim.cmd 'BlameToggle'
            end,
            desc = 'Git blame in window vsplit',
        },
    },
    opts = {
        date_format = '%Y-%m-%d',
        merge_consecutive = true,
        focus_blame = true,
        mappings = {
            stack_pop = { '<BS>', '<S-TAB>' },
        },
    },
}
