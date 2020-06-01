call plug#begin(stdpath('data') . '/plugged')

" ui

Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" language plugins
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'tag': '*' }

" async linter
Plug 'dense-analysis/ale'

call plug#end()

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

"colorscheme iceberg
colorscheme nord

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

let g:airline_powerline_fonts = 1

let mapleader = ","

map <Leader>N :NERDTreeToggle<CR>
