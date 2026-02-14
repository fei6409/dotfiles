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
    keys = {
        { '<leader>ss', '<cmd>Telescope grep_string<cr>', desc = '[S]earch current [S]tring' },
        { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = '[S]earch by rip[G]rep' },
        { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = '[S]earch [H]elp' },
        { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = '[S]earch [K]eymaps' },
        { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = '[S]earch [D]iagnostics' },
        { '<leader>sc', '<cmd>Telescope commands<cr>', desc = '[S]earch [C]ommands' },
        { '<leader>sr', '<cmd>Telescope registers<cr>', desc = '[S]earch [R]egisters' },
        { '<leader>st', '<cmd>Telescope treesitter<cr>', desc = '[S]earch [T]reesitter' },
        { '<leader>se', '<cmd>Telescope spell_suggest<cr>', desc = '[S]earch [E]nglish suggests' },
        { '<leader>s/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[S]earch in [/]current buffer' },
        { '<leader>sld', '<cmd>Telescope lsp_definitions<cr>', desc = '[S]earch [L]SP [D]efinitions' },
        { '<leader>sli', '<cmd>Telescope lsp_implementations<cr>', desc = '[S]earch [L]SP [I]mplementations' },
        { '<leader>slr', '<cmd>Telescope lsp_references<cr>', desc = '[S]earch [L]SP [R]eferences' },
        { '<leader>sls', '<cmd>Telescope lsp_document_symbols<cr>', desc = '[S]earch [L]SP [S]ymbols' },
    },
    config = function()
        local tel_actions = require('telescope.actions')
        local tel_builtin = require('telescope.builtin')

        -- Git root detection (Neovim 0.10+)
        local function get_git_root() return vim.fs.root(0, '.git') end

        local keyset = vim.keymap.set
        keyset('n', '<leader>sf', function()
            if get_git_root() then
                tel_builtin.git_files()
            else
                tel_builtin.find_files()
            end
        end, { desc = '[S]earch [F]iles (Git files first)' })

        keyset('n', '<leader>sF', function()
            local root = get_git_root()
            if root then
                tel_builtin.find_files {
                    cwd = root,
                    prompt_title = 'Find Files from Git root',
                }
            end
        end, { desc = '[S]earch [F]iles globally from Git repo root' })

        keyset('n', '<leader>sG', function()
            local root = get_git_root()
            if root then
                tel_builtin.live_grep {
                    cwd = root,
                    prompt_title = 'Live Grep from Git root',
                }
            end
        end, { desc = '[S]earch by rip[G]rep globally from Git repo root' })

        require('telescope').setup {
            defaults = {
                layout_config = { height = 0.95, width = 0.9 },
                -- Close Telescope directly (instead of back to normal mode)
                mappings = {
                    i = { ['<esc>'] = 'close' },
                },
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--trim', -- trim indentation
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
        require('telescope').load_extension('fzf')
    end,
}
