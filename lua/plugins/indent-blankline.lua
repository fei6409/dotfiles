-- visual indentation guide
return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        vim.cmd [[highlight IndentBlanklineIndent1 guibg=#181818 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent2 guibg=#0d0c0c gui=nocombine]]
        require('indent_blankline').setup {
            char = '',
            use_treesitter = true,
            char_highlight_list = {
                'IndentBlanklineIndent1',
                'IndentBlanklineIndent2',
            },
            space_char_highlight_list = {
                'IndentBlanklineIndent1',
                'IndentBlanklineIndent2',
            },
        }
    end,
}
