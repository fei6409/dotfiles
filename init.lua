-- leader key definition should always go first
vim.g.mapleader = ' '

-- avoid loading netrw, the builtin file explorer
-- or use oil.nvim to takes over directory buffers
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- default environments
require 'env'

-- lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local out = vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
    spec = {
        { import = 'plugins' },
    },
    change_detection = {
        -- no check for config file changes
        enabled = false,
    },
}
