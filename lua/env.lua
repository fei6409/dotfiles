-- vim: foldmethod=marker

-- general options --
local opt = vim.opt

-- indent the wrapped lines
opt.breakindent = true
-- allow copy/paste from system clipboard
-- need clipboard tools e.g. pb{copy,paste}/xclip
-- opt.clipboard = 'unnamedplus'
-- more lines for command line
opt.cmdheight = 2
-- completion opt
opt.completeopt = {
    'menu',
    'menuone',
    'preview',
    'noselect',
}
-- confirm on quitting without saving
opt.confirm = true
-- highlight line of the cursor
opt.cursorline = true
-- use markers ('{{{' and '}}}') to specify folds
opt.foldmethod = 'marker'
-- case-insensitive search
opt.ignorecase = true
-- always show global status line
opt.laststatus = 3
-- list mode for special characters
opt.list = true
-- list mode characters
opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '%',
}
-- mouse disabled
opt.mouse = ''
-- line number
opt.number = true
-- minimal number of lines to keep above and below the cursor
opt.scrolloff = 5
-- show sign column
opt.signcolumn = 'yes'
-- case-sensitive search if uppercase included
opt.smartcase = true
-- spellchecking language
opt.spelllang = 'en_us'
-- syntax highlighting
opt.syntax = 'on'
-- 24-bit RGB color
opt.termguicolors = true
-- wrap long lines
opt.textwidth = 80
-- shorten key code seq wait time for faster <ESC> response
opt.ttimeoutlen = 5
-- save undo history
opt.undofile = true

-- indent related
-- expand tab
opt.expandtab = true
-- smart autoindent
opt.smartindent = true
-- shift width
opt.shiftwidth = 4
-- when sts is negative, the value of 'shiftwidth' is used
opt.softtabstop = -1
-- tab width
opt.tabstop = 4

-- key mappings --
local keyset = vim.keymap.set
keyset({ 'n', 'v' }, ';', ':')
-- no more command history on typo
keyset('n', 'q:', ':q')

-- souce current file
keyset('n', '<leader><leader>x', '<cmd>source %<CR>')
-- execute current/selected line in Lua
keyset('n', '<leader>x', '<cmd>.lua<CR>')
-- <cmd> expects a complete command, which may not work in visual mode
keyset('v', '<leader>x', ':lua<CR>')

-- "_ is a blackhole reg, used for operations w/o changing the default reg
-- paste
keyset('v', 'p', '"_dP')
-- delete
keyset({ 'n', 'v' }, 'x', '"_x')
-- replace
keyset({ 'n', 'v' }, 's', '"_s')

-- next buffer
keyset('n', '<TAB>', '<cmd>bnext<CR>')
-- previous buffer
keyset('n', '<S-TAB>', '<cmd>bprevious<CR>')

-- close current buffer or quickfix window
keyset('n', '<leader>q', function()
    if vim.bo.buftype == 'quickfix' then
        -- `cclose` to close quickfix window.
        vim.cmd [[cclose]]
    elseif vim.bo.buftype == 'help' then
        -- I use `wincmd L` autocmd to open help window vertically.
        -- The next help window will be again opened horizontally if I use `q`
        -- to close current one. `bwipeout` seems to work as expected.
        vim.cmd [[bwipeout]]
    elseif vim.bo.filetype == 'fugitiveblame' then
        -- Close vim-fugitive blame window.
        vim.cmd [[close]]
    else
        -- `bw` jumps to the most recent active buffers after closing the
        -- current one, not the adjacent ones.
        -- This customizes the keymap behavior to jump to the next listed buffer
        -- instead, and if the closed buffer is the last listed buffer, jump to
        -- the previous one instead so it doesn't go to the first listed buffer.

        -- Get the current buffer number.
        local cur_buf = vim.api.nvim_get_current_buf()

        -- Get the list of all buffer numbers.
        local bufs = vim.api.nvim_list_bufs()
        local last_buf

        for i = #bufs, 1, -1 do
            if vim.fn.buflisted(bufs[i]) == 1 then
                last_buf = bufs[i]
                break
            end
        end

        if cur_buf == last_buf then
            -- Jump to the previous buffer.
            vim.cmd [[bprevious|bwipeout #]]
        else
            -- Jump to the next buffer.
            vim.cmd [[bnext|bwipeout #]]
        end
    end
end, { desc = 'all-in-one buffer close keymap' })

-- close non-file windows with ESC (quickfix, help etc.)
keyset('n', '<ESC>', function()
    if vim.bo.buftype == 'quickfix' then
        vim.cmd [[cclose]]
    elseif vim.bo.buftype == 'help' then
        vim.cmd [[bwipeout]]
    elseif vim.bo.filetype == 'fugitiveblame' then
        vim.cmd [[close]]
    end
end, { desc = 'extra buffer close keymap' })

-- close highlight search
keyset('n', '<leader>l', '<cmd>nohlsearch<CR>')

-- unfold all foldings
keyset('n', '<leader>r', 'zR<CR>')

-- copy/paste with system clipboard
keyset('n', '<leader>y', '"+yiw', { desc = 'Copy to system clipboard' })
keyset('v', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
keyset('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
keyset('n', '<leader>P', '"+P', { desc = 'Paste from system clipboard' })

-- Switch expandtab status & tab width
keyset('n', '<F4>', function()
    if vim.o.expandtab then
        vim.cmd [[setlocal noexpandtab tabstop=8 shiftwidth=8]]
    else
        vim.cmd [[setlocal expandtab tabstop=4 shiftwidth=4]]
    end
end, { desc = 'Switch expandtab status' })

-- print syntax name and mapped highlight group under current cursor
keyset('n', '<F7>', function()
    local fn = vim.fn
    local attr = function(x)
        return fn.synIDattr(x, 'name')
    end
    -- effective syntax ID
    local eid = fn.synID(fn.line '.', fn.col '.', 1)
    -- transparent syntax ID
    local tid = fn.synID(fn.line '.', fn.col '.', 0)

    print('syn<' .. attr(eid) .. '>, trans<' .. attr(tid) .. '> -> hlgrp<' .. attr(fn.synIDtrans(eid)) .. '>')
end, { desc = 'Print highlight group' })

-- toggle colorcolumn
keyset('n', '<F8>', function()
    vim.wo.colorcolumn = (vim.wo.colorcolumn == '' and '75,80,100' or '')
end, { desc = 'Toggle colorcolumn' })

-- toggle line number, list mode and signcolumn
keyset('n', '<F9>', function()
    vim.cmd [[set invnumber invlist]]
    vim.cmd [[IBLToggle]]
    vim.wo.signcolumn = (vim.wo.signcolumn == 'yes' and 'no' or 'yes')
end, { desc = 'Toggle line number' })

-- utilities --
P = function(v)
    print(vim.inspect(v))
    return v
end

-- autocmds --
local augroup = vim.api.nvim_create_augroup('UserCmds', { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- autocmd('FileType', {
--     pattern = { 'gitcommit', 'gitsendemail', 'markdown' },
--     group = augroup,
--     desc = 'Set spell check',
--     command = [[setlocal spell]],
-- })
-- autocmd('FileType', {
--     pattern = { 'help', 'man' },
--     group = augroup,
--     desc = 'Split help windows vertically',
--     command = [[wincmd L]],
-- })
-- autocmd('FileType', {
--     pattern = { 'makefile' },
--     group = augroup,
--     desc = 'Tab indentation for file types',
--     command = [[setlocal noexpandtab]],
-- })
-- autocmd('FileType', {
--     pattern = { 'go' },
--     group = augroup,
--     desc = 'Tab indentation (size=8) for file types',
--     command = [[setlocal noexpandtab tabstop=8 shiftwidth=8]],
-- })
autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.ebuild', '*.eclass' },
    group = augroup,
    desc = 'Tab indentation for path patterns',
    command = [[setlocal noexpandtab]],
})
autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*/kernel/*', '*/syzkaller/*' },
    group = augroup,
    desc = 'Tab indentation (size=8) for path patterns',
    command = [[setlocal noexpandtab tabstop=8 shiftwidth=8]],
})
autocmd('BufWritePre', {
    pattern = '',
    group = augroup,
    desc = 'Trim trailing spaces',
    callback = function()
        local skip_types = { 'diff', 'gitsendemail', 'markdown' }

        for _, type in pairs(skip_types) do
            if vim.bo.filetype == type then
                return
            end
        end
        -- `keeppatterns` prevents altering the search pattern
        vim.cmd [[keeppatterns %s/\s\+$//e]]
    end,
})
autocmd('TextYankPost', {
    group = augroup,
    desc = 'Highlight when yanking (copying) text',
    callback = function()
        vim.highlight.on_yank()
    end,
})
