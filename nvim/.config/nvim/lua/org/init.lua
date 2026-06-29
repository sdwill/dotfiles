-- Org-mode implementation for Neovim
-- Main initialization module

local M = {}

-- Default configuration
M.config = {
  -- Agenda files (will be set by user)
  agenda_files = {},

  -- TODO keywords
  todo_keywords = {
    { "TODO", "NEXT", "WIP", "AWAIT", "BLOCKED", "IDEA", "MAYBE" },
    { "DONE", "NOTDOING" },
  },

  todo_keywords_meetings = {
    { "MEETING" },
    { "ENDED", "CANCELED", "SKIPPED" },
  },

  todo_keywords_checkboxes = {
    { "[ ]", "[-]", "[?]" },
    { "[x]" },
  },

  -- Capture templates
  capture_templates = {
    {
      key = "t",
      description = "Todo",
      template = "* TODO %?\n%U",
      target = "~/Documents/notes/inbox.org",
      clock_in = false,
    },
    {
      key = "W",
      description = "Work (interrupt)",
      template = "* %<%m%d> %?\n%U",
      target = "~/Documents/notes/inbox.org",
      clock_in = true,
      jump_to_captured = true,
    },
  },

  -- Clock settings
  clock_persist = true,
  clock_persist_file = vim.fn.stdpath("state") .. "/org-clock-save.json",

  -- Fold settings
  fold_on_startup = true,

  -- Duration format (always HH:MM)
  duration_format = "h:mm",

  -- Log settings
  log_into_drawer = true,
  log_done = true,
}

-- Module references (lazy loaded)
M.fold = nil
M.todo = nil
M.timestamp = nil
M.clock = nil
M.capture = nil
M.schedule = nil
M.agenda = nil
M.refile = nil
M.telescope = nil
M.treesitter = nil

-- Setup function
function M.setup(opts)
  -- Merge user config with defaults
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  -- Set up autocommands for org files
  local augroup = vim.api.nvim_create_augroup("OrgMode", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "org",
    callback = function()
      M.on_org_file_open()
    end,
  })

  -- Load clock persistence
  if M.config.clock_persist then
    M.load_clock = require("org.clock").load_clock_state
    vim.schedule(M.load_clock)
  end
end

-- Called when an org file is opened
function M.on_org_file_open()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Set up folding
  require("org.fold").setup_buffer(bufnr)

  -- Set up keybindings
  M.setup_keybindings(bufnr)

  -- Set fold level if configured
  if M.config.fold_on_startup then
    vim.opt_local.foldlevel = 0
  end
end

-- Set up keybindings for org files
function M.setup_keybindings(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Folding: TAB cycles folds on current headline
  vim.keymap.set("n", "<Tab>", function()
    require("org.fold").cycle_fold()
  end, vim.tbl_extend("force", opts, { desc = "Cycle fold" }))

  -- Shift-TAB cycles global visibility
  vim.keymap.set("n", "<S-Tab>", function()
    require("org.fold").cycle_global_visibility()
  end, vim.tbl_extend("force", opts, { desc = "Cycle global visibility" }))

  -- Structural editing
  -- dd on headline deletes entire subtree
  vim.keymap.set("n", "dd", function()
    require("org.fold").delete_subtree()
  end, vim.tbl_extend("force", opts, { desc = "Delete headline/subtree" }))

  -- Alt-j/k moves headline up/down (MacOS uses Option key, sent as special chars)
  -- Try both <A-j> and the MacOS option-j sequence
  local move_down_fn = function()
    local org_fold = require("org.fold")
    if org_fold.is_on_headline() then
      org_fold.move_subtree_down()
    else
      -- Fall back to default behavior (move line)
      vim.cmd("normal! :m .+1<CR>==")
    end
  end

  local move_up_fn = function()
    local org_fold = require("org.fold")
    if org_fold.is_on_headline() then
      org_fold.move_subtree_up()
    else
      -- Fall back to default behavior (move line)
      vim.cmd("normal! :m .-2<CR>==")
    end
  end

  -- Standard Alt bindings
  vim.keymap.set("n", "<A-j>", move_down_fn, vim.tbl_extend("force", opts, { desc = "Move headline down or line" }))
  vim.keymap.set("n", "<A-k>", move_up_fn, vim.tbl_extend("force", opts, { desc = "Move headline up or line" }))

  -- MacOS Option key sends these sequences
  vim.keymap.set("n", "∆", move_down_fn, vim.tbl_extend("force", opts, { desc = "Move headline down or line" }))
  vim.keymap.set("n", "˚", move_up_fn, vim.tbl_extend("force", opts, { desc = "Move headline up or line" }))

  -- Promote/demote
  vim.keymap.set("n", ">>", function()
    require("org.fold").demote_headline()
  end, vim.tbl_extend("force", opts, { desc = "Demote headline" }))

  vim.keymap.set("n", "<<", function()
    require("org.fold").promote_headline()
  end, vim.tbl_extend("force", opts, { desc = "Promote headline" }))

  -- TODO state cycling with which-key menu
  vim.keymap.set("n", "<leader>mt", function()
    require("org.todo").cycle_todo_state_menu()
  end, vim.tbl_extend("force", opts, { desc = "Cycle TODO state" }))

  -- Timestamps
  vim.keymap.set("n", "<leader>mdi", function()
    require("org.timestamp").insert_inactive_timestamp()
  end, vim.tbl_extend("force", opts, { desc = "Insert inactive timestamp (with time)" }))

  vim.keymap.set("i", "<M-leader>mdi", function()
    require("org.timestamp").insert_inactive_timestamp()
  end, vim.tbl_extend("force", opts, { desc = "Insert inactive timestamp (with time)" }))

  -- Date-only timestamps
  vim.keymap.set("n", "<leader>mdt", function()
    require("org.timestamp").insert_active_timestamp()
  end, vim.tbl_extend("force", opts, { desc = "Insert active timestamp (date only)" }))

  vim.keymap.set("n", "<leader>mdT", function()
    require("org.timestamp").insert_inactive_timestamp_date_only()
  end, vim.tbl_extend("force", opts, { desc = "Insert inactive timestamp (date only)" }))

  -- Search headlines (removed <leader>/ to avoid conflict)
  vim.keymap.set("n", "<leader>m/", function()
    require("org.telescope").search_headlines()
  end, vim.tbl_extend("force", opts, { desc = "Search headlines" }))

  -- Checkbox toggle
  vim.keymap.set("n", "<CR>", function()
    require("org.todo").toggle_checkbox()
  end, vim.tbl_extend("force", opts, { desc = "Toggle checkbox" }))

  -- Clock commands (will implement in Phase 2)
  vim.keymap.set("n", "<leader>mci", function()
    require("org.clock").clock_in()
  end, vim.tbl_extend("force", opts, { desc = "Clock in" }))

  vim.keymap.set("n", "<leader>mco", function()
    require("org.clock").clock_out()
  end, vim.tbl_extend("force", opts, { desc = "Clock out" }))

  vim.keymap.set("n", "<leader>mcg", function()
    require("org.clock").goto_clock()
  end, vim.tbl_extend("force", opts, { desc = "Go to current clock" }))

  -- Schedule/Deadline (will implement in Phase 3)
  vim.keymap.set("n", "<leader>mds", function()
    require("org.schedule").schedule()
  end, vim.tbl_extend("force", opts, { desc = "Schedule" }))

  vim.keymap.set("n", "<leader>mdd", function()
    require("org.schedule").deadline()
  end, vim.tbl_extend("force", opts, { desc = "Deadline" }))

  -- Refile (will implement in Phase 2)
  vim.keymap.set("n", "<leader>msr", function()
    require("org.refile").refile()
  end, vim.tbl_extend("force", opts, { desc = "Refile" }))
end

-- Global keybindings (not buffer-specific)
function M.setup_global_keybindings()
  local opts = { noremap = true, silent = true }

  -- Capture
  vim.keymap.set("n", "<leader>X", function()
    require("org.capture").capture()
  end, vim.tbl_extend("force", opts, { desc = "Org Capture" }))

  -- Agenda
  vim.keymap.set("n", "<leader>z", function()
    require("org.agenda").show_agenda()
  end, vim.tbl_extend("force", opts, { desc = "Org Agenda" }))
end

return M
