-- Neovim tree-sitter interface and highlighting
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    -- event = 'VeryLazy',
    opts = {
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
