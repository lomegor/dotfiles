" Use vim settings
set nocompatible

" Change the mapleader from \ to ,
let mapleader=","

set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=2                   " a tab is two spaces
set softtabstop=2               " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=2                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to shiftwidth
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set pastetoggle=<F2>            " when in insert mode, press <F2> to paste without style
set fileformats="unix,dos,mac"
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even if there is only one window
set cmdheight=2                 " use a status bar that is 2 rows high
set hidden                      " hide buffers instead of closing them 
set history=10                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
set viminfo='20,\"80            " read/write a .viminfo file
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=longest,list,full  
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                       " change the terminal's title
set visualbell                  " don't beep
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
set nomodeline                  " disable mode lines (security measure)
set ttyfast                     " always use a fast terminal
set formatoptions-=o            " don't start new lines w/ comment leader on pressing 'o'
set autoread                    " auto reload files

" Add folding
set foldmethod=syntax
set foldlevelstart=20

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

" normal regexes
nnoremap / /\v
vnoremap / /\v
" make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
" Shortcut to make
nmap mk :w <Bar> make<CR>
" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap <up> g<up>
nnoremap k gk
nnoremap <down> g<down>
" Complete whole filenames/lines with a quicker shortcut key in insert mode
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>
" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d
" Quick yanking to the end of the line
nmap Y y$
" Yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P
" Clears highlight
nmap <silent> <leader>/ :nohlsearch<CR>
" Sudo to write
cmap w!! w !sudo tee % >/dev/null
" Enter to create new line
map <S-Enter> O<Esc>
map <CR> o<Esc>
" tab navigation
nmap <C-h> :tabprevious<CR>
nmap <C-l> :tabnext<CR>
map <C-h> :tabprevious<CR>
map <C-l> :tabnext<CR>
imap <C-h> <Esc>:tabprevious<CR>i
imap <C-l> <Esc>:tabnext<CR>i

" Restore cursor position upon reopening files {{{
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" tex files
au BufEnter *.tex setlocal wrap textwidth=80 linebreak
" txt files
au BufEnter *.txt setlocal wrap linebreak
" Perl, Python and shell scripts
au BufEnter *.py,*.pl,*.sh vmap u :-1/^#/s///<CR>
au BufEnter *.py,*.pl,*.sh vmap c :-1/^/s//#/<CR>
au BufEnter *.py setlocal tabstop=4 shiftwidth=4 expandtab
" C, C++
au BufEnter *.h,*.c,*.cpp vmap u :-1/^\/\//s///<CR>
au BufEnter *.h,*.c,*.cpp vmap s :-1/^/s//\/\//<CR>
" Text width 72 on git commit messages
au filetype gitcommit setlocal textwidth=72 wrapmargin=72 wrap
" For almost all code
au BufEnter *.h,*.c,*.cpp,*.py,*.js,*.java,*.pl,*.sh setlocal textwidth=79

colorscheme desert
if &t_Co > 2 || has("gui_running")
   syntax on                    " switch syntax highlighting on, when the terminal has colors
endif

"set options for projects
"monetate
autocmd BufEnter ~/dev/prog/monetate/* setlocal textwidth=79 wrap 
autocmd BufEnter ~/dev/prog/monetate/* setlocal tabstop=4 shiftwidth=4 expandtab
