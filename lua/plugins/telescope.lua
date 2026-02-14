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

        -- Custom action: open multiple files if selected, otherwise open current
        local function smart_open_multi(prompt_bufnr)
            local tel_action_state = require('telescope.actions.state')
            local picker = tel_action_state.get_current_picker(prompt_bufnr)
            local selections = picker:get_multi_selection()

            if not vim.tbl_isempty(selections) then
                tel_actions.close(prompt_bufnr)
                for _, selection in ipairs(selections) do
                    local file = selection.path or selection.filename or selection[1]
                    if file then vim.cmd('edit ' .. file) end
                end
            else
                tel_actions.select_default(prompt_bufnr)
            end
        end

        require('telescope').setup {
            defaults = {
                layout_config = { height = 0.95, width = 0.9 },
                path_display = { 'filename_first' },
                mappings = {
                    i = {
                        -- Close Telescope directly (instead of back to normal mode)
                        ['<esc>'] = tel_actions.close,
                        ['<cr>'] = smart_open_multi,
                    },
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
