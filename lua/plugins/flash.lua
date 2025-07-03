-- Enhanced search labels and motions
-- https://github.com/folke/flash.nvim
return {
    'folke/flash.nvim',
    opts = {
        label = {
            -- disable uppercase labels
            uppercase = false,
        },
        modes = {
            -- disable `f`, `F`, `t`, `T`, `;` and `,` motions
            char = { enabled = false },
        },
    },
    keys = {
        {
            '<C-f>',
            mode = { 'n', 'x', 'o' },
            function() require('flash').jump() end,
            desc = 'Flash: Search',
        },
        {
            '<C-f>',
            mode = { 'c' },
            function() require('flash').toggle() end,
            desc = 'Flash: Toggle Search',
        },
        {
            '<C-t>',
            mode = { 'n', 'x', 'o' },
            function() require('flash').treesitter_search() end,
            desc = 'Flash: Treesitter Search',
        },
    },
}
