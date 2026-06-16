-- General Neovim options
local opt = vim.opt

-- Tabs and indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.smarttab = true
opt.breakindent = true
opt.breakindentopt = "list:-1"

-- Line wrapping
opt.linebreak = true  -- Don't split words when wrapping
opt.wrap = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split"  -- Live preview of substitutions

-- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 10
opt.cursorline = false
opt.showmode = false
opt.showcmd = true
opt.showmatch = true
opt.wildmenu = true
opt.mouse = "a"

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Files
opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Misc
opt.encoding = "utf-8"
opt.backspace = "indent,eol,start"
opt.wildignore:append({".git", ".hg", ".svn", ".idea", ".pytest_cache", "__pycache__", ".DS_Store", "tags"})

-- Format list patterns for checkboxes and bullets
-- Better soft-wrapping for lists
opt.formatlistpat = [[^\s*[[\[({]\?\\([0-9\ xX]\+\\\|[a-zA-Z]\+\\)[\]:.)}]\s\+]]

-- Enable strikethrough and undercurl in kitty, xterm, alacritty, and tmux
if vim.env.TERM and vim.env.TERM:match("xterm") or vim.env.TERM:match("kitty") or vim.env.TERM:match("alacritty") or vim.env.TERM:match("tmux") then
  vim.cmd([[
    let &t_Ts = "\e[9m"
    let &t_Te = "\e[29m"
    let &t_Cs = "\e[4:3m"
    let &t_Ce = "\e[4:0m"
  ]])
end

-- Disable compatibility
opt.compatible = false

-- Syntax and filetype
vim.cmd("syntax on")
vim.cmd("filetype plugin on")
