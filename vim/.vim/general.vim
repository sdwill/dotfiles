" -----
" General settings
" -----
set tabstop=4       " Number of spaces that a tab ccunts for
set softtabstop=4   " ???
set breakindent     " Soft-wrapped lines are indented to parent indenting level
" set breakindentopt="list:-1"
set breakindentopt=list:-1  " Better softwrapping for lists
" --- Improve softwrapping for checkboxes
" See https://www.reddit.com/r/vim/comments/gc3cp2/autowrapping_text_with_a_checkbox/
set formatlistpat=^\s*                   " Optional leading whitespace
set formatlistpat+=[                        " Start character class
set formatlistpat+=\\[({]\\?                " |  Optionally match opening punctuation
set formatlistpat+=\\(                      " |  Start group
set formatlistpat+=[0-9\ xX]\\+             " |  |  Numbers
set formatlistpat+=\\\|                     " |  |  or
set formatlistpat+=[a-zA-Z]\\+              " |  |  Letters
set formatlistpat+=\\)                      " |  End group
set formatlistpat+=[\\]:.)}                 " |  Closing punctuation
set formatlistpat+=]                        " End character class
set formatlistpat+=\\s\\+                   " One or more spaces
" ---
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

" ----- Enable strikethrough and undercurl in kitty, xterm, alacritty, and tmux
" See https://stackoverflow.com/questions/59956790/terminal-vim-strikethrough
if &term =~ 'xterm\|kitty\|alacritty\|tmux'
    let &t_Ts = "\e[9m"   " Strikethrough
    let &t_Te = "\e[29m"
    let &t_Cs = "\e[4:3m" " Undercurl
    let &t_Ce = "\e[4:0m"
endif
