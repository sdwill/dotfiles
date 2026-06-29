-- Bootstrap plugins using vim.pack (native package manager)
-- Plugins are installed to ~/.local/share/nvim/site/pack/plugins/start/

local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start"

-- List of plugins to install
local plugins = {
  -- Core editing
  "tpope/vim-surround",
  "tpope/vim-obsession",

  -- Treesitter
  "nvim-treesitter/nvim-treesitter",
  "nvim-orgmode/tree-sitter-org",

  -- LSP
  "neovim/nvim-lspconfig",

  -- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",

  -- Navigation
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-file-browser.nvim",

  -- UI
  "nvim-lualine/lualine.nvim",
  "mhinz/vim-startify",
  "folke/which-key.nvim",
  "nvim-tree/nvim-web-devicons",
  "gcmt/taboo.vim",

  -- Features
  "folke/todo-comments.nvim",
  "folke/zen-mode.nvim",
  "akinsho/nvim-toggleterm.lua",
  "Pocco81/auto-save.nvim",

  -- Color schemes
  "sainnhe/everforest",
  "sainnhe/edge",
  "sainnhe/sonokai",
  "folke/tokyonight.nvim",
  "rebelot/kanagawa.nvim",
}

-- Function to check if a plugin is installed
local function is_installed(plugin_name)
  local plugin_path = pack_path .. "/" .. plugin_name:match("([^/]+)$")
  return vim.fn.isdirectory(plugin_path) == 1
end

-- Function to install a plugin
local function install_plugin(plugin_url)
  local plugin_name = plugin_url:match("([^/]+)$")
  local install_path = pack_path .. "/" .. plugin_name

  if not is_installed(plugin_url) then
    print("Installing " .. plugin_name .. "...")
    vim.fn.system({
      "git",
      "clone",
      "--depth=1",
      "--single-branch",
      "https://github.com/" .. plugin_url .. ".git",
      install_path,
    })
    print("Installed " .. plugin_name)
    return true
  end
  return false
end

-- Create pack directory if it doesn't exist
if vim.fn.isdirectory(pack_path) == 0 then
  vim.fn.mkdir(pack_path, "p")
end

-- Install missing plugins
local any_installed = false
for _, plugin in ipairs(plugins) do
  if install_plugin(plugin) then
    any_installed = true
  end
end

-- If any plugins were installed, regenerate helptags and suggest restart
if any_installed then
  vim.cmd("helptags ALL")
  print("\n✨ Plugins installed! Please restart Neovim.\n")
end

-- Update Treesitter parsers function (call manually with :TSBootstrap)
vim.api.nvim_create_user_command("TSBootstrap", function()
  vim.cmd("TSUpdate")
  print("Treesitter parsers updated!")
end, {})

-- Update all plugins function (call manually with :PackUpdate)
vim.api.nvim_create_user_command("PackUpdate", function()
  print("Updating plugins...")
  for _, plugin in ipairs(plugins) do
    local plugin_name = plugin:match("([^/]+)$")
    local plugin_path = pack_path .. "/" .. plugin_name
    if vim.fn.isdirectory(plugin_path) == 1 then
      print("Updating " .. plugin_name .. "...")
      vim.fn.system({ "git", "-C", plugin_path, "pull", "--ff-only" })
    end
  end
  vim.cmd("helptags ALL")
  print("✨ All plugins updated! Restart Neovim to load changes.")
end, {})

-- Remove unused plugins (call manually with :PackClean)
vim.api.nvim_create_user_command("PackClean", function()
  local installed_plugins = vim.fn.readdir(pack_path)
  local plugin_names = {}
  for _, plugin in ipairs(plugins) do
    plugin_names[plugin:match("([^/]+)$")] = true
  end

  for _, installed in ipairs(installed_plugins) do
    if not plugin_names[installed] then
      local plugin_path = pack_path .. "/" .. installed
      print("Removing " .. installed .. "...")
      vim.fn.delete(plugin_path, "rf")
    end
  end
  print("✨ Unused plugins removed!")
end, {})

-- Show plugin status (call with :PackStatus)
vim.api.nvim_create_user_command("PackStatus", function()
  print("Plugin Status:\n")
  for _, plugin in ipairs(plugins) do
    local plugin_name = plugin:match("([^/]+)$")
    local status = is_installed(plugin) and "✓ installed" or "✗ missing"
    print(string.format("  %-40s %s", plugin_name, status))
  end
  print("\nCommands: :PackUpdate, :PackClean, :PackStatus")
end, {})
