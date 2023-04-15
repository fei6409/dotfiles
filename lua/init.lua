-- vim: foldmethod=marker

-- leader key should go first before plugins
vim.g.mapleader = ' '

-- lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- }}}

require("lazy").setup("plugins")
require('telescope').load_extension('fzf')
require('lspconfig').clangd.setup {}
require('lualine').setup {}

-- General options
vim.cmd.colorscheme('gruvbox-material')
vim.opt.breakindent = true -- indent the wrapped lines
vim.opt.cmdheight = 2 -- more lines for command line
vim.opt.confirm = true -- confirm on quitting without saving
vim.opt.cursorline = true -- highlight line of the cursor
vim.opt.foldmethod = 'marker' -- use markers ('{{{' and '}}}') to specify folds
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.list = true -- list mode for special characters
vim.opt.listchars = {tab='» ', trail='·', nbsp='%'} -- list mode characters
vim.opt.mouse = 'n' -- mouse enabled in normal mode
vim.opt.number = true -- line number
vim.opt.scrolloff = 5 -- minimal number of lines to keep above and below the cursor
vim.opt.smartcase = true -- case-sensitive search if uppercase included
vim.opt.spelllang = 'en_us' -- spellchecking language
vim.opt.textwidth = 80 -- wrap long lines
vim.opt.ttimeoutlen = 5 -- shorten the wait time of key code sequence for faster <esc> response
vim.opt.termguicolors = true -- 24-bit RGB color
vim.opt.undofile = true -- save undo history
-- indent related {{{
vim.opt.expandtab = true -- expand tab
vim.opt.shiftwidth = 2 -- shift width
vim.opt.softtabstop = -1 -- when sts is negative, the value of 'shiftwidth' is used
vim.opt.tabstop = 2 -- tab width
vim.opt.cindent = true -- experimental
vim.opt.smartindent = true -- experimental
--- }}}

-- Key bindings
vim.keymap.set({'n','v'}, ';', ':')
vim.keymap.set('n', 'q:', ':q') -- no more command history on typo

-- "_ is a blackhole register, use it for operations w/o changing the default register
vim.keymap.set('v', 'p', '"_dP') -- paste
vim.keymap.set({'n','v'}, 'x', '"_x') -- delete
vim.keymap.set({'n','v'}, 's', '"_s') -- replace

vim.keymap.set('n', '<TAB>', ':bnext<CR>') -- next buffer
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>') -- previous buffer

vim.keymap.set('n', '<leader>l', ':nohlsearch<CR>') -- close highlight search
vim.keymap.set('n', '<leader>q', ':bp<BAR>bw #<CR>') -- delete current buffer
vim.keymap.set('n', '<leader>r', 'zR<CR>') -- unfold all foldings
vim.keymap.set('n', '<leader>s', ':Rg <C-R><C-W><CR>') -- unfold all foldings
vim.keymap.set('n', '<leader>j', ':%!python -m json.tool<CR>') -- prettify json

-- copy/paste with system clipboard
vim.keymap.set('n', '<leader>y', '"+yiw')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')

vim.keymap.set('n', '<F9>', ':invnumber<CR>:invlist<CR>') -- toggle line number


