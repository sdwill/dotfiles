" -----
" General settings
" -----
set tabstop=4       " Number of spaces that a tab ccunts for
set softtabstop=4   " ???
set shiftwidth=4    " Spaces for autoindents
set expandtab       " Turn tabs into spaces
set number relativenumber
set t_Co=256
set wildmenu    " Enhanced tab completion in menus
set ignorecase  " Case-insensitive search
set smartcase   " Search becomes case sensitive if capital letter
set smartindent " Smart auto-indent (???)
set smarttab    " ???
set showcmd     " Show typed command in status bar
set wildmenu    " Completion with menu (???)
set showmatch   " Show matching bracket
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set mouse=a     " Enable mouse everywhere
set hlsearch " Highlight search matches
"--- These three settings are required by vim-ctrlspace
set nocompatible
set hidden
set encoding=utf-8
"---
filetype plugin on
set scrolloff=10  " Keep cursor 10 lines from screen border when scrolling
set wildignore+=.git,.hg,.svn,.idea,.pytest_cache,__pycache__,.DS_Store,tags
set clipboard=unnamedplus  " Yank/paste from system clipboard by default
set linebreak  " Don't split words when softwrapping
" if exists('+termguicolors')
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors
" endif
set termguicolors  " True color mode
" set guifont=JetBrains\ Mono:h18
" set guifont=Fira\ Code:h18

" set cursorline      " Highlight the current line
syntax on
set splitbelow  " Open horizontal splits below
set splitright  " Open vertical splits to the right

" Live preview of search/replace. Only works with neovim
if exists('&inccommand')
  set inccommand=split
endif
