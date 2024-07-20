-- nvim tree-sitter interface and highlighting
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    -- event = 'VeryLazy',
    opts = {
        -- the first five listed parsers should always be installed
        ensure_installed = {
            'bash',
            'c',
            'cpp',
            'devicetree',
            'git_config',
            'git_rebase',
            'gitcommit',
            'go',
            'json',
            'kconfig',
            'lua',
            'make',
            'markdown',
            'python',
            'query',
            'ruby',
            'ssh_config',
            'vim',
            'vimdoc',
            'yaml',
        },
        auto_install = true,
        highlight = { enable = true },
    },
}
