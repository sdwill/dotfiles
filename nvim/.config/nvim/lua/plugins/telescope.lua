-- Telescope fuzzy finder
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      { "<leader><Space>", "<cmd>Telescope<cr>", desc = "Telescope" },
      { "<C-p>", function()
        local ok = pcall(require("telescope.builtin").git_files, {})
        if not ok then
          require("telescope.builtin").find_files({})
        end
      end, desc = "Find Files" },
      { "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>ff", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          file_ignore_patterns = { ".git" },
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
      telescope.load_extension("file_browser")
    end,
  },
}
