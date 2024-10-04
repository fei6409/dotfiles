-- Add surrounding pairs (quotes, braces)
-- https://github.com/kylechui/nvim-surround
return {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
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
