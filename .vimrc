set tabstop=4       " Number of spaces that a tab counts for
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

" " For neovide and goneovim.  h18 -> 18 pt font
if exists('+guifont')
    " set guifont=Fira\ Code:h18
    set guifont=Iosevka\ Term,JetBrainsMono\ Nerd\ Font:h20
"     " set guifont=iA\ Writer\ Mono\ S:h18
"     " set guifont=Victor\ Mono:h18
"     set guifont=JetBrains\ Mono:h18
"     " set guifont=Cascadia\ Mono:h18
"     " set guifont=Inconsolata:h20
"     " set guifont=Inconsolata\ Condensed:h20
"     " set guifont=Input\ Mono:h18
"     " set guifont=Monoid:h16
"     " set guifont=Noto\ Mono:h14
"     " set guifont=Source\ Code\ Pro:h14
"     " set guifont=Ubuntu\ Mono:h20
"     " set guifont=JuliaMono:h18
endif
" For neovim-qt:  set the font and use the TUI tabline rather than the GUI tabline
" GuiFont! (with the exclamation point) fixes the error [font] is not a fixed-pitch font!
" GuiFont! Iosevka\ Term:h14
" GuiFont! Cascadia\ Mono:h14
" GuiFont! JuliaMono:h13
" GuiTabline 0
" set cursorline      " Highlight the current line
syntax on
set splitbelow  " Open horizontal splits below
set splitright  " Open vertical splits to the right

" Live preview of search/replace. Only works with neovim
if exists('&inccommand')
  set inccommand=split
endif

" Easily open .vimrc file
" From https://vi.stackexchange.com/questions/13105/keymap-for-open-vimrc-edit-save-and-reload
nnoremap <F3> :tabe ~/.vimrc<CR>
" autocmd BufWritePost .vimrc source $MYVIMRC

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'           " Landing page
" Plug 'glepnir/dashboard-nvim'  " Another landing page
" Plug 'famiu/nvim-reload'            " Enable complete reloading of config
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'mengelbrecht/lightline-bufferline'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug '~/.fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'godlygeek/tabular'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'joshdick/onedark.vim'
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'
Plug 'dkarter/bullets.vim'          " Utilities for bulleted lists
Plug 'vim-ctrlspace/vim-ctrlspace'  " Smart buffer/tab management
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'Th3Whit3Wolf/one-nvim'        " Neovim colorscheme that supports tree-sitter
Plug 'navarasu/onedark.nvim'        " Another onedark scheme
" Plug 'numtostr/FTerm.nvim'  " Floating terminals
Plug 'akinsho/nvim-toggleterm.lua'  " Terminals
Plug 'rakr/vim-one'
Plug 'romgrk/doom-one.vim'
" Plug 'ghifarit53/tokyonight-vim'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
" Plug 'arcticicestudio/nord-vim'
Plug 'lifepillar/vim-solarized8'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'vimwiki/vimwiki'
" Plug 'lervag/wiki.vim'
" Plug 'plasticboy/vim-markdown'
" Plug 'TaDaa/vimade'            " Fade inactive buffers
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Plug 'romgrk/barbar.nvim'           " Nicer tabline (doesn't work with goyo)
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'cormacrelf/vim-colors-github'
Plug 'sdwill/vim-colors-github'  " My own fork with tuned colors
" Plug 'voldikss/vim-floaterm'      " Floating terminal
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'akinsho/nvim-bufferline.lua'
Plug 'ryanoasis/vim-devicons'       " Nice icons- always has to be loaded last
Plug 'francoiscabrol/ranger.vim'    " Integrate with ranger
Plug 'rbgrouleff/bclose.vim'        " Ranger dependency when using neovim
Plug 'junegunn/goyo.vim'            " Distraction-free writing (having a problem with it resetting line numbers though...
" Plug 'Pocco81/TrueZen.nvim'         " Better zen mode? (Tabline vanishes on exit, plus an E492)
" Plug 'folke/zen-mode.nvim'              " Yet another zen mode
" Plug 'preservim/vim-colors-pencil'  " Color scheme for writing
call plug#end()

lua << EOF
    require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }

    require("toggleterm").setup{
        direction = 'float',
        size = 40,
        open_mapping = [[<c-\>]],
        float_opts = {
            -- The border key is *almost* the same as 'nvim_win_open'
            -- see :h nvim_win_open for details on borders however
            -- the 'curved' border is a custom border type
            -- not natively supported but implemented in this plugin.
            border = 'shadow',
            winblend = 3,
            highlights = {
                border = "Normal",
                background = "Normal",
            }
        }
    }
    require('telescope').setup {
        extensions = {
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
            }
        }
}
    -- To get fzf loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    require('telescope').load_extension('fzf')
EOF
    " require("zen-mode").setup {
    "     -- your configuration comes here
    "     -- or leave it empty to use the default settings
    "     -- refer to the configuration section below
    "     window = {
    "         backdrop = 1.05, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    "         -- height and width can be:
    "         -- * an absolute number of cells when > 1
    "         -- * a percentage of the width / height of the editor when <= 1
    "         width = 80, -- width of the Zen window
    "         height = 0.85, -- height of the Zen window
    "         -- by default, no options are changed for the Zen window
    "         -- uncomment any of the options below, or add other vim.wo options you want to apply
    "         options = {
    "             -- signcolumn = "no", -- disable signcolumn
    "             number = false, -- disable number column
    "             relativenumber = false, -- disable relative numbers
    "             cursorline = false, -- disable cursorline
    "             -- cursorcolumn = false, -- disable cursor column
    "             -- foldcolumn = "0", -- disable fold column
    "             -- list = false, -- disable whitespace characters
    "         },
    "         },
    "         plugins = {
    "             -- disable some global vim options (vim.o...)
    "             -- comment the lines to not apply the options
    "             options = {
    "                 enabled = true,
    "                 ruler = false, -- disables the ruler text in the cmd line area
    "                 showcmd = false, -- disables the command in the last line of the screen
    "             },
    "             gitsigns = { enabled = false }, -- disables git signs
    "             tmux = { enabled = false }, -- disables the tmux statusline
    "             -- this will change the font size on kitty when in zen mode
    "             -- to make this work, you need to set the following kitty options:
    "             -- - allow_remote_control socket-only
    "             -- - listen_on unix:/tmp/kitty
    "             kitty = {
    "                 enabled = false,
    "                 font = "+4", -- font size increment
    "             },
    "         },
    "         -- callback where you can add custom code when the Zen window opens
    "         on_open = function(win)
    "         end,
    "         -- callback where you can add custom code when the Zen window closes
    "         on_close = function()
    "         end,
    " }

" ----- dashboard-nvim
" let g:dashboard_default_executive = 'fzf'
" -----

" ----- vimade
" Fade inactive buffers
" let g:vimade = {}
" let g:vimade.fadelevel = 0.5
" let g:vimade.basebg = [75, 75, 75]
" -----

" ----- Markdown
" Set syntax highlighting for markdown files.
" See https://stackoverflow.com/questions/10964681/enabling-markdown-highlighting-in-vim
" au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Fenced code block syntax highlighting
" let g:markdown_fenced_languages = ['python', 'bash=sh']
let g:vim_markdown_math = 1 " LaTeX math
let g:vim_markdown_frontmatter = 1 " YAML frontmatter
let g:vim_markdown_strikethrough = 1 " Strikethrough
let g:vim_markdown_autowrite = 1  " Autosave changes when following links
" -----

" ----- vim-pandoc
let g:tex_conceal = ""
let g:pandoc#syntax#conceal#urls = 1  " Conceal URLs in links
" let g:pandoc#syntax#conceal#use = 0  " Globally toggle conceal features
let g:pandoc#modules#disabled = ["spell", "folding"]
let g:pandoc#syntax#codeblocks#embeds#langs = [
            \'yaml',
            \'latex=tex',
            \'python',
            \'bash=sh',
            \]
let g:pandoc#biblio#sources = "g"
let g:pandoc#biblio#bibs = ['/home/scott/Google Drive/notes/textbooks.bib']
let g:pandoc#compiler#command = "python build_note.py"
"""

" ----- Lightline
  " \ 'colorscheme': 'one',
    " \ 'colorscheme': 'github',
let g:lightline = {
  \ 'colorscheme': 'github',
  \ }
let g:lightline.enable = {
            \ 'statusline': 1,
            \ 'tabline': 1,
            \ }
" -----

" ----- lightline-bufferline
" let g:lightline#bufferline#enable_devicons = 1
" let g:lightline#bufferline#show_number = 2
" let g:lightline.component_raw = {'buffers': 1}  " Make bufferline clickable
" -----

""" Color schemes: more at https://vimcolorschemes.com/
set background=light
" NOTE: setting any of these colorschemes will cause bold/italics in Markdown
" to disappear after reloading .vimrc.
" See:
"   - https://github.com/vim-pandoc/vim-pandoc-syntax/issues/200
"   - https://github.com/altercation/solarized/issues/102
" Colors can be restored by resetting filetype manually, e.g. :setf pandoc

" ----- preservim/vim-colors-pencil
" let g:pencil_spell_undercurl = 0
" colorscheme pencil
" -----

" ----- Github cormacrelf/vim-colors-github
let g:github_colors_soft = 1
let g:github_colors_lock_diffmark = 0
colorscheme github
" let g:airline_theme = "github"
" -----

" ----- sainnhe/edge
" let g:edge_style = 'default'
" let g:airline_theme = 'edge'
" let g:lightline = {
"   \ 'colorscheme': 'edge',
"   \ }
" colorscheme edge
" -----

" ----- sainnhe/sonokai
" let g:sonokai_style = 'atlantis'
" let g:sonokai_enable_italic = 1
" let g:sonokai_disable_italic_comment = 1
" let g:lightline.colorscheme = 'sonokai'
" let g:sonokai_transparent_background = 0
" let g:airline_theme = 'sonokai'
" colorscheme sonokai
" -----

" ----- sainnhe/everforest
" let g:everforest_background = 'hard'
" let g:lightline.colorscheme = 'everforest'
" colorscheme everforest
" -----

" ----- ghifarit53/tokyonight-vim
" let g:airline_theme = "tokyonight"
" let g:tokyonight_style = 'storm' " available: night, storm
" colorscheme tokyonight
" -----

" ----- NLKNguyen/papercolor-theme
" colorscheme PaperColor
" let g:airline_theme="papercolor"
" -----

" ----- solarized8
" set background=light
" colorscheme solarized8
" -----

" ----- joshdick/onedark.vim
" if (has("autocmd"))
"   augroup colorextend
"     autocmd!
"     " Make pandoc markdown headers bold (linked in the plugin syntax file to
"     " Title group)
"     autocmd ColorScheme * call onedark#extend_highlight("Title", { "gui": "bold" })
"   augroup END
" endif
" colorscheme onedark
" -----

" ----- Vim one rakr/vim-one
" let g:airline_theme="one"
" colorscheme one
" -----

" ----- sonph/onehalf
" set background=dark
" colorscheme onehalfdark
" let g:airline_theme='onehalfdark'
" -----

" ----- romgrk/doom-one.vim
" let g:airline_theme="one"
" colorscheme doom-one
" -----

" ----- Th3Whit3Wolf/one-nvim
" colorscheme one-nvim
" -----

" ----- navarasu/onedark.nvim
" colorscheme onedark
" -----

" ----- arcticicestudios/nord-vim
" let g:airline_theme = 'nord'
" colorscheme nord
" -----

" ----- Airline config
" let g:airline_powerline_fonts = 1  " Use powerline fonts
" let g:airline_theme = "onedark"
" let g:airline#extensions#tabline#enabled = 1  " Enable tabline
" let g:airline#extensions#tabline#show_buffers = 0  " Disable buffers
" let g:airline#extensions#bufferline#enabled = 0  " Disable bufferline
" -----

" ----- CtrlSpace
let g:CtrlSpaceDefaultMappingKey = "<C-space> "  " Set default mapping for ctrl-space
" -----

" ----- Transparent background. Must be called AFTER colorscheme.
" See https://stackoverflow.com/questions/37712730/set-vim-background-transparent
" hi Normal guibg=NONE ctermbg=NONE
" hi NonText guibg=NONE
" -----

" ----- Press Space to turn off highlighting and clear any message already displayed.
"       From https://vim.fandom.com/wiki/Highlight_all_search_pattern_matches
" :nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" -----

" ----- Maps leader to the spacebar
let maplocalleader = ","
let leader = " "
let localleader = ","
let mapleader = " "
" -----

" ----- Maps quit
noremap <leader>q :q<cr>
" -----

" ----- Write buffer
noremap <leader>w :w<cr>
" -----

" ----- Reload vimrc config
noremap <leader>R :source ~/.vimrc<cr>
" noremap <leader>R :Reload<cr>
" -----

" ----- Maps quit all
" noremap <leader><c-q> :qa<cr>
" -----

" ----- Deselects currently highlighted searches
nnoremap <Leader><BS> :noh<cr>
" -----

" ----- fzf.vim
" Map keybindings to FZF preview.  First three are default.  Last one allows
" filename to be yanked, useful for inserting links.
" See https://github.com/junegunn/fzf.vim/issues/772
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

" FZF keybindings: checking whether :Files or :Commands exist doesn't work
" because plugins aren't loaded until after .vimrc.  See :help startup or
" https://vi.stackexchange.com/questions/10939/how-to-see-if-a-plugin-is-active
" vim-plug defines a plugs dictionary that contains keys for all loaded
" plugins, which we can check instead without relying on them being loaded.
if has_key(plugs, 'fzf.vim')
    " let $FZF_DEFAULT_OPTS="--ansi --preview-window --layout reverse --preview='bat --theme=TwoDark --color=always --style=header,grid"
    " let $FZF_DEFAULT_OPTS="--preview='bat --color=always' --preview-window 'right:60%' --layout reverse"
    " Ctrl+P to fuzzy-find files, similarly to VSCode/Sublime
    nmap <silent> <C-P> :Files<CR>

    " Ctrl+F to search all text in directory. Ctrl+Shift+F cannot be distinguised
    " from Ctrl+F in a terminal
    nnoremap <silent> <C-F> :Rg<CR>

    " Press Space-Space in normal mode to do an FZF search for all available
    " commands, similarly to the behavior in Spacemacs
    nnoremap <silent> <leader><Space> :Help<CR>

    " Buffers
    nnoremap <silent> <leader>b :Buffers<CR>

    " Commands
    nnoremap <silent> <leader>c :Commands<CR>

    " Lines in current file
    nnoremap <silent> <leader>l :Lines<CR>

    " Fuzzy autocomplete
    imap <c-x><c-f> <plug>(fzf-complete-path)
 endif
" -----

" call github_colors#togglebg_map('<f5>')  "Toggle the background color

let g:bullets_checkbox_markers = ' -x'
let g:bullets_set_mappings = 0

inoremap <M-cr> <Esc>:InsertNewBullet<cr>
nnoremap o :InsertNewBullet<cr>
vnoremap gN :RenumberSelection<cr>
nnoremap gN :RenumberList<cr>
nnoremap <leader>x :ToggleCheckbox<cr>
" nnoremap <leader>o :InsertNewBullet<cr><Esc>>>
" nnoremap <leader><M-o> :InsertNewBullet<cr><Esc>>> :call pandoc#keyboard#checkboxes#Delete()<cr>A
" nnoremap <leader><M-o>A<cr><Tab>
" Disable the promotion/demotion keybindings because they automatically force
" sub-bullets to use *, which I don't like
" inoremap <C-t> BulletDemote
" inoremap <C-d> BulletPromote
" nnoremap >> BulletDemote
" nnoremap << BulletPromote
" vnoremap > BulletDemoteVisual
" vnoremap < BulletPromoteVisual

" ----- Move lines around
nnoremap <A-j> :m .+1<CR>
nnoremap <A-k> :m .-2<CR>
inoremap <A-j> <Esc>:m .+1<CR>
inoremap <A-k> <Esc>:m .-2<CR>
vnoremap <A-j> :m '>+1<CR>gv
vnoremap <A-k> :m '<-2<CR>gv
" -----

" ----- Strip trailing whitespace
" Function, See https://vi.stackexchange.com/questions/454/
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Define command so that we can call it in Ex mode
command! TrimWhitespace call TrimWhitespace()
" -----

" ----- Bind F9 to make command for pandoc
" map <silent><F9> :make %:r<cr>
map <silent><F9> :!python build_note.py %<cr>
map <silent><S-F9> :!python build_note.py --to pdf %<cr>
" noremap <F8>:exe ':silent !google-chrome'<cr>

" Display the current HTML file in Firefox (if it exists).
" This requires the working directory to be notes/
map <F8> :!open -a firefox build/%:r.html &<cr>
" -----

" ----- Focus mode
map <silent><leader>g :Goyo<cr>
" map <leader>g :TZAtaraxis <cr>
" map <leader>g :ZenMode<cr>
" -----

" ----- Goyo: reapply colorscheme when exiting
" Goyo calls 'colorscheme [x]' when leaving, which causes the same issues as
" switching colorschemes in general, i.e. the highlighting disappears for many
" syntax elements.  To work around this, we just disable and re-enable syntax
" highlighting.
function! s:goyo_leave()
    syntax clear
    syntax on
endfunction
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" -----


