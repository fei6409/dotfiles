-- colorscheme
return {
    'folke/tokyonight.nvim',
    -- make sure the colorscheme is loaded first since start plugins can
    -- possibly change existing highlight groups
    priority = 1000,
    init = function()
        vim.cmd.colorscheme('tokyonight-night')
    end,
    enabled = false,
}
