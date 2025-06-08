-- Git interface for Neovim
-- https://github.com/NeogitOrg/neogit
return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim', -- required
        'sindrets/diffview.nvim', -- optional - Diff integration
        'nvim-telescope/telescope.nvim', -- optional
    },
    cmd = { 'Neogit' },
    keys = {
        { '<leader>g', '<cmd>Neogit<CR>', desc = 'Open Neogit' },
    },
    opts = {
        graph_style = 'unicode',
    },
    enabled = false,
}
