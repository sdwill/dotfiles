-- Telescope fuzzy finder
local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

telescope.setup({
  defaults = {
    file_ignore_patterns = { ".git" },
    -- Disable icons if you don't have a Nerd Font installed
    -- Set to false to avoid missing glyphs
    color_devicons = true,
    layout_config = {
      width = 0.95,
      horizontal = {
        preview_width = 0.6,
      },
    },
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
    },
    find_files = {
      hidden = true,
    },
    live_grep = {
      hidden = true,
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      hidden = true,
    },
  },
})

-- Load extensions
pcall(telescope.load_extension, "file_browser")

-- Keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader><Space>", "<cmd>Telescope<cr>", opts)
keymap("n", "<C-p>", function()
  local ok = pcall(require("telescope.builtin").git_files, {})
  if not ok then
    require("telescope.builtin").find_files({})
  end
end, opts)
keymap("n", "<C-f>", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fc", "<cmd>Telescope commands<cr>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope file_browser<cr>", opts)
