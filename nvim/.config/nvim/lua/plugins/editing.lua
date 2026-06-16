-- Core editing plugins
return {
  -- Surround text objects with quotes, brackets, etc.
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },

  -- Session management
  {
    "tpope/vim-obsession",
    cmd = "Obsession",
  },
}
