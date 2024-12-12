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
        highlight = {
            enable = true,
            -- disable slow treesitter highlight for large files
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        },
        -- Experimental feature
        indent = { enable = true },
    },
}
