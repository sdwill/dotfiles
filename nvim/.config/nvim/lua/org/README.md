# Org-Mode for Neovim

A Lua-based implementation of org-mode for Neovim, tailored to Scott Will's workflow.

## Phase 1 Status: ✅ COMPLETE

### Features Implemented

#### ✅ Folding
- **TAB** on headline: Cycles through folded → children visible → fully expanded
- **Fold on startup**: Files open with all headlines folded (`foldlevel=0`)
- Uses Neovim's native folding with custom `foldexpr`

#### ✅ Structural Editing
- **dd** on headline: Deletes entire subtree (headline + all children + content)
- **Alt-j**: Moves headline (and subtree) down
- **Alt-k**: Moves headline (and subtree) up
- Falls back to normal line movement when not on headline

#### ✅ Promote/Demote
- **<<** (shift-left): Promote headline (remove one star)
- **>>** (shift-right): Demote headline (add one star)

#### ✅ TODO State Cycling
- **SPC m t**: Cycles through TODO states
- Supports three keyword sequences:
  - Main: `TODO → NEXT → WIP → AWAIT → BLOCKED → IDEA → MAYBE → DONE → (none)`
  - Meetings: `MEETING → ENDED → CANCELED → SKIPPED`
  - Checkboxes: `[ ] → [-] → [?] → [x]`

#### ✅ Timestamps
- **SPC m d i**: Insert inactive timestamp `[2026-06-29 Sun 14:45]`
- Timestamp parsing and formatting utilities (for Phase 2/3)

#### ✅ Search Headlines
- **SPC m / **: Opens Telescope picker with all headlines in current buffer
- Shows hierarchical structure with indentation
- Jump to headline with Enter
- Unfolds headline automatically

### Keybindings

| Action | Keybinding | Context |
|--------|-----------|---------|
| Cycle fold | `<Tab>` | On headline |
| Delete subtree | `dd` | On headline |
| Move headline up | `<A-k>` | On headline |
| Move headline down | `<A-j>` | On headline |
| Promote | `<<` | On headline |
| Demote | `>>` | On headline |
| Cycle TODO | `<leader>mt` | On headline |
| Insert timestamp | `<leader>mdi` | Normal mode |
| Search headlines | `<leader>m/` | Anywhere in file |
| Capture | `<leader>X` | Global (Phase 3) |
| Agenda | `<leader>z` | Global (Phase 4) |

### Project Structure

```
lua/org/
├── init.lua           # Main module, setup, keybindings
├── config.lua         # User configuration (agenda files, etc.)
├── fold.lua           # Folding + structural editing
├── todo.lua           # TODO state cycling
├── timestamp.lua      # Timestamp utilities
├── telescope.lua      # Telescope integration
├── treesitter.lua     # Tree-sitter queries (fallback)
├── clock.lua          # Clock system (Phase 2)
├── capture.lua        # Capture system (Phase 3)
├── schedule.lua       # Schedule/deadline (Phase 3)
├── refile.lua         # Refile system (Phase 2)
└── agenda.lua         # Agenda views (Phase 4)
```

## Installation

The plugin is already configured in your `lua/plugins/org-mode.lua`:

```lua
return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/org",
    name = "org-mode",
    ft = "org",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "folke/which-key.nvim",
    },
    config = function()
      local org = require("org")
      local config = require("org.config")
      
      org.setup({
        agenda_files = config.agenda_files,
      })
      
      org.setup_global_keybindings()
    end,
  },
}
```

## Testing

Open the test file to try features:
```vim
:e ~/.config/nvim/test.org
```

Try these commands:
1. **TAB** on headlines to test folding
2. **SPC m t** to cycle TODO states
3. **dd** on a headline with children to test subtree deletion
4. **<<** and **>>** to test promote/demote
5. **SPC m /** to test headline search
6. **SPC m d i** to insert a timestamp

## Tree-Sitter Note

The implementation is designed to work with tree-sitter's org parser, but it's not required for Phase 1. We use simple regex patterns as a fallback. When tree-sitter org parser becomes available, the `treesitter.lua` module will provide enhanced parsing.

## Configuration

Edit `lua/org/config.lua` to set your agenda files:

```lua
M.agenda_files = {
  "~/Documents/notes/journal/2026/general.org",
  "~/Documents/notes/journal/2026/leave.org",
  "~/Documents/notes/journal/2026/hwo.org",
  "~/Documents/notes/inbox.org",
}
```

## Next Steps: Phase 2

Phase 2 will implement:
- ⏰ Clock in/out with logbook drawer
- 📊 Clock tables with Ctrl-C update
- 🔄 Refile with Telescope
- 📈 Modeline clock display

Estimated: 30-40 hours

## Known Limitations

1. **No virtual indentation**: Org files are displayed flat (no visual indentation like Emacs)
2. **Basic tree-sitter**: Using fallback regex patterns until org parser is available
3. **No syntax highlighting**: Source blocks don't have embedded syntax highlighting yet
4. **Simple TODO cycling**: No which-key menu yet (just cycles through states)

## File Format Compatibility

All org files remain fully compatible with Emacs. This implementation reads and writes standard org-mode syntax.
