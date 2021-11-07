" Set syntax highlighting for markdown files.
" See https://stackoverflow.com/questions/10964681/enabling-markdown-highlighting-in-vim
" au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Fenced code block syntax highlighting
let g:markdown_fenced_languages = ['python', 'bash=sh']
let g:tex_conceal = ""  " Don't conceal LaTeX
let g:vim_markdown_math = 1 " LaTeX math
let g:vim_markdown_frontmatter = 1 " YAML frontmatter
let g:vim_markdown_strikethrough = 1 " Strikethrough
let g:vim_markdown_autowrite = 1  " Autosave changes when following links
let g:vim_markdown_folding_disabled = 1  " Disable folding by default
let g:vim_markdown_folding_level = 2  " If above is not disabled, then this sets the header level for folding
set conceallevel=2
let g:vim_markdown_frontmatter = 1  " Enable syntax extension for markdown frontmatter
let g:vim_markdown_folding_style_pythonic = 0
