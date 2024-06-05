-- buffer line
return {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('bufferline').setup {
            options = {
                modified_icon = '*',
                show_buffer_icons = false,
                show_buffer_close_icons = false,
                show_close_icon = false,
            },
            highlights = {
                buffer_selected = { italic = false },
                diagnostic_selected = { italic = false },
            },
        }
    end,
    enabled = false,
}
