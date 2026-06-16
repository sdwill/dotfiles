-- Terminal management
return {
  {
    "akinsho/nvim-toggleterm.lua",
    keys = {
      { [[<c-\>]], desc = "Toggle Terminal" },
    },
    opts = {
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
    },
  },
}
