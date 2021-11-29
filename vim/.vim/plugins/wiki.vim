let g:wiki_root = '~/Box/notes'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'

let g:wiki_journal = {
    \ 'name': 'journal',
    \ 'frequency': 'daily',
    \ 'date_format': {
    \   'daily' : '%Y-%m-%d',
    \   'weekly' : '%Y_w%V',
    \   'monthly' : '%Y_m%m',
    \ },
    \}
augroup my_cm_setup
autocmd!
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd User WikiBufferInitialized call ncm2#register_source({
      \ 'name': 'wiki',
      \ 'priority': 9,
      \ 'scope': ['pandoc'],
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
nmap <leader>jj :WikiJournal<cr>
nmap <leader>]] :WikiJournalNext<cr>
nmap <leader>[[ :WikiJournalPrev<cr>
nmap <leader>ji :WikiOpen<cr>/journal/index.md<cr>
