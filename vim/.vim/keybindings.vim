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

" ----- Insert timestamps
nmap <leader>t O<C-R>=strftime("[%Y-%m-%d %I:%M %p]")<CR><space>
imap <M-t> <C-R>=strftime("[%Y-%m-%d %I:%M %p]")<CR>
" -----

" ----- Maps quit
noremap <leader>q :q<cr>
" -----

" ----- Write buffer
if !exists('g:vscode')
    noremap <leader>w :w<cr>
endif 
" -----
" ----- Move lines around
nnoremap <A-j> :m .+1<CR>
nnoremap <A-k> :m .-2<CR>
inoremap <A-j> <Esc>:m .+1<CR>
inoremap <A-k> <Esc>:m .-2<CR>
vnoremap <A-j> :m '>+1<CR>gv
vnoremap <A-k> :m '<-2<CR>gv
" -----

" ----- Jump to specific tabs by numbers
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>
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


" ----- Focus mode
if !exists('g:vscode')
    " map<silent><leader>g :Goyo<cr>
    " map <leader>g :TZAtaraxis <cr>
    map <leader>g :ZenMode<cr>
endif
" -----

nmap <silent>j gj
nmap <silent>k gk

" Found here: https://www.reddit.com/r/vim/comments/44e1ig/airline_and_bufferline/
nnoremap gb :ls<CR>:buffer<Space>

" ----- Deselects currently highlighted searches
nnoremap <Leader><BS> :noh<cr>
" -----

" Easily open .vimrc file
" From https://vi.stackexchange.com/questions/13105/keymap-for-open-vimrc-edit-save-and-reload
nnoremap <F3> :tabe ~/.vimrc<CR>

" Get path to current file, relative to working directory.  Add a forward
" slash in the beginning for use with wiki.vim, so that the path is relative
" to the wiki root
nnoremap <silent><F4> :let @+ = "/" . expand("%")<cr>
" autocmd BufWritePost .vimrc source $MYVIMRC

" ----- Quit all files
" noremap <leader><c-q> :qa<cr>
" -----

" call github_colors#togglebg_map('<f5>')  "Toggle the background color

