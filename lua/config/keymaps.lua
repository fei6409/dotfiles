local keyset = vim.keymap.set

-- Remap semicolon to colon for easier command mode
keyset({ 'n', 'v' }, ';', ':')

-- Prevent accidental command history popup on 'q:'
keyset('n', 'q:', ':q')

-- Source current file quickly
keyset('n', '<leader><leader>x', '<cmd>source %<cr>', { desc = 'Source current file' })

-- Execute current/selected line(s) in Lua
keyset('n', '<leader>x', '<cmd>.lua<cr>', { desc = 'Run current line as Lua' })
-- In visual mode, run selection as Lua code
keyset('v', '<leader>x', ':lua<cr>', { desc = 'Run selection as Lua' })

-- Buffer navigation
keyset('n', '<TAB>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
keyset('n', '<S-TAB>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })

-- Window navigation with Ctrl + hjkl
keyset('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
keyset('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
keyset('n', '<C-k>', '<C-w>k', { desc = 'Window up' })
keyset('n', '<C-l>', '<C-w>l', { desc = 'Window right' })

-- Clear search highlight
keyset('n', '<leader>l', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })

-- Unfold all folds
keyset('n', '<leader>r', 'zR<cr>', { desc = 'Unfold all' })

-- Improved indenting in visual mode (keep selection)
keyset('v', '<', '<gv', { desc = 'Indent left (keep selection)' })
keyset('v', '>', '>gv', { desc = 'Indent right (keep selection)' })

-- Use blackhole register for paste, delete, and substitute
-- (don't affect default register)
keyset('v', 'p', '"_dP', { desc = 'Paste without yanking' })
keyset({ 'n', 'v' }, 'x', '"_x', { desc = 'Delete without yanking' })
keyset({ 'n', 'v' }, 's', '"_s', { desc = 'Substitute without yanking' })

-- System clipboard copy/paste integration
keyset('n', '<leader>y', '"+yiw', { desc = 'Yank word to system clipboard' })
keyset('v', '<leader>y', '"+y', { desc = 'Yank selection to system clipboard' })
keyset('n', '<leader>p', '"+p', { desc = 'Paste after from system clipboard' })
keyset('n', '<leader>P', '"+P', { desc = 'Paste before from system clipboard' })

-- Close current buffer:
-- Switching to the next buffer, or previous one if at the end, before closing
-- the current buffer, ensuring not to circle back to the first buffer.
keyset('n', '<leader>q', function()
    local cur_buf = vim.api.nvim_get_current_buf()
    local bufs = vim.api.nvim_list_bufs()
    local last_buf
    for i = #bufs, 1, -1 do
        if vim.fn.buflisted(bufs[i]) == 1 then
            last_buf = bufs[i]
            break
        end
    end
    if cur_buf == last_buf then
        vim.cmd('bprevious|bwipeout #')
    else
        vim.cmd('bnext|bwipeout #')
    end
end, { desc = 'Close current buffer' })

-- Print syntax info
keyset('n', '<F4>', function()
    local attr = function(x) return vim.fn.synIDattr(x, 'name') end
    local synid = vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 1)
    print('Syntax <' .. attr(synid) .. '> maps to <' .. attr(vim.fn.synIDtrans(synid)) .. '>')
end, { desc = 'Print syntax highlight info' })

-- Toggle colorcolumn, customizable columns
local colorcolumns = '75,80,100,120'
keyset('n', '<F8>', function()
    vim.wo.colorcolumn = (vim.wo.colorcolumn == '' and colorcolumns or '')
    print('Colorcolumn: ' .. (vim.wo.colorcolumn == '' and 'off' or colorcolumns))
end, { desc = 'Toggle colorcolumn' })

-- Toggle line number, list mode, and signcolumn
keyset('n', '<F9>', function()
    vim.cmd('set invnumber invlist')
    vim.cmd('IBLToggle')
    vim.wo.signcolumn = (vim.wo.signcolumn == 'yes' and 'no' or 'yes')
    print(
        'Number: '
            .. (vim.wo.number and 'on' or 'off')
            .. ', List: '
            .. (vim.wo.list and 'on' or 'off')
            .. ', Signcolumn: '
            .. vim.wo.signcolumn
    )
end, { desc = 'Toggle line number' })

-- Toggle expandtab and tab width
keyset('n', '<F10>', function()
    if vim.o.expandtab then
        vim.cmd('setlocal noexpandtab tabstop=8 shiftwidth=8')
        print('Tab indent (8 spaces)')
    else
        vim.cmd('setlocal expandtab tabstop=4 shiftwidth=4')
        print('Sapce indent (4 spaces)')
    end
end, { desc = 'Switch expandtab status' })
