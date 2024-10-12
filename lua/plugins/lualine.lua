-- Status line and tab/buffer line
-- https://github.com/nvim-lualine/lualine.nvim
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
    },
}
