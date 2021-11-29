let g:lightline = {}
let g:lightline.enable = {
            \ 'statusline': 1,
            \ 'tabline': 0,
            \ }

" ----- Automatically reload the lightline theme
" See https://github.com/itchyny/lightline.vim/issues/241
function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

command! LightlineReload call LightlineReload()
