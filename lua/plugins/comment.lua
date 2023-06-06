-- commenter
return {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup {
            toggler = { line = '\\', block = '<leader>\\' },
            opleader = { line = '\\', block = '<leader>\\' },
            mappings = { extra = false },
        }
    end,
}
