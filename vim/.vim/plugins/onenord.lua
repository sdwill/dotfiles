require('onenord').setup({
borders = true, -- Split window borders
italics = {
  comments = false, -- Italic comments
  strings = false, -- Italic strings
  keywords = false, -- Italic keywords
  functions = false, -- Italic functions
  variables = false, -- Italic variables
},
disable = {
  background = false, -- Disable setting the background color
  cursorline = false, -- Disable the cursorline
  eob_lines = true, -- Hide the end-of-buffer lines
},
custom_highlights = {}, -- Overwrite default highlight groups
})

vim.cmd("colorscheme onenord")
vim.cmd("let g:lightline.colorscheme = 'nord'")
