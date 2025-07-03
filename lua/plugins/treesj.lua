-- Split/join code blocks and arrays etc.
-- https://github.com/Wansmer/treesj
return {
    'Wansmer/treesj',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    keys = {
        { '<leader>sj', '<cmd>TSJToggle<cr>', desc = 'TreeSJ: Toggle split/join' },
        {
            '<leader>sJ',
            function()
                require('treesj').toggle { split = { recursive = true } }
            end,
            desc = 'TreeSJ: Toggle split/join (recursive)',
        },
    },
    opts = {
        use_default_keymaps = false,
    },
}
