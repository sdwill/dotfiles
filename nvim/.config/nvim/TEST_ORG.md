# Org-Mode Phase 1 - Testing Instructions

## Installation Complete! ✅

Your org-mode plugin has been successfully installed and configured.

## How to Enable

The plugin should load automatically, but if you had neovim open during installation:

```bash
# Option 1: Restart neovim
# Close and reopen nvim

# Option 2: Reload config (from within nvim)
:source ~/.config/nvim/init.lua
```

## Quick Test

1. Open the test file:
   ```bash
   nvim ~/.config/nvim/test.org
   ```

2. Try these commands:
   - Press `<Tab>` on a headline → should cycle fold
   - Press `<Space>mt` on a TODO line → should cycle TODO state  
   - Press `<Space>m/` → should open Telescope headline search
   - Press `<<` or `>>` on a headline → should promote/demote
   - Press `<Space>mdi` → should insert timestamp
   - Press `dd` on a headline → should delete entire subtree

## Keybindings Reference

| Action | Key | Where |
|--------|-----|-------|
| Cycle fold | `<Tab>` | On headline |
| Delete subtree | `dd` | On headline |
| Move up | `<Alt-k>` | On headline |
| Move down | `<Alt-j>` | On headline |
| Promote | `<<` | On headline |
| Demote | `>>` | On headline |
| Cycle TODO | `<Space>mt` | On headline |
| Insert timestamp | `<Space>mdi` | Anywhere |
| Search headlines | `<Space>m/` | Anywhere in org file |

## Verify Installation

Run this in neovim command mode to check if plugin loaded:
```vim
:lua print('Org loaded:', package.loaded['org'] ~= nil)
```

Should print: `Org loaded: true`

## Troubleshooting

If keybindings don't work:

1. **Check filetype** (in org file):
   ```vim
   :set filetype?
   ```
   Should show: `filetype=org`

2. **Check if keymaps exist** (in org file):
   ```vim
   :nmap <Tab>
   ```
   Should show mapping to org fold function

3. **Reload config**:
   ```vim
   :source ~/.config/nvim/init.lua
   ```

## What's Working (Phase 1)

✅ Folding with TAB cycling  
✅ TODO state cycling  
✅ Structural editing (dd, Alt-j/k)  
✅ Promote/demote (<<, >>)  
✅ Timestamp insertion  
✅ Telescope headline search  

## What's Coming Next

Phase 2 (in development):
- Clock in/out
- Clock tables
- Refile with Telescope
- Logbook drawers
- Modeline clock display

## Your org files

The plugin is configured to use your agenda files from:
- `~/Documents/notes/journal/2026/general.org`
- `~/Documents/notes/journal/2026/leave.org`
- `~/Documents/notes/journal/2026/hwo.org`
- `~/Documents/notes/inbox.org`

You can try opening any of these files to test the features!
