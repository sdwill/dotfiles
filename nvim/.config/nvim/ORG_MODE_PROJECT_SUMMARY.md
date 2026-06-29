# Org-Mode for Neovim - Project Summary

## Project Overview

**Goal**: Create a Lua-based implementation of org-mode for Neovim that replicates your Doom Emacs workflow, allowing eventual migration from Emacs to Neovim.

**Approach**: Phased implementation focusing on your actual usage patterns rather than full org-mode feature parity.

**Current Status**: ✅ **Phase 1 Complete and Tested**

---

## Key Decisions Made

### Agenda Scope (Decision Q1)
**Decision**: Simplified agenda view with two main sections:
1. **"Today" view**: All clocked time + scheduled items for today in org-agenda format
2. **TODO list**: Items scheduled for today, overdue, or with approaching deadlines

**Rationale**: User doesn't use complex super-agenda groups. Time-based filtering is sufficient.

**Implementation Notes**:
- Parse `-Nd` warning period from deadline timestamps (e.g., `DEADLINE: <2026-07-03 Fri -14d>`)
- Default warning period: 14 days (configurable)
- Sort: overdue first, then by date

### Capture System (Decision Q2)
**Decision**: which-key style menu (not Telescope)

**Templates Needed**: Only 2 templates:
- `t`: Todo (no clock change)
- `W`: Work (interrupt - with clock-in)

**Rationale**: 99% of capture usage is these two templates. Closer to Doom Emacs behavior.

### Implementation Plan (Decision Q4)
**Decision**: Proceed with full phased implementation:
- Phase 1: Core Editing (2 weeks) ✅ **COMPLETE**
- Phase 2: Time Tracking & Organization (4-6 weeks) - **Next**
- Phase 3: Capture & Schedule (1-2 weeks)
- Phase 4: Agenda (2-3 weeks)

---

## Phase 1 Implementation - COMPLETE ✅

### Features Implemented

#### 1. Folding System
- **TAB** on headline: Cycles through folded → children → expanded
- **Shift-TAB**: Global visibility cycling (all folded → level 1 → all headlines → show all)
- Files start folded (`foldlevel=0`)
- **Fold display**: Empty `foldtext` with `fillchars=fold:\ ` preserves syntax highlighting (Neovim PR #20750)
- **Drawers**: Independently foldable within headlines (`:LOGBOOK:`, `:PROPERTIES:`)

#### 2. Structural Editing
- **dd** on headline: Deletes entire subtree
- **Option-j/Option-k**: Moves headline (and subtree) up/down
  - MacOS sends special characters (∆, ˚) - both mapped
  - Also mapped standard `<A-j>/<A-k>` for compatibility
- Falls back to normal line movement when not on headline

#### 3. Promote/Demote
- **<<**: Promote headline (remove one star)
- **>>**: Demote headline (add one star)

#### 4. TODO State Cycling
- **`<leader>mt`**: Opens which-key menu with all TODO states
- Each keyword gets unique letter key
- Press `x` to remove TODO keyword
- Supports three keyword sequences:
  - Main: `TODO → NEXT → WIP → AWAIT → BLOCKED → IDEA → MAYBE → DONE → NOTDOING`
  - Meetings: `MEETING → ENDED → CANCELED → SKIPPED`
  - Checkboxes: `[ ] → [-] → [?] → [x]`

#### 5. Checkbox Toggle
- **Enter** on checkbox line: Cycles `[ ]` → `[-]` → `[x]` → `[ ]`
- Works on headlines like: `** [ ] Task name`

#### 6. Timestamps
- **`<leader>mdi`**: Insert inactive timestamp with time: `[2026-06-29 Sun 14:45]`
- **`<leader>mdt`**: Insert active timestamp (date only): `<2026-06-29 Sun>`
- **`<leader>mdT`**: Insert inactive timestamp (date only): `[2026-06-29 Sun]`

#### 7. Search Headlines
- **`<leader>m/`**: Opens Telescope picker with all headlines
- Shows hierarchical structure with indentation
- Maintains file order (ascending sort)
- Jump to headline with Enter
- Unfolds headline automatically

#### 8. Syntax Highlighting
- Individual colors for each TODO keyword:
  - TODO: Orange/red
  - NEXT: Yellow
  - WIP: Green
  - AWAIT: Purple
  - BLOCKED: Red
  - IDEA: Light blue
  - MAYBE: Blue
  - DONE: Green
  - NOTDOING: Gray
  - MEETING: Blue
  - ENDED/CANCELED/SKIPPED: Grays
- Timestamps, drawers, links, emphasis all highlighted

---

## Phase 1 Keybindings

| Action | Key | Context |
|--------|-----|---------|
| Cycle fold | `<Tab>` | On headline |
| Global visibility | `<Shift-Tab>` | Anywhere |
| Delete subtree | `dd` | On headline |
| Move up | `Option-k` or `<A-k>` | On headline |
| Move down | `Option-j` or `<A-j>` | On headline |
| Promote | `<<` | On headline |
| Demote | `>>` | On headline |
| TODO menu | `<leader>mt` | On headline |
| Toggle checkbox | `<CR>` | On checkbox line |
| Timestamp (time) | `<leader>mdi` | Anywhere |
| Timestamp (date, active) | `<leader>mdt` | Anywhere |
| Timestamp (date, inactive) | `<leader>mdT` | Anywhere |
| Search headlines | `<leader>m/` | Anywhere in org file |

**Note**: `<leader>` is `<Space>` in your config

---

## Technical Architecture

### File Structure
```
nvim/.config/nvim/
├── lua/org/
│   ├── init.lua         # Main module, setup, keybindings
│   ├── config.lua       # User configuration (agenda files)
│   ├── fold.lua         # Folding + structural editing
│   ├── todo.lua         # TODO cycling + checkbox toggle
│   ├── timestamp.lua    # Timestamp utilities
│   ├── telescope.lua    # Telescope integration
│   ├── treesitter.lua   # Tree-sitter utilities (fallback patterns)
│   ├── clock.lua        # Clock system (Phase 2 stub)
│   ├── capture.lua      # Capture system (Phase 3 stub)
│   ├── schedule.lua     # Schedule/deadline (Phase 3 stub)
│   ├── refile.lua       # Refile system (Phase 2 stub)
│   ├── agenda.lua       # Agenda views (Phase 4 stub)
│   └── README.md        # Documentation
├── lua/plugins/org-mode.lua  # Plugin loader
├── lua/config/bootstrap.lua  # Added tree-sitter-org package
├── syntax/org.vim       # Syntax highlighting
├── ftdetect/org.vim     # Filetype detection
└── test.org             # Test file
```

### Dependencies
- `nvim-treesitter/nvim-treesitter` (already installed)
- `nvim-orgmode/tree-sitter-org` (added to bootstrap.lua)
- `nvim-telescope/telescope.nvim` (already installed)
- `folke/which-key.nvim` (already installed)

### Configuration
Your agenda files are set in `lua/org/config.lua`:
```lua
M.agenda_files = {
  "~/Documents/notes/journal/2026/general.org",
  "~/Documents/notes/journal/2026/leave.org",
  "~/Documents/notes/journal/2026/hwo.org",
  "~/Documents/notes/inbox.org",
}
```

---

## Issues Fixed During Phase 1

1. **Plugin loading**: Adapted to your existing vim.pack system (not Lazy.nvim)
2. **MacBook Option key**: Added mappings for ∆ (Option-j) and ˚ (Option-k)
3. **Which-key API**: Updated to new `wk.add()` format (v3.0+)
4. **Fold text**: Used empty `foldtext` to preserve syntax highlighting
5. **Drawer folding**: Made drawers independently foldable while maintaining headline fold
6. **Telescope order**: Set `sorting_strategy = "ascending"` to maintain file order
7. **Search conflict**: Removed `<leader>/` to avoid overriding normal search

---

## Phase 2 Plan (Next Steps)

### Critical Features (Migration Blockers)
Phase 2 must be completed before you can migrate from Emacs.

#### 1. Clock System
- Clock in/out (`<leader>mci`, `<leader>mco`)
- Create/append to `:LOGBOOK:` drawer
- Format: `CLOCK: [2026-06-29 Sun 14:30]--[2026-06-29 Sun 15:45] => 1:15`
- Store active clock in global state
- Clock persistence across restarts (save to `~/.local/state/nvim/org-clock-save.json`)
- Jump to current clock (`<leader>mcg`)

#### 2. Modeline/Lualine Clock Display
- Show on right side of statusline:
  - Clock indicator (e.g., 🕐)
  - Current headline text
  - Duration (HH:MM format)
- Update every minute

#### 3. Clock Tables ⭐ **CRITICAL**
- Parse `:BEGIN: clocktable` dynamic blocks
- Extract parameters: `:maxlevel`, `:scope`, `:block`, `:tstart`, `:tend`
- Scan specified scope for CLOCK entries in date range
- Sum durations by headline hierarchy
- Render org table with proper formatting
- **Ctrl-C** updates clock table when cursor in/near block

Example block:
```org
#+BEGIN: clocktable :maxlevel 2 :scope file :block today
#+END:
```

#### 4. Refile with Telescope ⭐ **CRITICAL**
- Extract headline + full subtree under cursor
- Telescope picker: scan all headlines in agenda files
- Format: `"filename.org: * Parent > ** Child"`
- Preview shows context of destination
- Insert subtree under selected destination
- Delete from source location

#### 5. State Change Logging
- When marking DONE, add to `:LOGBOOK:`
- Format: `- State "DONE" from "TODO" [2026-06-29 Sun 14:30]`

### Estimated Complexity
Phase 2: 30-40 hours (longest phase due to clock tables + refile)

---

## Phase 3 Plan (Capture & Schedule)

### Features
1. Two capture templates (`t` and `W`)
2. Which-key template picker
3. Schedule/Deadline insertion (`<leader>mds`, `<leader>mdd`)
4. Deadline warning period parsing (`-14d`)
5. Date picker (text input with relative dates like `+3d`, `Mon`)

### Estimated Complexity
8-12 hours (simplified from original - only 2 templates)

---

## Phase 4 Plan (Agenda)

### Features
1. **"Today" view**: Clocked time + scheduled items
2. **TODO list**: Today/overdue/approaching deadline
3. Date-based filtering (no super-agenda groups)
4. **Navigation**:
   - `j/k`: Move between items
   - `<CR>`: Jump to item (close agenda)
   - `<Tab>`: Preview in split (keep agenda open)
   - `[` / `]`: Navigate back/forward one day
   - `g r`: Refresh agenda
5. **Commands from agenda** (without leaving):
   - `<leader>mci/o`: Clock in/out
   - `<leader>mds/d`: Schedule/deadline
6. Smart window splitting based on terminal size
7. Fold state management (unfold headline, fold drawers)

### Estimated Complexity
15-20 hours (simplified - no super-agenda grouping)

---

## Migration Timeline

**Before Migration Possible**:
- ✅ Phase 1 (complete)
- ⏳ Phase 2 (in progress) - **30-40 hours**
- Total: ~42-58 hours from start

**Recommended Before Migration**:
- Phase 3 (capture) - adds 8-12 hours
- Total: ~50-70 hours

**Full Feature Parity**:
- Phase 4 (agenda) - adds 15-20 hours
- Total: ~65-90 hours

**Current Progress**: ~18 hours invested (Phase 1 complete with refinements)

---

## Known Limitations

1. **No virtual indentation**: Org files display flat (no visual indentation like Emacs)
   - Tree-sitter handles structure parsing regardless
   - Possible future enhancement with `indent-blankline.nvim`

2. **Tree-sitter org parser**: Added to bootstrap but uses regex fallbacks currently
   - Run `:PackUpdate` to install
   - Will enhance parsing when available

3. **File format compatibility**: All org files remain fully compatible with Emacs
   - Same syntax, same structure
   - Can switch between Emacs and Neovim freely

---

## Testing & Installation

### Current Installation Status
Files are in place but require neovim restart to activate.

### To Apply All Changes
```bash
# 1. Restart neovim
# Close and reopen nvim

# 2. Install tree-sitter-org parser
:PackUpdate

# 3. Test features
nvim ~/.config/nvim/test.org
```

### Testing Checklist
- [x] TODO keywords are colorized
- [x] `<leader>mt` shows which-key menu
- [x] `<CR>` on checkbox toggles state
- [x] `Option-j/k` moves headlines
- [x] `<leader>mdt/T` inserts date timestamps
- [x] `<Tab>` cycles folds
- [x] `<Shift-Tab>` cycles global visibility
- [x] Folded headlines show syntax highlighting
- [x] Drawers fold independently
- [x] `<leader>m/` searches headlines in file order

---

## Important Notes

### Plugin System
Your neovim uses **vim.pack** (native package manager), not Lazy.nvim:
- Plugins listed in `lua/config/bootstrap.lua`
- Auto-installed to `~/.local/share/nvim/site/pack/plugins/start/`
- Commands: `:PackUpdate`, `:PackClean`, `:PackStatus`

### Keybinding Conflicts Avoided
- Removed `<leader>/` mapping (was conflicting with normal search)
- Only `<leader>m/` is mapped for org headline search
- Regular `/` search works normally

### Which-Key Integration
Updated to v3.0+ API:
- Uses `wk.add()` instead of `wk.register()`
- No deprecation warnings in `:checkhealth which-key`

---

## Reference Documents

Created during this session:
1. `ORG_MODE_FEASIBILITY_STUDY.md` - Complete feature analysis with decisions
2. `PHASE1_UPDATES.md` - User feedback implementations
3. `TEST_ORG.md` - Testing instructions
4. `test.org` - Test file with examples
5. `lua/org/README.md` - Technical documentation
6. **This file** - Comprehensive project summary

---

## Next Session: Starting Phase 2

When resuming work:

1. **Review Phase 2 requirements** from this document
2. **Priority order**:
   - Clock in/out system (foundation)
   - Logbook drawer creation
   - Lualine clock display
   - Clock tables (critical, complex)
   - Refile with Telescope (critical, complex)
   - State change logging

3. **Start with**: Clock system foundation
   - Global clock state management
   - Clock in/out functions
   - Logbook drawer creation
   - Test with real org files

4. **Key considerations**:
   - Clock tables are essential daily workflow - highest priority
   - Refile is very important - second highest priority
   - Both are complex and will take significant time
   - File format must remain Emacs-compatible

5. **Files to modify**:
   - `lua/org/clock.lua` (stub → full implementation)
   - `lua/plugins/lualine.lua` (add clock display)
   - Create new `lua/org/clocktable.lua` module
   - Update `lua/org/refile.lua` (stub → full implementation)

---

## Success Criteria

### Phase 1 ✅
- [x] All core editing features working
- [x] Syntax highlighting functional
- [x] Folding matches Emacs behavior
- [x] All user feedback addressed

### Phase 2 (Minimum Viable for Migration)
- [ ] Can clock in/out reliably
- [ ] Clock persists across restarts
- [ ] Clock tables generate and update correctly
- [ ] Can refile headlines to any location in agenda files
- [ ] Logbook entries format correctly

### Phase 3 (Recommended for Migration)
- [ ] Can quickly capture new items
- [ ] Templates work with clock-in option
- [ ] Can schedule and set deadlines

### Phase 4 (Full Workflow)
- [ ] Agenda view shows today's schedule
- [ ] Can navigate and interact with agenda
- [ ] Date filtering works correctly

---

## Contact & Questions

For issues or questions when resuming:
1. Check `ORG_MODE_FEASIBILITY_STUDY.md` for detailed feature specs
2. Review `lua/org/README.md` for technical details
3. Test with `test.org` to verify current functionality
4. Use `:checkhealth which-key` to verify no conflicts

**Current repository state**: All Phase 1 files committed, ready for Phase 2 work.
