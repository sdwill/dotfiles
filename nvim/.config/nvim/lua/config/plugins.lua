-- Plugin configurations
-- All plugins are loaded via vim.pack, configs are applied here

-- Color scheme
vim.g.everforest_background = "soft" -- 'hard', 'medium', 'soft'
vim.cmd("colorscheme everforest")

-- Taboo (custom tab names)
vim.opt.guioptions:remove("e")
vim.opt.sessionoptions:append({ "tabpages", "globals" })
vim.g.taboo_tab_format = " %N %f%m "
vim.g.taboo_renamed_tab_format = " %N [%l]%m "

-- Load plugin-specific configurations
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.completion")
require("plugins.telescope")
require("plugins.lualine")
require("plugins.which-key")
require("plugins.todo-comments")
require("plugins.zen-mode")
require("plugins.toggleterm")
require("plugins.autosave")
