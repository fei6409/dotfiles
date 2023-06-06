-- nvim tree-sitter interface and highlighting
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        -- the five listed parsers should always be installed
        ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
        auto_install = true,
        highlight = { enable = true },
    },
}
