let g:tex_conceal = ""
let g:pandoc#syntax#conceal#urls = 1  " Conceal URLs in links
let g:pandoc#syntax#conceal#use = 0  " Globally toggle conceal features
let g:pandoc#modules#disabled = ["spell", "folding"]
let g:pandoc#syntax#codeblocks#embeds#langs = [
            \'yaml',
            \'latex=tex',
            \'python',
            \'bash=sh',
            \'vim',
            \]
let g:pandoc#biblio#sources = "g"
let g:pandoc#biblio#bibs = ['/home/scott/Google Drive/notes/textbooks.bib']
let g:pandoc#compiler#command = "python build_note.py"

" ---- Disable vim-pandoc's built-in conceal (underline) for strikethrough text and use actual strikethrough
" See https://www.reddit.com/r/vim/comments/g631im/any_way_to_enable_true_markdown_strikethrough/
let g:pandoc#syntax#conceal#blacklist = ['strikeout']
let g:pandoc#syntax#style#underline_special = 0

hi TrueStrikethrough gui=strikethrough cterm=strikethrough
" hi Conceal         guifg=red
call matchadd('TrueStrikethrough', '\~\~\zs.\+\ze\~\~')
" call matchadd('Conceal',  '\~\~\ze.\+\~\~', 10, -1, {'conceal':''})
" call matchadd('Conceal',  '\~\~.\+\zs\~\~\ze', 10, -1, {'conceal':''})
" -----
"
" ----- Build current note
" map <silent><F9> :make %:r<cr>
map <silent><leader>pb >:!python build_note.py %<cr>
" map <silent><S-F9> :!python build_note.py --to pdf %<cr>
" noremap <F8>:exe ':silent !google-chrome'<cr>

" Display the current HTML file in Firefox (if it exists).
" This requires the working directory to be notes/
map <leader>pd :!open build/%:r.html &<cr>
" -----

" ----- Let pandoc TOC persist after navigation
let g:pandoc#toc#close_after_navigating = 0
