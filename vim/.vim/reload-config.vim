" ----- Reload vimrc config
"
" function! ReloadConfig()
"     scurce ~/.vimrc
"     call LightlineReload()
"     syntax clear
"     syntax on
" endfunction

if !exists('g:vscode')
    noremap <leader>R :source ~/.vimrc<cr> :LightlineReload<cr>
else
    noremap <leader>R :source ~/.vimrc<cr>
endif
" noremap <leader>R :ReloadConfig
" noremap <leader>R :Reload<cr>
" -----

if !exists('g:vscode')
" Always reload syntax highlighting at the end
" I could do this as part of the config reload but I think doing it here
" achieves the same outcome
    syntax clear 
    syntax on
endif
" -----


