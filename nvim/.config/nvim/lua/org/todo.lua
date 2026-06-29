-- TODO state cycling implementation

local M = {}

-- Get TODO keywords from config
local function get_todo_keywords()
  local org = require("org")
  local all_keywords = {}

  -- Flatten all TODO keyword sequences
  for _, sequence in ipairs(org.config.todo_keywords) do
    for _, kw in ipairs(sequence) do
      table.insert(all_keywords, kw)
    end
  end

  return all_keywords
end

-- Get current TODO keyword from line
local function get_current_todo(line)
  -- Match headline with optional TODO keyword
  -- Pattern: ^(\*+)\s+(TODO|NEXT|etc)?\s*(.*)
  local stars, todo, rest = line:match("^(%*+)%s+([A-Z%[%]%-?]+)%s+(.*)")
  if not todo then
    -- No TODO keyword, just headline
    stars, rest = line:match("^(%*+)%s+(.*)")
    return stars, nil, rest
  end

  return stars, todo, rest
end

-- Cycle TODO state
function M.cycle_todo_state()
  local bufnr = vim.api.nvim_get_current_buf()
  local line_num = vim.fn.line(".")
  local line = vim.api.nvim_get_current_line()

  -- Check if on headline
  if not line:match("^%*+%s") then
    vim.notify("Not on a headline", vim.log.levels.WARN)
    return
  end

  local stars, current_todo, rest = get_current_todo(line)
  if not stars then
    return
  end

  local org = require("org")
  local keywords = org.config.todo_keywords

  -- Find current keyword and determine next state
  local next_todo = nil
  local found = false

  -- Search through all sequences
  for seq_idx, sequence in ipairs(keywords) do
    for kw_idx, kw in ipairs(sequence) do
      if current_todo == kw then
        -- Found current keyword, get next
        found = true
        if kw_idx < #sequence then
          next_todo = sequence[kw_idx + 1]
        else
          -- At end of sequence, wrap to first keyword or remove
          next_todo = nil -- Remove TODO keyword
        end
        break
      end
    end
    if found then
      break
    end
  end

  -- If current TODO not found, start with first keyword
  if not found and current_todo then
    -- Unknown keyword, start fresh
    next_todo = keywords[1][1]
  elseif not current_todo then
    -- No TODO keyword, add first one
    next_todo = keywords[1][1]
  end

  -- Construct new line
  local new_line
  if next_todo then
    new_line = stars .. " " .. next_todo .. " " .. rest
  else
    new_line = stars .. " " .. rest
  end

  vim.api.nvim_buf_set_lines(bufnr, line_num - 1, line_num, false, { new_line })

  -- If transitioning to DONE, log timestamp (Phase 2 feature)
  if next_todo == "DONE" then
    local org_config = require("org")
    if org_config.config.log_done then
      -- Will implement logbook entry in Phase 2
      vim.notify("TODO: Add logbook entry for DONE state", vim.log.levels.DEBUG)
    end
  end
end

-- Cycle TODO state with which-key menu
function M.cycle_todo_state_menu()
  local org = require("org")
  local keywords = org.config.todo_keywords

  local bufnr = vim.api.nvim_get_current_buf()
  local line_num = vim.fn.line(".")
  local line = vim.api.nvim_get_current_line()

  -- Check if on headline
  if not line:match("^%*+%s") then
    vim.notify("Not on a headline", vim.log.levels.WARN)
    return
  end

  -- Build which-key menu using new API
  local wk = require("which-key")
  local mappings = {}

  -- Flatten all keywords and create mappings
  local all_keywords = {}
  for _, sequence in ipairs(keywords) do
    for _, kw in ipairs(sequence) do
      table.insert(all_keywords, kw)
    end
  end

  -- Create unique key bindings using new which-key format
  local used_keys = {}
  for idx, kw in ipairs(all_keywords) do
    local key = kw:sub(1, 1):lower()
    -- If key already used, try second letter, then third, etc.
    local key_idx = 1
    while used_keys[key] and key_idx < #kw do
      key_idx = key_idx + 1
      key = kw:sub(key_idx, key_idx):lower()
    end
    used_keys[key] = true

    table.insert(mappings, {
      "<leader>mt" .. key,
      function()
        M.set_todo_state(kw)
      end,
      desc = kw,
      buffer = bufnr,
    })
  end

  -- Add option to remove TODO keyword
  table.insert(mappings, {
    "<leader>mtx",
    function()
      M.set_todo_state(nil)
    end,
    desc = "Remove TODO",
    buffer = bufnr,
  })

  -- Register mappings
  wk.add(mappings)

  -- Trigger which-key display
  vim.defer_fn(function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<leader>mt", true, false, true), "m", false)
  end, 10)
end

-- Set specific TODO state
function M.set_todo_state(new_state)
  local bufnr = vim.api.nvim_get_current_buf()
  local line_num = vim.fn.line(".")
  local line = vim.api.nvim_get_current_line()

  local stars, current_todo, rest = get_current_todo(line)
  if not stars then
    return
  end

  -- Construct new line
  local new_line
  if new_state then
    new_line = stars .. " " .. new_state .. " " .. rest
  else
    new_line = stars .. " " .. rest
  end

  vim.api.nvim_buf_set_lines(bufnr, line_num - 1, line_num, false, { new_line })
end

-- Toggle checkbox state
function M.toggle_checkbox()
  local line = vim.api.nvim_get_current_line()

  -- Check if line has a checkbox
  local stars, checkbox, rest = line:match("^(%**)%s*(%[.%])%s*(.*)")

  if not checkbox then
    -- Not a checkbox, use default Enter behavior
    vim.cmd("normal! j")
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local line_num = vim.fn.line(".")

  -- Cycle checkbox states: [ ] -> [-] -> [x] -> [ ]
  local new_checkbox
  if checkbox == "[ ]" then
    new_checkbox = "[-]"
  elseif checkbox == "[-]" then
    new_checkbox = "[x]"
  else
    new_checkbox = "[ ]"
  end

  local new_line = stars .. " " .. new_checkbox .. " " .. rest
  vim.api.nvim_buf_set_lines(bufnr, line_num - 1, line_num, false, { new_line })
end

return M
