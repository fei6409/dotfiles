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
            'git_config',
            'git_rebase',
            'gitcommit',
            'lua',
            'python',
            'ssh_config',
            'vim',
            'vimdoc',
        },
        auto_install = true,
        highlight = { enable = true },
        -- Experimental feature
        indent = { enable = true },
    },
}
