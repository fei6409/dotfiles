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
            callback = function(args)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
                if ok and stats and stats.size > max_filesize then return end
                vim.treesitter.start()
            end,
        })
    end,
}
