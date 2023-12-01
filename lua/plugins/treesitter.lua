-- nvim tree-sitter interface and highlighting
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
        -- the first five listed parsers should always be installed
        ensure_installed = {
            'c', 'lua', 'vim', 'vimdoc', 'query',
            'bash', 'cpp', 'devicetree', 'git_config', 'git_rebase', 'gitcommit',
            'go', 'kconfig', 'make', 'markdown', 'python', 'ruby', 'yaml',
        },
        auto_install = true,
        highlight = { enable = true },
    },
}
