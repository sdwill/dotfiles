-- Folding implementation for org-mode
-- Handles TAB cycling, structural editing, promote/demote

local ts = require("org.treesitter")
local M = {}

-- Fold states for cycling
local FOLD_STATES = {
  FOLDED = "folded",
  CHILDREN = "children",
  EXPANDED = "expanded",
}

-- Global fold state (for Shift-TAB cycling)
-- States: 0 = all folded, 1 = show level 1, 2 = show all headlines, 3 = show all
local global_fold_state = 0

-- Set up folding for an org buffer
function M.setup_buffer(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- Use tree-sitter for folding
  vim.api.nvim_buf_set_option(bufnr, "foldmethod", "expr")
  vim.api.nvim_buf_set_option(bufnr, "foldexpr", "v:lua.require'org.fold'.foldexpr()")
  vim.api.nvim_buf_set_option(bufnr, "foldtext", "v:lua.require'org.fold'.foldtext()")
end

-- Fold expression function for vim folding
function M.foldexpr()
  local lnum = vim.v.lnum
  local bufnr = vim.api.nvim_get_current_buf()

  -- Get line text
  local line = vim.fn.getline(lnum)

  -- Check if line starts with stars (headline)
  local stars = line:match("^(%*+)%s")
  if stars then
    return ">" .. #stars
  end

  -- Check if it's a drawer
  if line:match("^%s*:") and (line:match(":LOGBOOK:") or line:match(":PROPERTIES:") or line:match(":END:")) then
    if line:match(":END:") then
      return "<1"
    else
      return "a1"
    end
  end

  return "="
end

-- Custom fold text
function M.foldtext()
  local line = vim.fn.getline(vim.v.foldstart)
  local fold_size = vim.v.foldend - vim.v.foldstart + 1
  return line .. " ... (" .. fold_size .. " lines)"
end

-- Check if cursor is on a headline
function M.is_on_headline()
  local line = vim.api.nvim_get_current_line()
  return line:match("^%*+%s") ~= nil
end

-- Cycle fold state (TAB key behavior)
function M.cycle_fold()
  local line = vim.fn.line(".")
  local foldclosed = vim.fn.foldclosed(line)

  if foldclosed ~= -1 then
    -- Currently folded -> open one level
    vim.cmd("normal! zo")
  else
    local foldlevel = vim.fn.foldlevel(line)
    if foldlevel > 0 then
      -- Currently open -> check if children are visible
      local next_line = line + 1
      local next_foldlevel = vim.fn.foldlevel(next_line)

      if next_foldlevel > foldlevel then
        -- Children visible -> fold everything
        vim.cmd("normal! zc")
      else
        -- At expanded state -> fold
        vim.cmd("normal! zc")
      end
    end
  end
end

-- Delete entire subtree when dd is pressed on headline
function M.delete_subtree()
  if not M.is_on_headline() then
    -- Not on headline, use default dd behavior
    vim.cmd("normal! dd")
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local headline = ts.get_headline_at_cursor(bufnr)

  if not headline then
    vim.cmd("normal! dd")
    return
  end

  local start_row, end_row = ts.get_subtree_range(headline, bufnr)
  if start_row and end_row then
    -- Delete the entire subtree
    vim.api.nvim_buf_set_lines(bufnr, start_row, end_row + 1, false, {})
  end
end

-- Move subtree up
function M.move_subtree_up()
  local bufnr = vim.api.nvim_get_current_buf()
  local headline = ts.get_headline_at_cursor(bufnr)

  if not headline then
    return
  end

  local start_row, end_row = ts.get_subtree_range(headline, bufnr)
  if not start_row or not end_row then
    return
  end

  -- Check if there's a previous sibling at the same level
  if start_row == 0 then
    vim.notify("Already at top", vim.log.levels.WARN)
    return
  end

  -- Get the subtree lines
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, false)

  -- Find previous headline at same or higher level
  local level = ts.get_headline_level(headline, bufnr)
  local target_row = start_row - 1

  while target_row >= 0 do
    local line = vim.api.nvim_buf_get_lines(bufnr, target_row, target_row + 1, false)[1]
    local stars = line:match("^(%*+)%s")
    if stars and #stars <= level then
      -- Found a headline at same or higher level
      -- Move our subtree above this headline
      vim.api.nvim_buf_set_lines(bufnr, start_row, end_row + 1, false, {})
      vim.api.nvim_buf_set_lines(bufnr, target_row, target_row, false, lines)

      -- Move cursor to new position
      vim.api.nvim_win_set_cursor(0, { target_row + 1, 0 })
      return
    end
    target_row = target_row - 1
  end

  vim.notify("Cannot move up", vim.log.levels.WARN)
end

-- Move subtree down
function M.move_subtree_down()
  local bufnr = vim.api.nvim_get_current_buf()
  local headline = ts.get_headline_at_cursor(bufnr)

  if not headline then
    return
  end

  local start_row, end_row = ts.get_subtree_range(headline, bufnr)
  if not start_row or not end_row then
    return
  end

  local line_count = vim.api.nvim_buf_line_count(bufnr)
  if end_row >= line_count - 1 then
    vim.notify("Already at bottom", vim.log.levels.WARN)
    return
  end

  -- Get the subtree lines
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, false)

  -- Find next headline at same or higher level
  local level = ts.get_headline_level(headline, bufnr)
  local target_row = end_row + 1

  while target_row < line_count do
    local line = vim.api.nvim_buf_get_lines(bufnr, target_row, target_row + 1, false)[1]
    local stars = line:match("^(%*+)%s")
    if stars and #stars <= level then
      -- Found next headline at same or higher level
      -- Find the end of that subtree
      local next_headline_end = target_row
      for i = target_row + 1, line_count - 1 do
        local next_line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]
        local next_stars = next_line:match("^(%*+)%s")
        if next_stars and #next_stars <= level then
          next_headline_end = i - 1
          break
        end
        if i == line_count - 1 then
          next_headline_end = i
        end
      end

      -- Move our subtree after the next headline's subtree
      vim.api.nvim_buf_set_lines(bufnr, start_row, end_row + 1, false, {})
      vim.api.nvim_buf_set_lines(bufnr, next_headline_end + 1, next_headline_end + 1, false, lines)

      -- Move cursor to new position
      local new_pos = next_headline_end + 1 - (end_row - start_row)
      vim.api.nvim_win_set_cursor(0, { new_pos + 1, 0 })
      return
    end
    target_row = target_row + 1
  end

  vim.notify("Cannot move down", vim.log.levels.WARN)
end

-- Promote headline (decrease level)
function M.promote_headline()
  if not M.is_on_headline() then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local line_num = vim.fn.line(".")
  local line = vim.api.nvim_get_current_line()

  local stars = line:match("^(%*+)")
  if not stars or #stars == 1 then
    vim.notify("Cannot promote further", vim.log.levels.WARN)
    return
  end

  -- Remove one star
  local new_line = line:sub(2)
  vim.api.nvim_buf_set_lines(bufnr, line_num - 1, line_num, false, { new_line })
end

-- Demote headline (increase level)
function M.demote_headline()
  if not M.is_on_headline() then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local line_num = vim.fn.line(".")
  local line = vim.api.nvim_get_current_line()

  -- Add one star
  local new_line = "*" .. line
  vim.api.nvim_buf_set_lines(bufnr, line_num - 1, line_num, false, { new_line })
end

-- Cycle global fold visibility (Shift-TAB)
-- States: all folded → show level 1 → show all headlines → show all content
function M.cycle_global_visibility()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Cycle through states
  global_fold_state = (global_fold_state + 1) % 4

  if global_fold_state == 0 then
    -- All folded (foldlevel 0)
    vim.opt_local.foldlevel = 0
    vim.notify("All folded", vim.log.levels.INFO)
  elseif global_fold_state == 1 then
    -- Show only level 1 headlines (foldlevel 1)
    vim.opt_local.foldlevel = 1
    vim.notify("Level 1 headlines", vim.log.levels.INFO)
  elseif global_fold_state == 2 then
    -- Show all headlines but content folded (foldlevel 99 approximates this)
    vim.opt_local.foldlevel = 99
    vim.notify("All headlines", vim.log.levels.INFO)
  else
    -- Show everything (no folding)
    vim.opt_local.foldlevel = 99
    -- Open all folds
    vim.cmd("normal! zR")
    vim.notify("Show all", vim.log.levels.INFO)
  end
end

return M
