-- Tabline support
-- https://github.com/akinsho/bufferline.nvim
BG_HL = '#2A2A37'

return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        -- Seems mason.nvim needs to go first, or race can happen and lead to
        -- following errors:
        -- Spawning language server with cmd: `xxx-server` failed.
        -- The language server is either not installed, missing from PATH, or
        -- not executable.
        'williamboman/mason.nvim',
    },
    -- Ignore 'keys' property and always load the plugin on start.
    lazy = false,
    opts = {
        options = {
            show_buffer_close_icons = false,
            tab_size = 10,
            max_name_length = 25,
            separator_style = 'slant',
        },
        highlights = {
            buffer_selected = {
                bold = true,
                italic = false,
                bg = BG_HL,
            },
            modified_selected = {
                bg = BG_HL,
            },
            separator_selected = {
                bg = BG_HL,
            },
        },
    },
    keys = {
        { '<A-1>', '<cmd>BufferLineGoToBuffer 1<CR>', silent = true },
        { '<A-2>', '<cmd>BufferLineGoToBuffer 2<CR>', silent = true },
        { '<A-3>', '<cmd>BufferLineGoToBuffer 3<CR>', silent = true },
        { '<A-4>', '<cmd>BufferLineGoToBuffer 4<CR>', silent = true },
        { '<A-5>', '<cmd>BufferLineGoToBuffer 5<CR>', silent = true },
        { '<A-6>', '<cmd>BufferLineGoToBuffer 6<CR>', silent = true },
        { '<A-7>', '<cmd>BufferLineGoToBuffer 7<CR>', silent = true },
        { '<A-8>', '<cmd>BufferLineGoToBuffer 8<CR>', silent = true },
        { '<A-9>', '<cmd>BufferLineGoToBuffer 9<CR>', silent = true },
        { '<A-0>', '<cmd>BufferLineGoToBuffer 0<CR>', silent = true },
    },
}
