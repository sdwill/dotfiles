-- Which-key keybinding hints
local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

wk.setup({
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
})
