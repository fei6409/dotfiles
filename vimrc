" vim: fmr={{{,}}} foldlevel=0 fdm=marker


" header {{{
filetype plugin indent on
syntax on " Enable syntax highlighting
let mapleader=',' " set <Leader> key to ','
" }}}

" vim-plug {{{
call plug#begin('~/.vim/plugged')
Plug 'Yggdroot/indentLine'
Plug 'embear/vim-localvimrc'
Plug 'gentoo/gentoo-syntax'
Plug 'junegunn/fzf', {'dir':'~/.fzf', 'do':'./install --all'} " './install --bin' to use fzf inside vim only
Plug 'junegunn/fzf.vim'
" Plug 'ludovicchabant/vim-gutentags' " recommanded to work with universal-ctags
Plug 'morhetz/gruvbox'
Plug 'mtdl9/vim-log-highlighting'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'powerline/fonts'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
" Some interesting plugins? {{{
" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'Konfekt/FastFold'
" Plug 'Valloric/YouCompleteMe'
" Plug 'easymotion/vim-easymotion'
" Plug 'godlygeek/tabular' " for vim-markdown, must come before it
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'plasticboy/vim-markdown'
" Plug 'sheerun/vim-polyglot' " language syntax pack
" Plug 'terryma/vim-multiple-cursors'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-sensible'
" }}}
call plug#end()

" fzf.vim {{{
" shortcut to find files
nnoremap <C-f> :Files<CR>
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
autocmd FileType json,markdown let g:indentLine_setConceal = 0
autocmd FileType json setlocal foldmethod=indent
let g:indentLine_color_gui = '#585858'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" }}}

" Coc.nvim {{{
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"
      " \ pumvisible() ? "\<C-n>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
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
nmap <leader>' csw'
" }}}

" ale/ALE {{{
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_c_parse_compile_commands = 1
let b:ale_linters = {
  \   'javascript': ['eslint'],
  \   'python': ['flake8', 'pylint'],
  \   'json': ['jsonlint'],
  \   'sh': ['shellcheck']
  \ }
let g:ale_fixers = {
  \   '*': ['trim_whitespace', 'remove_trailing_lines'],
  \   'markdown': ['remove_trailing_lines']
  \ }
let g:ale_sh_shellcheck_exclusions = 'SC2039,SC1090'
autocmd BufWritePre * ALEFix
" }}}

" vim-log-highlighting {{{
au BufNewFile,BufRead *log,*messages,*kcrash,*previous,*dmesg,*ramoops*,log-ec*,log-cpu* set filetype=log
" }}}

" vim-fugitive {{{
" Jump to next/previous quickfix entry
let g:fugitive_no_maps = 1  " Disable C-n functionality on viewing a commit
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
" }}}

" vim-localvimrc {{{
" Store and restore decisions only if the answer was given in upper case
" (Y/N/A).
let g:localvimrc_persistent = 1
" }}}

" vim-hexokinase {{{
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'vim', 'gitconfig']
let g:Hexokinase_highlighters = ['foreground']
" }}}

" }}}

" indentations {{{
set autoindent " Enable auto indent
set expandtab " insert whitespace whenever the tab key is pressed
set shiftwidth=2 " determine the number of whitespace inserted for indentation (e.g. using gg=G to fix indentation)
set softtabstop=2 " the width cursor moves when typing a tab
set tabstop=2 " specify the width of a tab
let g:python_recommended_style=0 " disable python indentation from ftplugin/python.vim
autocmd FileType Makefile setlocal noexpandtab " for Makefile indentation, shell recipe should start with tab
" autocmd FileType c,cpp setlocal sts=4 ts=4 sw=4 " set tab size to 4 for cpp files
" }}}

" autocmd {{{
autocmd BufNewFile,BufRead * if &syntax == '' | set syntax=sh | endif " for file with no syntax set
autocmd FileType json setlocal foldlevel=1 " default keep the top level open
" autocmd FileType c,cpp,python,json autocmd BufWritePre * %s/\s\+$//e " remove trailing space on save, replaced by ALEFix

" set hibrid line numbering with auto toggle
set number
" set number relativenumber
" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

" }}}

" general setting {{{
set backspace=2 " make backspace can delete over line breaks
set confirm " confirm before quiting without saving
set cursorline " highlight the current line
set foldlevel=0 " fold everything be default
" disabled because of https://github.com/vim/vim/issues/5454
" set foldmethod=marker " set folding
set hidden " set hidden buffer
set history=1000 " set the number of stored commands
set hlsearch " highlight the search matches
set incsearch " increased mode for search
set laststatus=2 " always enable status line
set mouse-=a " disable mouse in all modes
" set textwidth=80 " wrap text to 80 characters, use `gq` instead
set nocompatible
set noerrorbells " set error bells off
set ruler " enable status line
set showcmd " show current command info in status line  e.g. selecting things in visual mode
" set spell spelllang=en_us " spell checking
set t_Co=256 " enable 256 color in vim
set t_vb= " set visual bell empty
set ttimeoutlen=5 " speed up the time from insert mode to normal using <esc> key
set undofile " save undo's after file closes
set visualbell " use visual bell instead of beeping
set wildmenu " set command-line completion operate in enhanced mode
set wrap " enable text wrapping
set list lcs=tab:»\ " use listchars to show tab
" }}}

" save those hidden files away {{{
set backupdir=.backup/,~/.vim/.backup//,/tmp//
set directory=.swp/,~/.vim/.swp//,/tmp//
set undodir=.undo/,~/.vim/.undo//,/tmp//
" }}}

" color related {{{
colorscheme gruvbox " set color scheme, was using torte
" dark mode
set background=dark
" enable true color in tmux
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" normal
highlight Normal guibg=#1c1c1c
" cursor line
highlight CursorLine cterm=NONE guibg=#444444
" menu
highlight Pmenu guibg=#949494 guifg=#121212
highlight PmenuSel guibg=darkgreen guifg=lightgray
" tailing space
highlight TailingWhitespace guibg=#d70000
match TailingWhitespace /\s\+$/
" folding
highlight Folded guibg=#585858 guifg=white
" line number
highlight LineNr cterm=NONE guifg=grey
" }}}

" general key mapping {{{
nnoremap ; :
vnoremap ; :
nnoremap <leader>/ :nohlsearch<CR>
nnoremap <leader>d :bp <BAR> bd #<CR>
nnoremap <leader>t :enew<CR>
" Unfold all the foldings
nnoremap <leader>r zR<CR>
" Search for the word that cursor points to
nnoremap <leader>s :Rg <C-R><C-W><CR>
" Prettify json
nnoremap <leader>j :%!python -m json.tool<CR>
" Yank the selected part to clipboard
vnoremap <leader>y "+y
" Paste without overwritting register, see
" https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
xnoremap <leader>p "_dP
" Buffer navigation
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
" Identify the syntax highlighting group used at the cursor
nnoremap <F7> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" Toggle paste mode
set pastetoggle=<F8>
" Toggle linenumber
nnoremap <F9> :set invnumber<CR>
" nnoremap <F9> :set invnumber invrelativenumber<CR>
" /v stands for reg exp very magic mode, every char except a-zA-Z0-9 and _
" will have special meaning
nnoremap / /\v
vnoremap / /\v
" %s stands for global substitution
cnoremap %s/ %s/\v
" }}}
