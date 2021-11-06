-- rafamadriz/neon
-- Options: default, doom, dark, light
vim.g.neon_style = "doom"
vim.g.neon_italic_comment = false
vim.g.neon_bold = true
vim.api.nvim_set_var("lightline", {colorscheme = "one"})
vim.cmd[[colorscheme neon]]
--
