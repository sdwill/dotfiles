-- Timestamp utilities for org-mode

local M = {}

-- Insert inactive timestamp at cursor
-- Format: [2026-06-29 Sun 14:30]
function M.insert_inactive_timestamp()
  local timestamp = os.date("[%Y-%m-%d %a %H:%M]")
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()

  -- Insert timestamp at cursor position
  local new_line = line:sub(1, pos[2]) .. timestamp .. line:sub(pos[2] + 1)
  vim.api.nvim_set_current_line(new_line)

  -- Move cursor after timestamp
  vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] + #timestamp })
end

-- Insert active timestamp at cursor (date only)
-- Format: <2026-06-29 Sun>
function M.insert_active_timestamp()
  local timestamp = os.date("<%Y-%m-%d %a>")
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()

  local new_line = line:sub(1, pos[2]) .. timestamp .. line:sub(pos[2] + 1)
  vim.api.nvim_set_current_line(new_line)

  vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] + #timestamp })
end

-- Insert inactive timestamp at cursor (date only)
-- Format: [2026-06-29 Sun]
function M.insert_inactive_timestamp_date_only()
  local timestamp = os.date("[%Y-%m-%d %a]")
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()

  local new_line = line:sub(1, pos[2]) .. timestamp .. line:sub(pos[2] + 1)
  vim.api.nvim_set_current_line(new_line)

  vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] + #timestamp })
end

-- Parse org timestamp
-- Returns: { year, month, day, hour, min, active, warning_days }
function M.parse_timestamp(ts_string)
  -- Active: <2026-06-29 Sun> or <2026-06-29 Sun 14:30>
  -- Inactive: [2026-06-29 Sun] or [2026-06-29 Sun 14:30]
  -- With warning: <2026-06-29 Sun -14d>

  local active = ts_string:sub(1, 1) == "<"

  local year, month, day, hour, min, warning =
    ts_string:match("(%d%d%d%d)%-(%d%d)%-(%d%d)%s+%a+%s*(%d*):?(%d*)%s*(%-?%d*d?)")

  return {
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = hour ~= "" and tonumber(hour) or nil,
    min = min ~= "" and tonumber(min) or nil,
    active = active,
    warning_days = warning and warning ~= "" and tonumber(warning:match("%-(%d+)")) or nil,
  }
end

-- Format timestamp from components
function M.format_timestamp(components)
  local bracket = components.active and "<" or "["
  local close_bracket = components.active and ">" or "]"

  local date_str = string.format(
    "%s%04d-%02d-%02d %s",
    bracket,
    components.year,
    components.month,
    components.day,
    os.date("%a", os.time({ year = components.year, month = components.month, day = components.day }))
  )

  if components.hour and components.min then
    date_str = date_str .. string.format(" %02d:%02d", components.hour, components.min)
  end

  if components.warning_days then
    date_str = date_str .. string.format(" -%dd", components.warning_days)
  end

  date_str = date_str .. close_bracket

  return date_str
end

return M
