-- gitsigns.nvim
return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup {
        }
        local keyset = vim.keymap.set
        local gs = package.loaded.gitsigns
        keyset('n', '<leader>gb', gs.toggle_current_line_blame)
    end,
}
