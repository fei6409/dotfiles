-- Neovim keymap lookup
-- https://github.com/folke/which-key.nvim
return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        preset = 'modern',
    },
    keys = {
        {
            '<leader>?',
            function() require('which-key').show { global = false } end,
            desc = 'which-key: Buffer Local Keymaps',
        },
    },
}
