-- Terminal management
local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return
end

toggleterm.setup({
  direction = "float",
  size = 40,
  open_mapping = [[<c-\>]],
  float_opts = {
    border = "curved",
    winblend = 3,
    width = 200,
    height = 100,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})
