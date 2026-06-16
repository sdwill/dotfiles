# Neovim Config Cheat Sheet

## Plugin Management (lazy.nvim)

| Command | Action |
|---------|--------|
| `:Lazy` | Open plugin manager UI |
| `:Lazy install` | Install missing plugins |
| `:Lazy update` | Update all plugins |
| `:Lazy clean` | Remove unused plugins |
| `:Lazy sync` | Install + update + clean |
| `:Lazy profile` | Show startup time profile |

## LSP Keybindings

| Key | Action |
|-----|--------|
| `gD` | Go to declaration |
| `gd` | Go to definition |
| `K` | Show hover documentation |
| `gi` | Go to implementation |
| `<C-k>` | Show signature help |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `gr` | Find references |
| `<leader>f` | Format buffer |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>e` | Show diagnostic float |
| `<leader>q` | Add diagnostics to location list |

## Telescope (Find/Search)

| Key | Action |
|-----|--------|
| `<leader><Space>` | Telescope main menu |
| `<C-p>` | Find files (git-aware) |
| `<C-f>` | Live grep (search in files) |
| `<leader>fb` | Browse buffers |
| `<leader>fc` | Browse commands |
| `<leader>ff` | File browser |

### Inside Telescope

| Key | Action |
|-----|--------|
| `<C-n>` / `<C-p>` | Next/previous result |
| `<C-j>` / `<C-k>` | Next/previous result (alt) |
| `<CR>` | Select |
| `<C-x>` | Open in horizontal split |
| `<C-v>` | Open in vertical split |
| `<C-t>` | Open in new tab |
| `<C-u>` | Scroll preview up |
| `<C-d>` | Scroll preview down |

## Completion (nvim-cmp)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm selection |
| `<Tab>` | Next item / jump to next snippet field |
| `<S-Tab>` | Previous item / jump to previous snippet field |
| `<C-e>` | Abort completion |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |

## Treesitter

| Command | Action |
|---------|--------|
| `:TSUpdate` | Update all parsers |
| `:TSInstall <lang>` | Install parser for language |
| `:TSModuleInfo` | Show loaded modules |
| `:TSPlaygroundToggle` | Toggle syntax tree view (if installed) |

### Incremental Selection

| Key | Action |
|-----|--------|
| `<C-space>` | Init selection / expand |
| `<BS>` | Shrink selection |

## UI Plugins

| Key/Command | Action |
|-------------|--------|
| `<leader>g` | Toggle zen mode |
| `<c-\>` | Toggle terminal |
| `:TabooRename <name>` | Rename current tab |
| `:Startify` | Open start screen |

## General Editing

| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<leader>t` | Insert timestamp |
| `<A-t>` | Insert timestamp (insert mode) |
| `<A-j>` | Move line down |
| `<A-k>` | Move line up |
| `<leader><BS>` | Clear search highlight |
| `:TrimWhitespace` | Remove trailing whitespace |

## Tab Navigation

| Key | Action |
|-----|--------|
| `<leader>1-9` | Jump to tab 1-9 |
| `<leader>0` | Jump to last tab |
| `gt` | Next tab |
| `gT` | Previous tab |

## Config Files

| Key | Action |
|-----|--------|
| `<F3>` | Open init.lua in new tab |
| `<F4>` | Copy current file path to clipboard |

## Surround (vim-surround)

| Key | Action |
|-----|--------|
| `cs"'` | Change surrounding `"` to `'` |
| `cs'<q>` | Change `'` to `<q></q>` |
| `ds"` | Delete surrounding `"` |
| `ysiw]` | Surround word with `[]` |
| `yss)` | Surround entire line with `()` |
| `S"` | Surround selection with `"` (visual mode) |

## Session Management (vim-obsession)

| Command | Action |
|---------|--------|
| `:Obsession` | Start recording session |
| `:Obsession!` | Stop recording |
| `:Obsession <file>` | Save to specific file |
| `vim -S` | Restore session |

## Which-key

| Key | Action |
|-----|--------|
| `<leader>` (wait) | Show all leader keybindings |
| `[` (wait) | Show all `[` mappings |
| `]` (wait) | Show all `]` mappings |

## Health Checks

| Command | Action |
|---------|--------|
| `:checkhealth` | Check Neovim installation |
| `:checkhealth lazy` | Check lazy.nvim |
| `:checkhealth nvim-treesitter` | Check Treesitter |
| `:LspInfo` | Show LSP client info |

## Useful Vim Commands

| Command | Action |
|---------|--------|
| `:lua vim.print(...)` | Print Lua value |
| `:messages` | Show message history |
| `:verbose map <key>` | Show where key is mapped |
| `:set <option>?` | Show option value |
| `:e!` | Reload file from disk |
| `:source %` | Reload current file |
