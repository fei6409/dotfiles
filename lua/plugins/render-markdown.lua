-- Markdown support
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    keys = {
        { '<leader>p', '<cmd>RenderMarkdown buf_toggle<cr>', ft = 'markdown', desc = 'Render Markdown preview' },
    },
    opts = {
        -- disabled on start
        enabled = false,
        completions = { lsp = { enabled = true } },
    },
}
