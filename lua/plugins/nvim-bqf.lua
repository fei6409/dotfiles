-- Enhanced Neovim quickfix support
-- https://github.com/kevinhwang91/nvim-bqf
return {
    'kevinhwang91/nvim-bqf',
    event = 'VeryLazy',
    opts = {
        auto_resize_height = true,
        func_map = {
            -- Avoid opening items in new tabs.
            tab = '',
            tabb = '',
            tabc = '',
        },
    },
    ft = { 'qf' },
    keys = {
        { 'q', '<cmd>close<cr>', ft = 'qf', nowait = true, silent = true, desc = 'Close quickfix' },
        { '<C-c>', '<cmd>close<cr>', ft = 'qf', nowait = true, silent = true, desc = 'Close quickfix' },
    },
}
