" Automatically install vim-plug if it doesn't already exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" ----- Editing and other utilities
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'folke/todo-comments.nvim'
Plug 'justinmk/vim-sneak'
Plug 'dkarter/bullets.vim'          " Utilities for bulleted lists
Plug 'mhinz/vim-startify'           " Landing page
" Plug 'glepnir/dashboard-nvim'  " Another landing page
Plug 'Pocco81/AutoSave.nvim'  " Autosave!
Plug 'akinsho/nvim-toggleterm.lua'  " Terminals
" Plug 'numtostr/FTerm.nvim'  " Floating terminals
" Plug 'voldikss/vim-floaterm'      " Floating terminal
" Plug 'equalsraf/neovim-gui-shim'  " Shim for neovim-qt gui features
Plug 'Asheq/close-buffers.vim'  " Close all invisible buffers
Plug 'gcmt/taboo.vim'  " Assign custom tab names
" -----
Plug 'lervag/wiki.vim'
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
Plug 'junegunn/vim-easy-align'  " Align tables
" Plug 'zef/vim-cycle'
Plug 'gpanders/vim-medieval'  " Execute code blocks in markdown files
Plug 'tpope/vim-fugitive'  " Git integration

" ---- LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'williamboman/nvim-lsp-installer'
Plug 'ray-x/lsp_signature.nvim'
" Plug 'RishabhRD/popfix'
" Plug 'RishabhRD/nvim-lsputils'
"
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
Plug 'ray-x/navigator.lua'
" -----

" -----
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-orgmode/orgmode'
" -----

" enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
" set completeopt=noinsert,menuone,noselect
" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
" Plug 'ncm2/ncm2-path'
" -----
set completeopt=menu,menuone,noselect

" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'rbgrouleff/bclose.vim'        " Ranger dependency when using neovim
Plug 'francoiscabrol/ranger.vim'    " Integrate with ranger
" Plug 'famiu/nvim-reload'            " Enable complete reloading of config
" Plug 'godlygeek/tabular'
" Plug 'TaDaa/vimade'            " Fade inactive buffers
Plug 'liuchengxu/vim-which-key'
" -----

" ----- Status lines
" Plug 'itchyny/lightline.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'mengelbrecht/lightline-bufferline'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lualine/lualine.nvim'
" Plug 'kdheepak/tabline.nvim'
" Plug 'akinsho/nvim-bufferline.lua'
" Plug 'romgrk/barbar.nvim'           " Nicer tabline (doesn't work with goyo)
" -----

" ----- Finders
" Plug 'vim-ctrlspace/vim-ctrlspace'  " Smart buffer/tab management
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" -----

" ----- Syntax highlighting
" Plug 'vim-latex/vim-latex'
Plug 'lervag/vimtex'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'plasticboy/vim-markdown'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" -----

" ----- Zen modes
Plug 'szw/vim-maximizer'  " Toggle maximization for a single window
" Plug 'junegunn/goyo.vim'            " Distraction-free writing (having a problem with it resetting line numbers though...
" Plug 'Pocco81/TrueZen.nvim'         " Better zen mode? (Tabline vanishes on exit, plus an E492)
Plug 'folke/zen-mode.nvim'              " Yet another zen mode
" Plug 'henriquehbr/lua-helpers'
" Plug 'henriquehbr/ataraxis.lua'
" -----

" ----- Color schemes
" Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'
Plug 'embark-theme/vim'
Plug 'rakr/vim-one'
Plug 'romgrk/doom-one.vim'
Plug 'rafamadriz/neon'
Plug 'jsit/toast.vim'
Plug 'glepnir/zephyr-nvim'
Plug 'ajmwagar/vim-deus'
Plug 'NLKNguyen/papercolor-theme'
Plug 'folke/tokyonight.nvim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'arcticicestudio/nord-vim'
Plug 'lifepillar/vim-solarized8'
Plug 'sdwill/vim-colors-github'     " My own fork of cormacrelf/vim-colors-github with tuned colors
Plug 'preservim/vim-colors-pencil'  " Color scheme for writing
Plug 'Th3Whit3Wolf/one-nvim'        " Neovim colorscheme that supports tree-sitter
Plug 'navarasu/onedark.nvim'        " Another onedark scheme
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }"
Plug 'EdenEast/nightfox.nvim'
Plug 'rebelot/kanagawa.nvim'
" -----

Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'       " Nice icons- always has to be loaded last
call plug#end()
