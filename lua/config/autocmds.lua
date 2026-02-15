local autocmd = vim.api.nvim_create_autocmd
local augroup_names = { 'yank', 'resize', 'close', 'spell', 'indent', 'trim' }
local augroups = {}
local opts_nowait = { buffer = true, silent = true, nowait = true }

for _, name in pairs(augroup_names) do
    augroups[name] = vim.api.nvim_create_augroup('fei_' .. name, { clear = true })
end

autocmd('TextYankPost', {
    group = augroups['yank'],
    desc = 'Highlight on yank',
    callback = function() (vim.hl or vim.highlight).on_yank() end,
})

autocmd('VimResized', {
    group = augroups['resize'],
    desc = 'Resize splits if window got resized',
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd('tabdo wincmd =')
        vim.cmd('tabnext ' .. current_tab)
    end,
})

autocmd('FileType', {
    group = augroups['close'],
    pattern = { 'help', 'man', 'checkhealth' },
    desc = 'Additional keymaps to close help buffers',
    callback = function()
        -- Do vertical windows and use `bwipeout` to avoid horizontal re-opening
        vim.cmd('wincmd L')
        vim.keymap.set('n', '<C-c>', '<cmd>bwipeout<cr>', opts_nowait)
        vim.keymap.set('n', 'q', '<cmd>bwipeout<cr>', opts_nowait)
    end,
})

autocmd({ 'BufEnter' }, {
    group = augroups['close'],
    pattern = { 'fugitive://*', 'gitsigns://*' },
    desc = 'Additional keymaps to close blame buffers',
    callback = function()
        vim.keymap.set('n', '<C-c>', '<cmd>bwipeout<cr>', opts_nowait)
        vim.keymap.set('n', 'q', '<cmd>bwipeout<cr>', opts_nowait)
    end,
})

autocmd('FileType', {
    group = augroups['spell'],
    pattern = { 'gitcommit', 'gitsendemail', 'jjdescription', 'markdown' },
    desc = 'Enable spell checking',
    callback = function() vim.opt_local.spell = true end,
})

autocmd('FileType', {
    group = augroups['indent'],
    pattern = { 'make', 'go' },
    desc = 'Tab indent',
    callback = function() vim.opt_local.expandtab = false end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
    group = augroups['indent'],
    pattern = { '*.ebuild', '*.eclass' },
    desc = 'Tab indent with ebuilds',
    callback = function() vim.opt_local.expandtab = false end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
    group = augroups['indent'],
    pattern = { '*/*kernel*/*', '*/syzkaller/*' },
    desc = 'Tab indent (8 spaces) with kernel code',
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 8
        vim.opt_local.shiftwidth = 8
    end,
})

autocmd('BufWritePre', {
    group = augroups['trim'],
    desc = 'Trim trailing spaces',
    callback = function()
        local skip_types = { 'diff', 'gitsendemail', 'markdown' }

        if vim.tbl_contains(skip_types, vim.bo.filetype) then return end
        -- `keeppatterns` prevents altering the search pattern
        vim.cmd('keeppatterns %s/\\s\\+$//e')
    end,
})
