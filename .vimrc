set nocompatible

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'darfink/vim-plist'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'peitalin/vim-jsx-typescript'
Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'
Plug 'nelsyeung/twig.vim'
Plug 'tpope/vim-commentary'
Plug 'wincent/vcs-jump'
Plug 'airblade/vim-rooter'
Plug 'ap/vim-buftabline'
Plug 'vim-vdebug/vdebug'
" Initialize plugin system
call plug#end()

" Create persistent directiory if it doesn't exist
if !isdirectory("/tmp/.vim-undo-dir")
    call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif

if &t_Co > 2 || has("gui_running")
    set t_Co=256                 " force 256
    syntax on                    " switch syntax highlighting on, when the terminal has colors
endif
colorscheme desert
highlight Normal ctermfg=15 ctermbg=236
highlight Constant guifg=#a7cb8b ctermfg=113
highlight Type ctermfg=9
highlight Search ctermbg=LightYellow ctermfg=Red
highlight QuickFixLine ctermbg=none

" Change the mapleader from \ to ,
let mapleader=","

set showmode                    " always show what mode we're currently editing in
set wrap                        " wrap lines
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab										" use spaces instead of tabs
set smarttab                    " insert tabs on the start of a line according to shiftwidth
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,case-sensitive otherwise
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
set history=10                  " remember more commands and search history
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
set noeol					    " no newline at end of file
set autochdir                   " chdir when changing files
set undodir=/tmp/.vim-undo-dir  " set persistent dir to /tmp
set undofile                    " set persistent undo on

" Set tab title

" Status line options
" set the status line to contain the parent folder
set statusline=%<%{expand('%:p:h')}/%t
set statusline+=\ %h%m%r%=
set statusline+=\ %{FugitiveHead()}
set statusline+=\ %l,%c%V\ (%P)

" gutter
set updatetime=750
set signcolumn=number
highlight clear SignColumn
highlight! link SignColumn LineNr

" Add folding
set foldmethod=syntax
set foldlevelstart=20

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=0             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

" normal regexes
nnoremap / /\v
vnoremap / /\v
" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap <up> g<up>
nnoremap k gk
nnoremap <down> g<down>
" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d
" Yank/paste to the OS clipboard with ,y and ,p
map <leader>y "+y
map <leader>Y "+yy
vmap <leader>y "+y
vmap <leader>Y "+yy
map <leader>d "+d
map <leader>D "+dd
vmap <leader>d "+d
vmap <leader>D "+dd
map <leader>p "+p
map <leader>P "+P
" Clears highlight
nmap <silent> <leader>? :nohlsearch<CR>
" Sudo to write
cmap w!! w !sudo tee % >/dev/null
" Enter to create new line
map <S-Enter> O<Esc>
map <CR> o<Esc>
" buffer navigation
nmap <C-h> :bprev<CR>
nmap <C-l> :bnext<CR>
map <C-h> :bprev<CR>
map <C-l> :bnext<CR>
imap <C-h> <Esc>:bprev<CR>i
imap <C-l> <Esc>:bnext<CR>i
nnoremap <leader>1 :b 1<CR>
nnoremap <leader>2 :b 2<CR>
nnoremap <leader>3 :b 3<CR>
nnoremap <leader>4 :b 4<CR>
nnoremap <leader>5 :b 5<CR>
nnoremap <leader>6 :b 6<CR>
nnoremap <leader>7 :b 7<CR>
nnoremap <leader>8 :b 8<CR>
nnoremap <leader>9 :b 9<CR>
" open buffer with current dir
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" close buffer
map <C-d> :bd<CR>
" error navigation
map [p :ALEFirst<CR>
map [[ :ALENext<CR>
map [] :ALEPrev<CR>
" close preview
map <C-\> :pclose<CR>

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
" For almost all code
au BufEnter *.h,*.c,*.cpp,*.py,*.java,*.pl,*.sh setlocal textwidth=79
" JSON files as js
au BufEnter *.json set syntax=javascript textwidth=0 wrapmargin=0
" GO files as go
au BufEnter *.go set syntax=go textwidth=0 wrapmargin=0
" csd files as Csound
au BufEnter *.cs set syntax=csound textwidth=0 wrapmargin=0
" .tsx as typescript
au BufEnter *.ts set syntax=typescript filetype=typescript textwidth=120
au BufEnter *.tsx,*.jsx set filetype=typescriptreact textwidth=120
" graphql, not sure why it's needed again
au BufEnter *.graphql set tabstop=4 softtabstop=4 shiftwidth=4
" wrap loclist
au FileType qf setlocal wrap
" Close loclist automatically
au QuitPre * if empty(&buftype) | lclose | endif

set tags=tags;/

" plugin config
" fzf
map <leader>; :Files .<CR>
" Tabe equals in current dir
map <leader>. :Files <C-R>=expand("%:p:h") . "/" <CR><CR>
" ripgrep
map <leader>/ :Rg 
map <expr> <leader>* ':Rg '.expand('<cword>').'<CR>'

" nerdtree
map <C-e> :NERDTreeToggle<CR>

" ale  options
let g:ale_set_loclist=1                                 " use loclist
let g:ale_lint_on_insert_leave=1                        " lint on esc
let g:ale_open_list='on_save'                           " open loclist on save
let g:ale_list_window_size_max=10                       " max size of loclist
let g:ale_sign_error='❌'                               " error sign
let g:ale_sign_warning='•'                              " warning sign
autocmd User ALELintPost call s:ale_loclist_limit()     " automatically adjust loclist size
function! s:ale_loclist_limit()
    let b:ale_list_window_size = min([len(ale#engine#GetLoclist(bufnr('%'))), g:ale_list_window_size_max])
endfunction
" ale colors
highlight ALEError ctermbg=none cterm=underline
highlight ALEWarning ctermbg=none cterm=underline
highlight ALEErrorSign ctermbg=NONE ctermfg=darkred
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:lt_location_list_toggle_map = '<C-z>'             " toggle loclist
let g:ale_linter_aliases = {
 \ 'typescript': ['javascript', 'css', 'typescript'],
 \ 'typescriptreact': ['javascript', 'css', 'typescript'],
 \  }
let g:ale_linters = {
 \ 'javascript': ['eslint'],
 \ 'typescript': ['eslint', 'tsserver', 'stylelint'],
 \ 'typescriptreact': ['eslint', 'tsserver', 'stylelint'],
 \ 'graphql': [],
 \ 'json': [],
 \ 'php': ['phpcs', 'psalm'],
 \ }
let g:ale_fixers = {
 \ 'javascript': ['prettier'],
 \ 'typescript': ['prettier', 'stylelint'],
 \ 'typescriptreact': ['prettier'],
 \ 'graphql': ['prettier'],
 \ 'less': ['prettier'],
 \ 'php': ['phpcbf'],
 \ }
let g:ale_fix_on_save = 1

" rooter
let g:rooter_patterns = ['=src', '.git']

" tabline
let g:buftabline_indicators = 1
let g:buftabline_numbers=1

" load local config it exists
try 
      source ~/.vimrc_local
catch
endtry 
