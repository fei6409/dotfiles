-- vim-fugitive for its git blame feature
return {
    'tpope/vim-fugitive',
    keys = {
        -- o    jump to patch or blob in horizontal split
        -- -    reblame at commit
        -- ~    reblame at nth ancestor
        -- P    reblame at nth parent
        { '<leader>b', '<cmd>Git blame<CR>' },
    },
}
