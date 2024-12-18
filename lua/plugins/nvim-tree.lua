-- File explorer
-- https://github.com/nvim-tree/nvim-tree.lua
return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {
        { '<leader>t', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle Nvim-Tree' },
    },
    enabled = false,
}
