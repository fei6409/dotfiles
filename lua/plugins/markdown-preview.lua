-- Markdown previewer
-- https://github.com/iamcco/markdown-preview.nvim
return {
    'iamcco/markdown-preview.nvim',
    -- Fix Lazy Update error (https://github.com/iamcco/markdown-preview.nvim/issues/616):
    -- You have local changes in `xxx/nvim/lazy/markdown-preview.nvim`:
    --   * app/yarn.lock
    -- Please remove them to update.
    build = 'cd app && npm install && git restore .',
    config = function()
        vim.g.mkdp_filetypes = { 'markdown' }
        vim.g.mkdp_page_title = '**${name}**'
    end,
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
}
