-- Neovim tree-sitter interface and highlighting
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    lazy = false,
    config = function()
        -- filetype -> parser name
        local languages = {
            bash = 'bash',
            c = 'c',
            dts = 'devicetree',
            gitcommit = 'gitcommit',
            gitconfig = 'git_config',
            gitrebase = 'git_rebase',
            help = 'vimdoc',
            kconfig = 'kconfig',
            lua = 'lua',
            markdown = 'markdown',
            python = 'python',
            rust = 'rust',
            sshconfig = 'ssh_config',
            starlark = 'starlark',
            toml = 'toml',
            vim = 'vim',
            yaml = 'yaml',
            zsh = 'zsh',
        }

        require('nvim-treesitter').install(vim.tbl_values(languages))
        vim.api.nvim_create_autocmd('FileType', {
            pattern = vim.tbl_keys(languages),
            callback = function(args)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
                if ok and stats and stats.size > max_filesize then return end
                vim.treesitter.start()
                vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            end,
        })
    end,
}
