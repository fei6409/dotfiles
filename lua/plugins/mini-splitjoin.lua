-- Split/join code blocks and arrays etc.
-- https://github.com/nvim-mini/mini.splitjoin
return {
    'nvim-mini/mini.splitjoin',
    event = 'VeryLazy',
    opts = {
        mappings = {
            toggle = '<leader>sj',
            split = '',
            join = '',
        },
    },
}
