-- Keymaps configuration
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader keys are set in init.lua before plugins load

-- Insert timestamps
keymap("n", "<leader>t", 'O<C-R>=strftime("[%Y-%m-%d %I:%M %p]")<CR> ', opts)
keymap("i", "<M-t>", '<C-R>=strftime("[%Y-%m-%d %I:%M %p]")<CR>', opts)

-- Quit and write
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)

-- Move lines up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Jump to specific tabs by numbers
keymap("n", "<leader>1", "1gt", opts)
keymap("n", "<leader>2", "2gt", opts)
keymap("n", "<leader>3", "3gt", opts)
keymap("n", "<leader>4", "4gt", opts)
keymap("n", "<leader>5", "5gt", opts)
keymap("n", "<leader>6", "6gt", opts)
keymap("n", "<leader>7", "7gt", opts)
keymap("n", "<leader>8", "8gt", opts)
keymap("n", "<leader>9", "9gt", opts)
keymap("n", "<leader>0", ":tablast<CR>", opts)

-- Better line navigation for wrapped lines
keymap("n", "j", "gj", { silent = true })
keymap("n", "k", "gk", { silent = true })

-- Clear search highlighting
keymap("n", "<leader><BS>", ":noh<CR>", opts)

-- Open vimrc in new tab
keymap("n", "<F3>", ":tabe ~/.config/nvim/init.lua<CR>:tcd ~/dotfiles<CR>", opts)

-- Get path to current file relative to working directory
keymap("n", "<F4>", ':let @+ = "/" . expand("%")<CR>', opts)

-- Zen mode toggle (will be set by zen-mode plugin)
keymap("n", "<leader>g", ":ZenMode<CR>", opts)

-- Trim whitespace command
vim.api.nvim_create_user_command("TrimWhitespace", function()
  local save = vim.fn.winsaveview()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.fn.winrestview(save)
end, {})
