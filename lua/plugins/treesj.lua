-- Split/join code blocks and arrays etc.
-- https://github.com/Wansmer/treesj
return {
    'Wansmer/treesj',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    keys = {
        { '<leader>sj', '<cmd>TSJToggle<CR>', desc = 'TreeSJ: Toggle split/join' },
    },
    opts = {
        use_default_keymaps = false,
    },
}
