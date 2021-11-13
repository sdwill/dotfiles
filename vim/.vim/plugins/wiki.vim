augroup my_cm_setup
autocmd!
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd User WikiBufferInitialized call ncm2#register_source({
      \ 'name': 'wiki',
      \ 'priority': 9,
      \ 'scope': ['md'],
      \ 'word_pattern': '\w+',
      \ 'complete_pattern': '\[\[',
      \ 'on_complete': ['ncm2#on_complete#delay', 200,
      \                 'ncm2#on_complete#omni',
      \                 'wiki#complete#omnicomplete'],
      \})
augroup END

" Useful keybindings
nnoremap <leader>wo :WikiOpen<cr>
nnoremap <leader>wr :WikiRename<cr>


" ----- Prepend YYYY-MM-DD_ to filenames when using :WikiOpen
let g:wiki_map_create_page = 'CurrentDate'

function CurrentDate(name) abort
  let l:name = wiki#get_root() . '/' . a:name

  " If the file is new, then append the current date
  return filereadable(l:name)
        \ ? a:name
        \ : strftime('%Y-%m-%d') . '_' . a:name
endfunction
" -----

" Use Markdown-style links by default
let g:wiki_link_target_type = 'md'
