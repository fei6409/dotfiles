-- Visual counter for matched search result
-- https://github.com/kevinhwang91/nvim-hlslens
return {
    'kevinhwang91/nvim-hlslens',
    event = 'VeryLazy',
    init = function()
        vim.api.nvim_set_hl(0, 'HlSearchLensNear', { link = 'Visual' })
    end,
    opts = {
        nearest_only = true,
    },
}
