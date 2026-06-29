# Phase 1 Updates - User Feedback Implemented

## ✅ All Feedback Addressed

### 1. Date-Only Timestamps
- **`<leader>mdt`** - Insert active timestamp (date only): `<2026-06-29 Sun>`
- **`<leader>mdT`** - Insert inactive timestamp (date only): `[2026-06-29 Sun]`
- **`<leader>mdi`** - Insert inactive timestamp with time: `[2026-06-29 Sun 14:45]`

### 2. Tree-sitter Parser
- Added `nvim-orgmode/tree-sitter-org` to bootstrap.lua
- Will be installed automatically on next nvim restart
- Or run `:PackUpdate` to install immediately

### 3. Checkbox Toggle
- **`<CR>` (Enter)** on checkbox line: Cycles through `[ ]` → `[-]` → `[x]` → `[ ]`
- Works on headlines with checkboxes like: `** [ ] Task name`

### 4. TODO Keyword Syntax Highlighting
Created `syntax/org.vim` with individual colors for each keyword:
- **TODO** - Orange/red (pending)
- **NEXT** - Yellow (up next)
- **WIP** - Green (in progress)
- **AWAIT** - Purple (waiting)
- **BLOCKED** - Red (blocked)
- **IDEA** - Light blue (ideas)
- **MAYBE** - Blue (maybe)
- **DONE** - Green (completed)
- **NOTDOING** - Gray (not doing)
- **MEETING** - Blue (meetings)
- **ENDED/CANCELED/SKIPPED** - Various grays

### 5. MacBook Alt/Option Key Fix
Added support for MacOS Option key sequences:
- **Option-j** (∆) - Move headline down
- **Option-k** (˚) - Move headline up
- Also kept `<A-j>` and `<A-k>` for compatibility

### 6. Which-Key TODO Menu
- **`<leader>mt`** now shows which-key popup with all TODO states
- Each keyword gets a unique letter key
- Press `x` to remove TODO keyword
- Much more user-friendly than cycling!

### 7. Search Keybinding Fix
- Removed `<leader>/` mapping that was conflicting with normal search
- Only `<leader>m/` is mapped (search headlines in current file)
- Regular `/` search works normally

## Updated Keybindings

| Action | Key | Description |
|--------|-----|-------------|
| Cycle fold | `<Tab>` | On headline |
| Delete subtree | `dd` | On headline |
| Move up | `Option-k` or `<A-k>` | On headline |
| Move down | `Option-j` or `<A-j>` | On headline |
| Promote | `<<` | On headline |
| Demote | `>>` | On headline |
| **TODO menu** | `<leader>mt` | **Shows which-key popup** |
| Toggle checkbox | `<CR>` | On checkbox line |
| Insert timestamp (time) | `<leader>mdi` | Inactive with time |
| **Insert timestamp (date)** | `<leader>mdt` | **Active, date only** |
| **Insert timestamp (date)** | `<leader>mdT` | **Inactive, date only** |
| Search headlines | `<leader>m/` | Current file |

## Installation

1. **Restart neovim** to load all changes:
   ```bash
   # Close and reopen nvim
   ```

2. **Install tree-sitter parser**:
   ```vim
   :PackUpdate
   ```

3. **Test the features**:
   ```bash
   nvim ~/.config/nvim/test.org
   ```

## Testing Checklist

- [ ] Open test.org and verify TODO keywords are colorized
- [ ] Press `<leader>mt` on a TODO line → see which-key menu
- [ ] Press `<CR>` on a checkbox line → see it cycle
- [ ] Press `Option-j` on headline → see it move down
- [ ] Press `<leader>mdt` → see active date-only timestamp inserted
- [ ] Press `<leader>mdT` → see inactive date-only timestamp inserted
- [ ] Press `/` → verify normal search still works
- [ ] Press `<Tab>` on headline → verify folding still works

## Files Modified

```
nvim/.config/nvim/
├── lua/
│   ├── config/bootstrap.lua       # Added tree-sitter-org package
│   ├── org/
│   │   ├── init.lua               # Updated keybindings
│   │   ├── todo.lua               # Added which-key menu + checkbox toggle
│   │   └── timestamp.lua          # Added date-only timestamp functions
│   └── plugins/org-mode.lua       # Added error handling
└── syntax/org.vim                 # NEW: Syntax highlighting
```

## Next Steps

Phase 1 is now feature-complete with all your feedback addressed!

Ready to start **Phase 2**:
- Clock in/out system
- Logbook drawers  
- Clock tables (critical for you)
- Refile with Telescope
- Modeline clock display

Let me know when you're ready to proceed!
