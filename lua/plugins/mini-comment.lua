-- Fast and familiar per-line commenting
-- https://github.com/nvim-mini/mini.comment
return {
    'nvim-mini/mini.comment',
    event = 'VeryLazy',
    opts = {
        mappings = {
            comment = '\\',
            comment_line = '\\',
            comment_visual = '\\',
            textobject = '\\',
        },
    },
}
