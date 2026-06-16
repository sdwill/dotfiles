-- Plugin configuration with lazy.nvim
require("lazy").setup({
  -- Import all plugin specs from lua/plugins/
  { import = "plugins" },
}, {
  -- Lazy.nvim options
  defaults = {
    lazy = false, -- Don't lazy-load by default
    version = false, -- Always use the latest git commit
  },
  install = {
    colorscheme = { "everforest" },
  },
  checker = {
    enabled = false, -- Don't automatically check for updates
  },
  performance = {
    rtp = {
      -- Disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
