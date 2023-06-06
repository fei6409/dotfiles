-- status line & buffer line
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = 'onedark',
            always_divide_middle = false,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff' },
            lualine_c = {
                {
                    'filename',
                    path = 1, -- Relative path
                },
            },
            lualine_x = { 'encoding' },
            lualine_y = { 'filetype' },
            lualine_z = { 'progress', 'location' },
        },
        tabline = {
            lualine_a = {
                {
                    'buffers',
                    icons_enabled = false,
                    symbols = { modified = '*', alternate_file = '' },
                },
            },
        },
    },
}
