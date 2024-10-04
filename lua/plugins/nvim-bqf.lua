-- Enhanced Neovim quickfix support
-- https://github.com/kevinhwang91/nvim-bqf
return {
    'kevinhwang91/nvim-bqf',
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
}
