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
