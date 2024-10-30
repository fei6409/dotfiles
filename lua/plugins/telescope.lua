-- Fuzzy finder
-- https://github.com/nvim-telescope/telescope.nvim
return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
    event = 'VeryLazy',
    config = function()
        local tel_actions = require 'telescope.actions'
        local tel_builtin = require 'telescope.builtin'
        -- Inspired by https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
        local function is_git_repo()
            vim.fn.system 'git rev-parse --is-inside-work-tree'
            return vim.v.shell_error == 0
        end
        local function get_git_root()
            local dot_git_path = vim.fn.finddir('.git', '.;')
            return vim.fn.fnamemodify(dot_git_path, ':h')
        end

        local keyset = vim.keymap.set
        keyset('n', '<leader>ss', tel_builtin.grep_string, { desc = '[S]earch current [S]tring' })
        keyset('n', '<leader>sg', tel_builtin.live_grep, { desc = '[S]earch by rip[G]rep' })
        keyset('n', '<leader>sh', tel_builtin.help_tags, { desc = '[S]earch [H]elp' })
        keyset('n', '<leader>sk', tel_builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        keyset('n', '<leader>sd', tel_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        keyset('n', '<leader>sc', tel_builtin.commands, { desc = '[S]earch [C]ommands' })
        keyset('n', '<leader>sr', tel_builtin.registers, { desc = '[S]earch [R]egisters' })
        keyset('n', '<leader>st', tel_builtin.treesitter, { desc = '[S]earch [T]reesitter' })
        keyset('n', '<leader>se', tel_builtin.spell_suggest, { desc = '[S]earch [E]nglish suggests' })
        keyset('n', '<leader>s/', tel_builtin.current_buffer_fuzzy_find, { desc = '[S]earch in [/]current buffer' })
        keyset('n', '<leader>sld', tel_builtin.lsp_definitions, { desc = '[S]earch [L]SP [D]efinitions' })
        keyset('n', '<leader>sli', tel_builtin.lsp_implementations, { desc = '[S]earch [L]SP [I]mplementations' })
        keyset('n', '<leader>slr', tel_builtin.lsp_references, { desc = '[S]earch [L]SP [R]eferences' })
        keyset('n', '<leader>sls', tel_builtin.lsp_document_symbols, { desc = '[S]earch [L]SP [S]ymbols' })
        keyset('n', '<leader>sf', function()
            local opts = {}
            if is_git_repo() then
                opts = { cwd = get_git_root() }
            end
            tel_builtin.find_files(opts)
        end, { desc = '[S]earch [F]iles Modified: Find files from Git repo root when possible' })

        require('telescope').setup {
            defaults = {
                layout_config = { height = 0.95, width = 0.9 },
                -- Close Telescope directly (instead of back to normal mode)
                mappings = {
                    i = { ['<esc>'] = 'close' },
                },
            },
            pickers = {
                -- current_buffer_fuzzy_find = {
                --     layout_strategy = 'vertical',
                --     previewer = false,
                -- },
                -- Anchor the current search results and re-perform fuzzy search.
                live_grep = {
                    mappings = {
                        i = { ['<c-f>'] = tel_actions.to_fuzzy_refine },
                    },
                },
                lsp_document_symbols = {
                    mappings = {
                        i = { ['<c-f>'] = tel_actions.to_fuzzy_refine },
                    },
                },
            },
        }
        require('telescope').load_extension 'fzf'
    end,
}
