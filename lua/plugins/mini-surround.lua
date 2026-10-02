-- Surrounding actions (parenthesis, quotes, etc.)
-- https://github.com/nvim-mini/mini.surround
return {
    'nvim-mini/mini.surround',
    event = 'VeryLazy',
    opts = {
        mappings = {
            add = "'s",
            delete = "'d",
            replace = "'c",
        },
    },
}
