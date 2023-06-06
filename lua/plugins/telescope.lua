-- fuzzy finder
return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
    config = function()
        -- Inspired by https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
        local function is_git_repo()
            vim.fn.system("git rev-parse --is-inside-work-tree")
            return vim.v.shell_error == 0
        end
        local function get_git_root()
            local dot_git_path = vim.fn.finddir(".git", ".;")
            return vim.fn.fnamemodify(dot_git_path, ":h")
        end
        -- If in a git project directory, find_files() will start from the git root.
        local project_files = function()
            local opts = {}
            if is_git_repo() then opts = { cwd = get_git_root() } end
            require('telescope.builtin').find_files(opts)
        end

        local keyset = vim.keymap.set
        keyset('n', '<leader>ss', require('telescope.builtin').grep_string,
            { desc = '[S]earch current [S]tring' })
        keyset('n', '<leader>sg', require('telescope.builtin').live_grep,
            { desc = '[S]earch by rip[G]rep' })
        keyset('n', '<leader>sh', require('telescope.builtin').help_tags,
            { desc = '[S]earch [H]elp' })
        keyset('n', '<leader>sk', require('telescope.builtin').keymaps,
            { desc = '[S]earch [K]eymaps' })
        keyset('n', '<leader>sd', require('telescope.builtin').diagnostics,
            { desc = '[S]earch [D]iagnostics' })
        keyset('n', '<leader>sf', project_files,
            { desc = '[S]earch [F]iles Modified: search from repo root when in a Git repo' })
        keyset('n', '<leader>s/', function()
                local opt = require('telescope.themes').get_dropdown { previewer = false, }
                require('telescope.builtin').current_buffer_fuzzy_find(opt)
            end,
            { desc = '[S]earch in [/]current buffer' })

        require('telescope').setup {
            defaults = {
                layout_config = { height = 0.95, width = 0.9 },
                -- Close Telescope directly (instead of back to normal mode)
                mappings = {
                    i = {
                        ['<esc>'] = 'close',
                    },
                },
            },
        }
        require('telescope').load_extension('fzf')
    end,
}
