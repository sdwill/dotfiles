" ----- joshdick/onedark.vim
if (has("autocmd"))
  augroup colorextend
    autocmd!
    " Make pandoc markdown headers bold (linked in the plugin syntax file to
    " Title group)
    autocmd ColorScheme * call onedark#extend_highlight("Title", { "gui": "bold" })
  augroup END
endif
let g:onedark_color_overrides = {
\ "white": {"gui": "#C3CBD9", "cterm": "235", "cterm16": "0" },
\}
colorscheme onedark
" -----
