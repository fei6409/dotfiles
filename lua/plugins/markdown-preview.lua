-- markdown-preview.nvim
return {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    config = function()
        vim.g.mkdp_filetypes = { 'markdown' }
        vim.g.mkdp_page_title = '**${name}**'
    end,
    ft = { 'markdown' },
}
