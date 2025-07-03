-- Visual counter for matched search result
-- https://github.com/kevinhwang91/nvim-hlslens
return {
    'kevinhwang91/nvim-hlslens',
    event = 'VeryLazy',
    init = function()
        vim.api.nvim_set_hl(0, 'HlSearchLensNear', { link = 'Visual' })
    end,
    keys = {
        { '*', '*<cmd>lua require("hlslens").start()<cr>', silent = true },
        { '#', '#<cmd>lua require("hlslens").start()<cr>', silent = true },
        { 'g*', 'g*<cmd>lua require("hlslens").start()<cr>', silent = true },
        { 'g#', 'g#<cmd>lua require("hlslens").start()<cr>', silent = true },
        { 'n', 'n', silent = true },
        { 'N', 'N', silent = true },
    },
    opts = {
        nearest_only = true,
    },
}
