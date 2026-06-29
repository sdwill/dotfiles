-- Clock system (Phase 2 - stub for now)

local M = {}

-- Global clock state
_G.org_clock_state = {
  active = false,
  file = nil,
  line = nil,
  headline = nil,
  start_time = nil,
}

function M.clock_in()
  vim.notify("Clock in - Phase 2 feature", vim.log.levels.INFO)
end

function M.clock_out()
  vim.notify("Clock out - Phase 2 feature", vim.log.levels.INFO)
end

function M.goto_clock()
  vim.notify("Go to clock - Phase 2 feature", vim.log.levels.INFO)
end

function M.load_clock_state()
  -- Will implement in Phase 2
end

return M
