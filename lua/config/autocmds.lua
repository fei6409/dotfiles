local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup('user_cmds', { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup,
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd('VimResized', {
    group = augroup,
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd 'tabdo wincmd ='
        vim.cmd('tabnext ' .. current_tab)
    end,
})

autocmd('BufWritePre', {
    pattern = '',
    group = augroup,
    desc = 'Trim trailing spaces',
    callback = function()
        local skip_types = { 'diff', 'gitsendemail', 'markdown' }

        if vim.tbl_contains(skip_types, vim.bo.filetype) then
            return
        end
        -- `keeppatterns` prevents altering the search pattern
        vim.cmd [[keeppatterns %s/\s\+$//e]]
    end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.ebuild', '*.eclass' },
    group = augroup,
    desc = 'Tab indentation for path patterns',
    command = [[setlocal noexpandtab]],
})

autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*/kernel/*', '*/syzkaller/*' },
    group = augroup,
    desc = 'Tab indent (8 spaces) for path patterns',
    command = [[setlocal noexpandtab tabstop=8 shiftwidth=8]],
})

-- for per-filetype configs, see 'after/ftplugins/'
