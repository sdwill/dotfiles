require('kanagawa').setup({
    undercurl = true,
    commentStyle = "italic",
    functionStyle = "NONE",
    keywordStyle = "italic",
    statementStyle = "bold",
    typeStyle = "NONE",
    transparent = false,
    colors = {},
    overrides = {},
})

vim.cmd("colorscheme kanagawa")
