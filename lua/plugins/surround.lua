-- Surrounding actions (parenthesis, quotes, etc.)
-- https://github.com/kylechui/nvim-surround
return {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    version = 'v3',
    opts = {
        keymaps = {
            -- insert = '<C-g>s',
            -- insert_line = '<C-g>S',
            normal = "'s",
            normal_cur = "'ss",
            normal_line = "'S",
            normal_cur_line = "'SS",
            visual = "'s",
            visual_line = "'S",
            delete = "'d",
            change = "'c",
            change_line = "'C",
        },
    },
}
