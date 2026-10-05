-- Tabline support
-- https://github.com/akinsho/bufferline.nvim
local bg_hl = '#2A2A37'

return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    -- Ignore 'keys' property and always load the plugin on start.
    lazy = false,
    opts = {
        options = {
            show_buffer_close_icons = false,
            tab_size = 10,
            max_name_length = 25,
            separator_style = 'slant',
            offsets = {
                {
                    filetype = 'neo-tree',
                    text = 'File Explorer',
                    highlight = 'Directory',
                    separator = true,
                },
            },
        },
        highlights = {
            buffer_selected = {
                bold = true,
                italic = false,
                bg = bg_hl,
            },
            modified_selected = {
                bg = bg_hl,
            },
            separator_selected = {
                bg = bg_hl,
            },
        },
    },
    keys = {
        { '<A-1>', '<cmd>BufferLineGoToBuffer 1<cr>', silent = true },
        { '<A-2>', '<cmd>BufferLineGoToBuffer 2<cr>', silent = true },
        { '<A-3>', '<cmd>BufferLineGoToBuffer 3<cr>', silent = true },
        { '<A-4>', '<cmd>BufferLineGoToBuffer 4<cr>', silent = true },
        { '<A-5>', '<cmd>BufferLineGoToBuffer 5<cr>', silent = true },
        { '<A-6>', '<cmd>BufferLineGoToBuffer 6<cr>', silent = true },
        { '<A-7>', '<cmd>BufferLineGoToBuffer 7<cr>', silent = true },
        { '<A-8>', '<cmd>BufferLineGoToBuffer 8<cr>', silent = true },
        { '<A-9>', '<cmd>BufferLineGoToBuffer 9<cr>', silent = true },
        { '<A-0>', '<cmd>BufferLineGoToBuffer 0<cr>', silent = true },
    },
}
