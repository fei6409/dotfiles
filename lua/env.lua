-- vim: foldmethod=marker

-- general options --
local opt = vim.opt
opt.breakindent = true -- indent the wrapped lines
opt.cmdheight = 2 -- more lines for command line
opt.completeopt = { 'menu', 'menuone', 'preview', 'noselect' } -- completion opt
opt.confirm = true -- confirm on quitting without saving
opt.cursorline = true -- highlight line of the cursor
opt.foldmethod = 'marker' -- use markers ('{{{' and '}}}') to specify folds
opt.ignorecase = true -- case-insensitive search
opt.list = true -- list mode for special characters
opt.listchars = {tab='» ', trail='·', nbsp='%'} -- list mode characters
opt.mouse = '' -- mouse disabled
opt.number = true -- line number
opt.scrolloff = 5 -- minimal number of lines to keep above and below the cursor
opt.signcolumn = 'yes' -- show sign column
opt.smartcase = true -- case-sensitive search if uppercase included
opt.spelllang = 'en_us' -- spellchecking language
opt.syntax = 'on' -- syntax highlighting
opt.termguicolors = true -- 24-bit RGB color
opt.textwidth = 80 -- wrap long lines
opt.ttimeoutlen = 5 -- shorten key code seq wait time for faster <ESC> response
opt.undofile = true -- save undo history
-- indent related
opt.expandtab = true -- expand tab
opt.shiftwidth = 2 -- shift width
opt.softtabstop = -1 -- when sts is negative, the value of 'shiftwidth' is used
opt.tabstop = 2 -- tab width
opt.cindent = true -- experimental
opt.smartindent = true -- experimental


-- key mappings --
local keyset = vim.keymap.set
keyset({'n','v'}, ';', ':')
keyset('n', 'q:', ':q') -- no more command history on typo

-- "_ is a blackhole reg, used for operations w/o changing the default reg
keyset('v', 'p', '"_dP') -- paste
keyset({'n','v'}, 'x', '"_x') -- delete
keyset({'n','v'}, 's', '"_s') -- replace

keyset('n', '<TAB>', ':bnext<CR>') -- next buffer
keyset('n', '<S-TAB>', ':bprevious<CR>') -- previous buffer

keyset('n', '<leader>l', ':nohlsearch<CR>') -- close highlight search
keyset('n', '<leader>q', ':bp<BAR>bw #<CR>') -- delete current buffer
keyset('n', '<leader>r', 'zR<CR>') -- unfold all foldings
keyset('n', '<leader>j', ':%!python -m json.tool<CR>') -- prettify json

-- copy/paste with system clipboard
keyset('n', '<leader>y', '"+yiw')
keyset('v', '<leader>y', '"+y')
keyset('n', '<leader>p', '"+p')
keyset('n', '<leader>P', '"+P')

-- toggle colorcolumn
keyset('n', '<F8>', function()
  vim.wo.colorcolumn = (vim.wo.colorcolumn == '' and '75,80,100' or '')
end)

-- toggle line number, list mode and signcolumn
keyset('n', '<F9>', function()
  vim.cmd [[set invnumber invlist]]
  vim.wo.signcolumn = (vim.wo.signcolumn == 'yes' and 'no' or 'yes')
end)


-- utilities --
P = function(v)
  print(vim.inspect(v))
  return v
end


-- autocmds --
local augroup = vim.api.nvim_create_augroup('UserCmds', { clear=true })
local autocmd = vim.api.nvim_create_autocmd

autocmd('FileType', {
  pattern = 'gitcommit',
  group = augroup,
  desc = 'Spell check in Git commit',
  command = [[setlocal spell]],
})
autocmd('FileType', {
  pattern = {'help','man'},
  group = augroup,
  desc = 'Quick exit on help page',
  command = [[nnoremap <buffer><silent> q :q<CR>]],
})
autocmd('FileType', {
  pattern = {'makefile'},
  group = augroup,
  desc = '4-space tab indentation for file types',
  command = [[setlocal noexpandtab tabstop=4 shiftwidth=4]],
})
autocmd({'BufNewFile','BufRead'}, {
  pattern = {'*.ebuild'},
  group = augroup,
  desc = '4-space tab indentation for path patterns',
  command = [[setlocal noexpandtab tabstop=4 shiftwidth=4]],
})
autocmd({'BufNewFile','BufRead'}, {
  pattern = {'*/kernel/*','*/syzkaller/*'},
  group = augroup,
  desc = '8-space tab indentation for path patterns',
  command = [[setlocal noexpandtab tabstop=8 shiftwidth=8]],
})
autocmd('BufWritePre', {
  pattern = '',
  group = augroup,
  desc = 'Trim trailing spaces',
  callback = function()
    local skip_types = {'diff','gitsendemail'}

    for _, type in pairs(skip_types) do
      if vim.bo.filetype == type then return end
    end
    vim.cmd[[%s/\s\+$//e]]
  end,
})
