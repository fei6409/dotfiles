-- surrounder
return {
    'kylechui/nvim-surround',
    version = '*',
    opts = {
        -- `ys` is too far :p
        keymaps = {
            normal = 'ts',
            normal_cur = 'tss',
            normal_line = 'tS',
            normal_cur_line = 'tSS',
        },
    },
}
