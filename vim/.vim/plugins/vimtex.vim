" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:


" TeXShop: having issues with viewer not updating after recompilation
" let g:vimtex_view_method = 'texshop'
" let g:vimtex_view_texshop_activate = 1  " Focus on TeXShop after compilation
" let g:vimtex_view_texshop_sync = 1  " Forward sync to cursor position after compilation
"
" Sioyek: like TeXShop, having issues with viewer not updating after
" recompilation
" let g:vimtex_view_method = 'sioyek'

" Zathura
let g:vimtex_view_method = 'zathura'

" " Or with a generic interface:
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" let g:vimtex_view_general_options_latexmk = '--unique'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexmk'

" The default mapping toggles "continuous" mode, which I absolutely do not
" want because it recompiles every time I make even the tiniest change.
" Remap this to "single shot" compilation mode instead.
nnoremap <localleader>bb :VimtexCompileSS<cr>
nnoremap <localleader>bv :VimtexView<cr>

" Disable automatic quickfix popup
let g:vimtex_quickfix_mode = 0

" " Set up server for forward and reverse search.
" " See https://jdhao.github.io/2021/02/20/inverse_search_setup_neovim_vimtex/
" function! s:write_server_name() abort
"   let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
"   call writefile([v:servername], nvim_server_file)
" endfunction

" augroup vimtex_common
"   autocmd!
"   autocmd FileType tex call s:write_server_name()
" augroup END
