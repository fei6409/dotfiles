-- Set mapleader before anything else
vim.g.mapleader = ' '

local opt = vim.opt

opt.breakindent = true -- Indent wrapped lines visually
opt.cmdheight = 2 -- More space for the command line
opt.completeopt = 'menu,menuone,preview,noselect' -- Completion menu behavior
opt.confirm = true -- Prompt to save changes before exiting a modified buffer
opt.cursorline = true -- Highlight the current line
opt.foldlevel = 99 -- No folding by default
opt.foldmethod = 'expr' -- Leverage vim.treesitter.foldexpr() for folding
opt.ignorecase = true -- Case-insensitive searching
opt.laststatus = 3 -- Always show a global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show special characters
opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '%',
}
opt.mouse = '' -- Disable mouse support
opt.number = true -- Show line numbers
opt.scrolloff = 4 -- Minimum lines above and below cursor
opt.showmode = false -- Hide mode indicator (statusline handles it)
opt.signcolumn = 'yes' -- Always show the sign column
opt.smartcase = true -- Case-sensitive search if uppercase present
opt.spelllang = 'en_us' -- Spellcheck language
opt.splitbelow = true -- New windows open below current
opt.splitright = true -- New windows open to the right of current
opt.syntax = 'on' -- Enable syntax highlighting
opt.termguicolors = true -- Enable 24-bit RGB color
opt.textwidth = 80 -- Wrap lines at 80 characters
opt.ttimeoutlen = 5 -- Shorten key code sequence wait time (<ESC> responsiveness)
opt.undofile = true -- Enable persistent undo
opt.winborder = 'rounded' -- Use rouded borders on floating windows

-- Indentation settings
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftround = true -- Round indent to nearest multiple of 'shiftwidth'
opt.shiftwidth = 4 -- Number of spaces per indent
opt.smartindent = true -- Auto-indent new lines
opt.softtabstop = -1 -- Use 'shiftwidth' for soft tab stops
opt.tabstop = 4 -- Number of spaces a tab counts for

-- Debug utility
P = function(v)
    print(vim.inspect(v))
    return v
end
