-- Modern Neovim configuration using native vim.pack
-- Compatible with Neovim 0.12+

-- Set leader keys before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Bootstrap plugin manager (installs plugins on first run)
require("config.bootstrap")

-- Load core settings
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Load plugin configurations
require("config.plugins")
