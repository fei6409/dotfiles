-- File explorer and editor in Neovim buffer
-- https://github.com/stevearc/oil.nvim
return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- ensure plugin is always loaded against "vim ." or ":e ." etc.
    lazy = false,
    opts = {},
    keys = {
        {
            '<leader>t',
            function()
                require('oil').toggle_float '.'
            end,
            desc = 'Oil: Toggle floating window',
        },
    },
    enabled = false,
}
