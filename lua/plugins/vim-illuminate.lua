-- Auto-highlight other uses of the word under the cursor
-- https://github.com/RRethy/vim-illuminate

return {
    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    init = function()
        vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'LspReferenceText' })
        vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'LspReferenceRead' })
        vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'LspReferenceWrite' })
    end,
    -- `opt = {}` doesn't work.
    -- see https://github.com/RRethy/vim-illuminate/issues/112
    config = function()
        require('illuminate').configure {
            delay = 500,
        }
    end,
}
