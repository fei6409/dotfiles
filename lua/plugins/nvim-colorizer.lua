-- Highlight color code
-- https://github.com/catgoose/nvim-colorizer.lua
return {
    'catgoose/nvim-colorizer.lua',
    opts = {
        filetypes = {
            'css',
            'html',
            'log',
            'lua',
            'markdown',
            'sh',
            'text',
            'vim',
            'zsh',
        },
        user_default_options = {
            xterm = true,
        },
    },
}
