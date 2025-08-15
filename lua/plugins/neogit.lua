-- Git interface for Neovim
-- https://github.com/NeogitOrg/neogit
return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim', -- required
        -- 'sindrets/diffview.nvim', -- optional - Diff integration
        'nvim-telescope/telescope.nvim', -- optional
    },
    cmd = { 'Neogit' },
    keys = {
        { '<leader>g', '<cmd>Neogit<cr>', desc = 'Neogit' },
    },
    opts = {
        graph_style = 'unicode',
        integrations = {
            -- use telescope for menu selection rather than vim.ui.select.
            telescope = true,
        },
        commit_editor = {
            staged_diff_split_kind = 'auto',
        },
    },
}
