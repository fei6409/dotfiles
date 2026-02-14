-- Git signs and hunk operations
-- https://github.com/lewis6991/gitsigns.nvim
return {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
        -- Use committer_time instead of author_time
        current_line_blame_formatter = '<abbrev_sha> <author> (<committer_time:%R>) | <summary>',
    },
    keys = {
        { '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', desc = 'Gitsigns: Stage hunk' },
        { '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<cr>', desc = 'Gitsigns: Unstage hunk' },
        { '<leader>hn', '<cmd>Gitsigns next_hunk<cr>', desc = 'Gitsigns: Next hunk' },
        { '<leader>hp', '<cmd>Gitsigns prev_hunk<cr>', desc = 'Gitsigns: Previous hunk' },
        { '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Gitsigns: Reset hunk' },
        { '<leader>hv', '<cmd>Gitsigns preview_hunk<cr>', desc = 'Gitsigns: View hunk' },
        { '<leader>hb', '<cmd>Gitsigns blame<cr>', desc = 'Gitsigns: Blame' },
        { '<leader>hl', '<cmd>Gitsigns blame_line<cr>', desc = 'Gitsigns: Blame line' },
        { '<leader>ht', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = 'Gitsigns: Toggle inline blame' },
    },
}
