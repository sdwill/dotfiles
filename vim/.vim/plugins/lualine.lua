-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

-- vim.cmd[[
--   set guioptions-=e " Use showtabline in gui vim
--   set sessionoptions+=tabpages,globals " store tabpages and globals in session
-- ]]

require('lualine').setup({
    -- theme = bubbles_theme,
    -- theme = 'sonokai',
    -- theme = 'onedark',
    -- theme = 'auto',
  options = {
    theme = 'auto',
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  -- tabline = {
  --   lualine_a = {
  --       {
  --           'tabs',
  --           mode = 2,
  --           max_length = vim.o.columns, -- maximum width of tabs component
  --           tabs_color = {
  --               -- Same values like general color option can be used here.
  --               active = 'lualine_{section}_normal',   -- color for active tab
  --               -- inactive = 'lualine_{section}_inactive', -- color for inactive tab
  --           },
  --       }
  --   },
  --   lualine_b = {'branch'},
  --   lualine_c = {
  --       {
  --         'filename',
  --         file_status = true,  -- displays file status (readonly status, modified status)
  --         path = 0,            -- 0 = just filename, 1 = relative path, 2 = absolute path
  --         -- shorting_target = 40 -- Shortens path to leave 40 space in the window
  --                              -- for other components. Terrible name any suggestions?
  --       }
  --   },
  --   lualine_y = {},
  --   lualine_z = {},
  -- },
  extensions = {},
})

-- require'tabline'.setup {
--   -- Defaults configuration options
--   enable = true,
--   options = {
--   -- If lualine is installed tabline will use separators configured in lualine by default.
--   -- These options can be used to override those settings.
--     max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
--     show_tabs_always = True, -- this shows tabs only when there are more than one tab or if the first tab is named
--     show_devicons = true, -- this shows devicons in buffer section
--     show_bufnr = false, -- this appends [bufnr] to buffer section,
--     show_filename_only = false, -- shows base filename only instead of relative path in filename
--   }
-- }
