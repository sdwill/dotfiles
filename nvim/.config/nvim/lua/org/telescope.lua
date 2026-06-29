-- Telescope integration for org-mode

local M = {}

-- Search headlines in current buffer
function M.search_headlines()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Extract headlines
  local headlines = {}
  for line_num, line in ipairs(lines) do
    local stars, title = line:match("^(%*+)%s+(.+)")
    if stars then
      local indent = string.rep("  ", #stars - 1)
      table.insert(headlines, {
        line_num = line_num,
        display = indent .. title,
        text = line,
        level = #stars,
      })
    end
  end

  if #headlines == 0 then
    vim.notify("No headlines found", vim.log.levels.INFO)
    return
  end

  pickers
    .new({}, {
      prompt_title = "Org Headlines",
      finder = finders.new_table({
        results = headlines,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.display,
            ordinal = entry.text,
            lnum = entry.line_num,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      -- Disable default sorting to maintain file order
      default_selection_index = 1,
      sorting_strategy = "ascending",
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
            vim.cmd("normal! zv") -- Unfold if folded
          end
        end)
        return true
      end,
    })
    :find()
end

-- Search headlines across all agenda files (Phase 4)
function M.search_all_headlines()
  vim.notify("Search all headlines - Phase 4 feature", vim.log.levels.INFO)
end

return M
