-- Neovim tree-sitter interface and highlighting
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    lazy = false,
    config = function()
        local filetypes = {
            'bash',
            'c',
            'devicetree',
            'git_config',
            'git_rebase',
            'gitcommit',
            'kconfig',
            'lua',
            'markdown',
            'python',
            'rust',
            'ssh_config',
            'starlark',
            'toml',
            'vim',
            'vimdoc',
            'yaml',
            'zsh',
        }

        require('nvim-treesitter').install(filetypes)
        vim.api.nvim_create_autocmd('FileType', {
            pattern = filetypes,
            callback = function() vim.treesitter.start() end,
        })
    end,
}
