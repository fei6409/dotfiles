-- Smart colorcolumn highlighting
-- https://github.com/m4xshen/smartcolumn.nvim
return {
    'm4xshen/smartcolumn.nvim',
    opts = {
        colorcolumn = { '80', '100' },
        custom_colorcolumn = {
            gitcommit = '75',
        },
    },
    enabled = false,
}
