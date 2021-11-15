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
" plugins, which we can check instead withcut relying on them being loaded.
if has_key(plugs, 'fzf.vim') && !exists('g:vscode')
    " let $FZF_DEFAULT_OPTS="--ansi --preview-window --layout reverse --preview='bat --theme=TwoDark --color=always --style=header,grid"
    " let $BAT_THEME='OneHalfDark'
    let $BAT_THEME='Solarized (light)'
    let $FZF_DEFAULT_COMMAND = 'rg --hidden -l ""'
    " let $FZF_DEFAULT_COMMAND="fd --type=file --color=always --hidden"
    let $FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never {} || cat {} || tree -C {}"
    let $FZF_DEFAULT_OPTS="--preview='bat --color=always' --preview-window 'right:60%' --layout reverse --ansi"
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
    " nnoremap <silent> <leader>B :Buffers<CR>

    " Commands
    nnoremap <silent> <leader>c :Commands<CR>

    " Lines in current file
    nnoremap <silent> <leader>l :Lines<CR>

    " Fuzzy autocomplete
    imap <c-x><c-f> <plug>(fzf-complete-path)
 endif
" -----

" ----- Customize colors of fzf prompt to match current color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
