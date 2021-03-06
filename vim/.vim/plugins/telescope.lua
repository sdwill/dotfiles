require('telescope').setup {
    defaults = {
       file_ignore_patterns = { ".git" } 
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        }
    },
    defaults = {
        color_devicons = true,
        layout_config = {
            width = 0.95,
            horizontal = {
                preview_width = 0.6
            }
        }
    },
    pickers = {
        buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
        },
        find_files = {
            hidden = true
        },
        live_grep = {
            hidden = true
        },
        file_browser = {
            hidden = true
        }
    }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- Bring up the main Telescope dashboard
vim.api.nvim_set_keymap('n', '<leader><Space>', ':Telescope<CR>', {noremap = true, silent = true})

-- From telescope wiki on Github, but modified to be a local function
_G.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

-- File search
-- vim.api.nvim_set_keymap('n', '<C-P>', ':Telescope git_files<CR>', {noremap = false, silent = true})
vim.api.nvim_set_keymap('n', '<C-P>', "<CMD>lua project_files()<CR>", {noremap = false, silent = true})

-- Ctrl+F to search all text in directory. Ctrl+Shift+F cannot be distinguised from Ctrl+F in a terminal
vim.api.nvim_set_keymap('n', '<C-F>', ':Telescope live_grep<CR>', {noremap = true, silent = true})

-- Search open buffers, available commands, and lines in current file
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fc', ':Telescope commands<CR>', {noremap = true, silent = true})
