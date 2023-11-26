-- Cursor motion
return {
    'ggandor/leap.nvim',
    keys = {
        { '<leader>sl', '<Plug>(leap-forward-to)', mode = { 'n', 'x', 'o' }, desc = 'Leap forward to' },
        { '<leader>sL', '<Plug>(leap-backward-to)', mode = { 'n', 'x', 'o' }, desc = 'Leap backward to' },
    },
    config = true,
}
