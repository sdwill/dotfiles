-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove ALL autocommands for the current group (prevents duplication on reload)
-- This is handled automatically by nvim_create_augroup with clear = true

-- Highlight on yank
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = highlight_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Don't auto comment new lines
local no_auto_comment = augroup("NoAutoComment", { clear = true })
autocmd("BufEnter", {
  group = no_auto_comment,
  pattern = "*",
  command = "set formatoptions-=cro",
})

-- Restore cursor position when opening files
local restore_cursor = augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = restore_cursor,
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})
