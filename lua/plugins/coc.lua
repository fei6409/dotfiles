-- coc.nvim
return {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
        vim.g.coc_global_extensions = {
            'coc-clangd',
            'coc-go',
            'coc-json',
            'coc-lua',
            'coc-pyright',
            'coc-sh',
            'coc-yaml',
        }

        -- Some servers have issues with backup files, see #649
        vim.opt.backup = false
        vim.opt.writebackup = false
        -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
        -- delays and poor user experience
        vim.opt.updatetime = 500
        -- Always show the signcolumn, otherwise it would shift the text each time
        -- diagnostics appeared/became resolved
        vim.opt.signcolumn = 'yes'

        -- Use Tab for trigger completion with characters ahead and navigate
        -- NOTE: There's always a completion item selected by default, you may
        -- want to enable no select by setting `'suggest.noselect': true` in your
        -- configuration file
        -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped
        -- by other plugins before putting this into your config
        local keyset = vim.keymap.set
        local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
        keyset('i', '<TAB>', [[coc#pum#visible() ? coc#pum#next(1) : '<TAB>']], opts)
        keyset('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : '<S-TAB>']], opts)
        keyset('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : '<CR>']], opts)

        -- GoTo code navigation
        keyset('n', 'gd', '<Plug>(coc-definition)')
        keyset('n', 'gy', '<Plug>(coc-type-definition')
        keyset('n', 'gi', '<Plug>(coc-implementation)')
        keyset('n', 'gr', '<Plug>(coc-references)')

        opts = { silent = true, nowait = true }
        -- Remap keys for apply code actions at the cursor position.
        keyset('n', '<leader>ac', '<Plug>(coc-codeaction-cursor)', opts)
        -- Remap keys for apply code actions affect whole buffer.
        keyset('n', '<leader>as', '<Plug>(coc-codeaction-source)', opts)
        -- Remap keys for applying codeActions to the current buffer
        keyset('n', '<leader>ac', '<Plug>(coc-codeaction)', opts)
        -- Apply the most preferred quickfix action on the current line
        keyset('n', '<leader>qf', '<Plug>(coc-fix-current)', opts)
        -- Remap keys for apply refactor code actions.
        keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)")
    end,
    enabled = false,
}
