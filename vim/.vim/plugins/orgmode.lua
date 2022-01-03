-- init.lua

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}


require('orgmode').setup({
  org_agenda_files = {'~/Box/notes/**/*'},
  org_default_notes_file = '~/Box/notes/inbox.org',
  org_todo_keywords =  {'TODO(t)', 'WIP(w)', 'AWAIT(a)', 'BLOCKED(b)', 'PROJ(p)', '|', 'DONE(d)', 'CANCELED(c)'},
  org_todo_keyword_faces = {
      -- BLOCKED = ':background red :foreground white :weight bold'
    -- WAITING = ':foreground blue :weight bold',
    -- DELEGATED = ':background #FFFFFF :slant italic :underline on',
    -- TODO = ':background #000000 :foreground red', -- overrides builtin color for `TODO` keyword
  },
  org_hide_emphasis_markers = true,
  org_indent_mode = 'noindent',
})
