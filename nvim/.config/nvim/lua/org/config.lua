-- User configuration for org-mode
-- This file contains the user's agenda files and customizations

local M = {}

-- Your agenda files
M.agenda_files = {
  "~/Documents/notes/journal/2026/general.org",
  "~/Documents/notes/journal/2026/leave.org",
  "~/Documents/notes/journal/2026/hwo.org",
  "~/Documents/notes/inbox.org",
}

-- Expand ~ to home directory
for i, file in ipairs(M.agenda_files) do
  M.agenda_files[i] = vim.fn.expand(file)
end

return M
