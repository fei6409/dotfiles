-- Markdown support
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    keys = {
        { '<leader>p', '<cmd>RenderMarkdown preview<cr>', ft = 'markdown', desc = 'Render Markdown preview' },
    },
    opts = {
        completions = { lsp = { enabled = true } },
    },
}
