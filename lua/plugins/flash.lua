-- Enhanced search labels and motions
-- https://github.com/folke/flash.nvim
return {
    'folke/flash.nvim',
    opts = {},
    keys = {
        {
            '<C-f>',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').jump()
            end,
            desc = 'Flash Search',
        },
        {
            '<C-f>',
            mode = { 'c' },
            function()
                require('flash').toggle()
            end,
            desc = 'Toggle Flash Search',
        },
    },
}
