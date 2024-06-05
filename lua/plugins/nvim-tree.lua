-- File explorer
return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {
        { '<leader>t', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle Nvim-Tree' },
    },
}
