-- Code commenter
-- https://github.com/numToStr/Comment.nvim
return {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {
        toggler = { line = '\\', block = '<leader>\\' },
        opleader = { line = '\\', block = '<leader>\\' },
        mappings = { extra = false },
    },
}
