-- Git integration for Vim
-- https://github.com/tpope/vim-fugitive
return {
    'tpope/vim-fugitive',
    keys = {
        -- o    jump to patch or blob in horizontal split
        -- -    reblame at commit
        -- ~    reblame at nth ancestor
        -- P    reblame at nth parent
        { '<leader>b', '<cmd>Git blame<cr>' },
        { 'q', '<cmd>bwipeout<cr>', ft = 'fugitiveblame', nowait = true, silent = true, desc = 'Close fugitive blame' },
        { '<C-c>', '<cmd>bwipeout<cr>', ft = 'fugitiveblame', nowait = true, silent = true, desc = 'Close fugitive blame' },
    },
    cmd = { 'Git', 'G' },
    -- enabled = false,
}
