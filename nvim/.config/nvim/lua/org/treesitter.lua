-- Tree-sitter utilities for org-mode
-- Provides functions to query and manipulate org structure

local M = {}

-- Get the tree-sitter parser for the current buffer
function M.get_parser(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "org")
  if not ok then
    vim.notify("Tree-sitter org parser not available", vim.log.levels.ERROR)
    return nil
  end
  return parser
end

-- Get the syntax tree for the current buffer
function M.get_tree(bufnr)
  local parser = M.get_parser(bufnr)
  if not parser then
    return nil
  end
  return parser:parse()[1]
end

-- Get the root node of the syntax tree
function M.get_root(bufnr)
  local tree = M.get_tree(bufnr)
  if not tree then
    return nil
  end
  return tree:root()
end

-- Get node at cursor position
function M.get_node_at_cursor(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]

  local root = M.get_root(bufnr)
  if not root then
    return nil
  end

  return root:descendant_for_range(row, col, row, col)
end

-- Check if a node is a headline
function M.is_headline(node)
  if not node then
    return false
  end
  return node:type() == "headline" or node:type() == "section"
end

-- Get the headline node at cursor (or nil if not on headline)
function M.get_headline_at_cursor(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local node = M.get_node_at_cursor(bufnr)

  -- Walk up the tree to find a headline
  while node do
    if M.is_headline(node) then
      return node
    end
    node = node:parent()
  end

  return nil
end

-- Get headline level (number of stars)
function M.get_headline_level(node, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not node or not M.is_headline(node) then
    return 0
  end

  -- Get the stars child
  for child in node:iter_children() do
    if child:type() == "stars" then
      local start_row, start_col, end_row, end_col = child:range()
      local text = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})[1]
      return #text
    end
  end

  return 1
end

-- Get headline text (title)
function M.get_headline_text(node, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not node or not M.is_headline(node) then
    return ""
  end

  local start_row, start_col, end_row, end_col = node:range()
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, start_row + 1, false)
  if #lines == 0 then
    return ""
  end

  return lines[1]
end

-- Get the range of a subtree (headline + all its content and children)
function M.get_subtree_range(node, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not node or not M.is_headline(node) then
    return nil
  end

  local start_row, start_col, end_row, end_col = node:range()

  -- Find the next sibling headline at the same or higher level
  local level = M.get_headline_level(node, bufnr)
  local next_sibling = node:next_sibling()

  while next_sibling do
    if M.is_headline(next_sibling) then
      local next_level = M.get_headline_level(next_sibling, bufnr)
      if next_level <= level then
        -- Found the next headline at same or higher level
        local next_start_row, _, _, _ = next_sibling:range()
        return start_row, next_start_row - 1
      end
    end
    next_sibling = next_sibling:next_sibling()
  end

  -- No next sibling, subtree extends to end of parent or file
  local parent = node:parent()
  if parent then
    local _, _, parent_end_row, _ = parent:range()
    return start_row, parent_end_row
  end

  -- Top-level headline, extends to end of buffer
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  return start_row, line_count - 1
end

-- Get all headlines in buffer
function M.get_all_headlines(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local root = M.get_root(bufnr)
  if not root then
    return {}
  end

  local headlines = {}

  local function visit(node)
    if M.is_headline(node) then
      table.insert(headlines, {
        node = node,
        level = M.get_headline_level(node, bufnr),
        text = M.get_headline_text(node, bufnr),
        start_row = node:range(),
      })
    end

    for child in node:iter_children() do
      visit(child)
    end
  end

  visit(root)
  return headlines
end

-- Get TODO keyword from headline
function M.get_todo_keyword(node, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not node or not M.is_headline(node) then
    return nil
  end

  -- Look for item child with todo_keyword
  for child in node:iter_children() do
    if child:type() == "item" then
      for item_child in child:iter_children() do
        if item_child:type() == "todo_keyword" then
          local start_row, start_col, end_row, end_col = item_child:range()
          local text = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})[1]
          return text
        end
      end
    end
  end

  return nil
end

return M
