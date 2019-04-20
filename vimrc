" vim: fmr={{{,}}} foldlevel=0 fdm=marker

" header {{{
filetype plugin indent on
syntax on " Enable syntax highlighting
colorscheme torte " set color scheme
let mapleader=',' " set <Leader> key to ','
" }}}

" vim-plug {{{
call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe'
Plug 'Yggdroot/indentLine'
Plug 'gentoo/gentoo-syntax'
Plug 'godlygeek/tabular' " for vim-markdown, must come before it
Plug 'junegunn/fzf', {'dir':'~/.fzf', 'do':'./install --all'} " './install --bin' to use fzf inside vim only
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags' " recommanded to work with universal-ctags
Plug 'plasticboy/vim-markdown'
Plug 'powerline/fonts'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Some interesting plugins? {{{
" Plug 'easymotion/vim-easymotion'
" Plug 'tpope/vim-sensible'
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'sheerun/vim-polyglot' " language syntax pack
" }}}
call plug#end()

" fzf.vim {{{
" shortcut to find files
nnoremap <C-f> :Files<CR>
" ag search result
cnoremap files Files
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_COMMAND = 'rg --files --no-messages'
cnoremap AG Ag
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
cnoremap RG Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
" }}}
" NERDTree {{{
" toggle for NERDtree
nnoremap <C-g> :NERDTreeToggle<CR>
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" automatically open NERDTree on start
" autocmd vimenter * NERDTree
" }}}
" YCM {{{
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" let g:ycm_show_diagnostics_ui = 0
let g:ycm_min_num_of_chars_for_completion = 3
" auto close preview window (often used while coding Python)
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" allow up and down key close the completion window
let g:ycm_key_list_stop_completion = ['<C-y>', '<UP>', '<DOWN>']
" }}}
" vim-airline {{{
" enable powerline-fonts, but need 'guifont' to be supported
" or try to change terminal non-ascii font to Meslo
let g:airline_powerline_fonts = 1
" enable tabline
let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'
" show buffer number
" let g:airline#extensions#tabline#buffer_nr_show = 1
" set airline theme
let g:airline_theme = 'wombat'
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}
" indentLine {{{
autocmd Filetype json let g:indentLine_setConceal = 0
autocmd Filetype json setlocal foldmethod=indent
" }}}
" nerdcommenter {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompacSexyComs = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign='left'
nmap \ <leader>c<space>
vmap \ <leader>c<space>
" }}}
" vim-surround {{{
" surround current word with double qoutes
nmap <leader>" csw"
" }}}
" }}}

" indentations {{{
set autoindent " Enable auto indent
set expandtab " insert whitespace whenever the tab key is pressed
set shiftwidth=2 " determine the number of whitespace inserted for indentation
set softtabstop=2 " generally same as shiftwidth
set tabstop=2 " specify the width of a tab
let g:python_recommended_style=0 " disable python indentation from ftplugin/python.vim
" }}}

" autocmd {{{
autocmd BufNewFile,BufRead * if &syntax == '' | set syntax=sh | endif " for file with no syntax set
autocmd FileType Makefile setlocal noexpandtab " for Makefile indentation, shell recipe should start with tab
autocmd FileType c,cpp setlocal sts=4 ts=4 sw=4 " set tab size to 4 for cpp files
autocmd FileType json setlocal foldlevel=1 " default keep the top level open
autocmd FileType c,cpp,python,json autocmd BufWritePre * %s/\s\+$//e " remove trailing space on save
" }}}

" general setting {{{
set backspace=2 " make backspace can delete over line breaks
set confirm " confirm before quiting without saving
set cursorline " highlight the current line
set foldlevel=0 " fold everything be default
set foldmethod=marker " set folding
set hidden " set hidden buffer
set history=1000 " set the number of stored commands
set hlsearch " highlight the search matches
set incsearch " increased mode for search
set laststatus=2 " always enable status line
set mouse-=a " disable mouse in all modes
set nocompatible
set noerrorbells " set error bells off
set number " set line number
set ruler " enable status line
set showcmd " show current command info in status line  e.g. selecting things in visual mode
set t_Co=256 " enable 256 color in vim
set t_vb= " set visual bell empty
set ttimeoutlen=5 " speed up the time from insert mode to normal using <esc> key
set undofile " save undo's after file closes
set visualbell " use visual bell instead of beeping
set wildmenu " set command-line completion operate in enhanced mode
set wrap " enable text wrapping
" }}}

" save those hidden files away {{{
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//
" }}}

" color related {{{
highlight Normal cterm=NONE ctermbg=234
" current line
highlight CursorLine cterm=NONE ctermbg=238 ctermfg=NONE
" menu
highlight Pmenu ctermbg=darkgray
highlight PmenuSel ctermfg=lightgray ctermbg=darkblue
" tailing space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" folding
highlight Folded ctermbg=DarkGray ctermfg=White
" }}}

" key mapping {{{
nnoremap ; :
vnoremap ; :
nnoremap <leader>/ :nohlsearch<CR>
nnoremap <leader>d :bp <BAR> bd #<CR>
nnoremap <leader>t :enew<CR>
nnoremap <leader>r :so $MYVIMRC<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
set pastetoggle=<F8>
" /v stands for reg exp very magic mode, every char except a-zA-Z0-9 and _
" will have special meaning
nnoremap / /\v
vnoremap / /\v
" %s stands for global substitution
cnoremap %s/ %s/\v
" }}}
