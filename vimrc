set nocompatible

set autoindent " Enable auto indent
set background=dark " dark mode
set backspace=2 " make backspace can delete over line breaks
set cmdheight=2 " Give more space for displaying messages
set confirm " confirm before quiting without saving
set cursorline " highlight the current line
set display=lastline,uhex " Show last line; show hex for non-printable chars
set hidden " set hidden buffer
set history=1024 " set the number of stored commands
set hlsearch " highlight the search matches
set ignorecase " Ignore case in search patterns
set incsearch " increased mode for search
set laststatus=2 " always enable status line
set list listchars=tab:»\ ,trail:·,nbsp:% " use listchars to show tab
set mouse-=a " disable mouse in all modes
set noerrorbells " set error bells off
set number " line number
set report=0 " Always report the number of changed line/substitution
set ruler " Show cursor position
set scrolloff=4 " always show the lines above and below cursor
set shiftround " Round indent to nearest multiple of 'shiftwidth'
set showcmd " show current command info in status line  e.g. selecting things in visual mode
set showmode " Show current mode
set smartcase " Enable smart case in search patterns
set smartindent " Enable smart autoindent when starting a new line
set smarttab " Enable smart tab
set splitbelow " for :split
set splitright " for :vsplit
set t_Co=256 " enable 256 color in vim
set t_vb= " set visual bell empty
set ttimeout " time out on key codes
set ttimeoutlen=5 " speed up the time from insert mode to normal using <esc> key
set undofile " save undo's after file closes
set visualbell " use visual bell instead of beeping
set wildmenu " set command-line completion operate in enhanced mode
set wrap " enable text wrapping
" Indentation
set expandtab " insert whitespace whenever the tab key is pressed
set shiftwidth=2 " determine the number of whitespace inserted for indentation (e.g. using gg=G to fix indentation)
set softtabstop=2 " the width cursor moves when typing a tab
set tabstop=2 " specify the width of a tab

" Save backup, swap and undo files in /tmp
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

filetype plugin indent on
let mapleader=' '
syntax on

" Cursor shape
let &t_SI = "\<Esc>[6 q" " Vertical bar in insert mode
let &t_SR = "\<Esc>[4 q" " Underline in replace mode
let &t_EI = "\<Esc>[2 q" " Block in normal mode

" True-color support
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Colorscheme and highlight
colorscheme slate
highlight Normal        ctermbg=NONE guibg=#101010
highlight Pmenu         guibg=grey guifg=#121212
highlight PmenuSel      guibg=darkgreen guifg=lightgray

" Key mappings
nnoremap ; :
vnoremap ; :
nnoremap <leader>l :nohlsearch<cr>
" Delete w/o changing current register
nnoremap x "_x
vnoremap x "_x
nnoremap s "_s
vnoremap s "_s
" Yank / paste with system clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+yiw
vnoremap <leader>p "+p
vnoremap <leader>P "+P
" Paste without overwritting register, see
" https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
vnoremap p "_dP
" No more command history on typo
nnoremap q: :q
" Buffer navigation
nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>
