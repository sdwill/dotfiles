-- Org-mode plugin configuration
-- This loads the org-mode implementation

local ok, org = pcall(require, "org")
if not ok then
  vim.notify("Org-mode module not found: " .. tostring(org), vim.log.levels.ERROR)
  return
end

local ok_config, config = pcall(require, "org.config")
if not ok_config then
  vim.notify("Org-mode config not found: " .. tostring(config), vim.log.levels.WARN)
  config = { agenda_files = {} }
end

-- Setup org-mode with user configuration
local ok_setup, err = pcall(function()
  org.setup({
    agenda_files = config.agenda_files,
  })
end)

if not ok_setup then
  vim.notify("Org-mode setup failed: " .. tostring(err), vim.log.levels.ERROR)
  return
end

-- Setup global keybindings
local ok_keys, err_keys = pcall(org.setup_global_keybindings)
if not ok_keys then
  vim.notify("Org-mode keybindings failed: " .. tostring(err_keys), vim.log.levels.ERROR)
end
