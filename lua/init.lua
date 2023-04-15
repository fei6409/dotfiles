-- leader key should go first before plugins
vim.g.mapleader = ' '

-- lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')
require('telescope').load_extension('fzf')
require('lspconfig').clangd.setup {}
require('lualine').setup {}

-- Other settings
require('env')
