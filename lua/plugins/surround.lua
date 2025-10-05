-- Surrounding actions (parenthesis, quotes, etc.)
-- https://github.com/kylechui/nvim-surround
return {
    'kylechui/nvim-surround',
    opts = {
        keymaps = {
            insert = "<C-'>a",
            insert_line = "<C-'>A",
            normal = "'a",
            normal_cur = "'aa",
            normal_line = "'A",
            normal_cur_line = "'AA",
            visual = "'a",
            visual_line = "'A",
            delete = "'d",
            change = "'c",
            change_line = "'C",
        },
    },
}
