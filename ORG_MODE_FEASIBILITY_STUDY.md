# Org-Mode to Neovim Lua Implementation - Feasibility Study

## Executive Summary
This document analyzes the feasibility of implementing a subset of org-mode features in Neovim using Lua, based on your actual Doom Emacs configuration. The goal is to maintain your workflow while leveraging existing neovim infrastructure (Telescope, which-key, lualine, treesitter).

## Current Infrastructure Assessment

### ✅ Already Available in Neovim
- **Telescope**: Powerful fuzzy finder (can replace consult/search)
- **which-key**: Shows keybinding hints (similar to Doom's which-key)
- **lualine**: Statusline (can show clock status)
- **treesitter**: Has org-mode parser available
- **Autosave**: Already configured
- **zen-mode**: Already configured

### 🔧 Existing Keybindings to Preserve
- `<leader>t`: Insert timestamp (already mapped)
- `<leader><Space>`: Telescope picker
- `<C-p>`: File finder
- `<C-f>`: Live grep

---

## Feature-by-Feature Analysis

### 1. BASIC ORG FEATURES

#### 1.1 Tab Visibility Cycling (⭐ HIGH PRIORITY)
**Doom Behavior**: `TAB` cycles through folded → children visible → fully expanded
**Feasibility**: ✅ **EASY**
- Tree-sitter provides fold information
- Neovim has native folding with `foldmethod=expr`
- Implementation: Use tree-sitter queries to define foldable regions
- **Recommendation**: Implement first - core feature

#### 1.2 Structural Editing (⭐ HIGH PRIORITY)
**User Requirement**: When cursor is on folded headline:
- `dd` should delete entire headline + contents (whole subtree)
- `<A-j>` / `<A-k>` should move entire headline up/down
**Feasibility**: ✅ **MODERATE**
- Use tree-sitter to detect subtree boundaries
- Override `dd` in org files when on headline
- Extend existing `<A-j>/<A-k>` keybindings for headlines
- **Implementation**: Check if cursor on headline, get subtree range via tree-sitter, operate on range
- **Recommendation**: Essential for org workflow, include in Phase 1

#### 1.3 Virtual Indentation Display
**User Note**: Raw org files are NOT indented - Emacs shows virtual indentation
**Question**: Can neovim display virtual indentation without modifying files?
**Feasibility**: ⚠️ **COMPLEX** - Neovim options:
- **Option A**: `conceallevel` + virtual text (limited, hacky)
- **Option B**: Tree-sitter indent queries (affects editing, not display)
- **Option C**: Accept no visual indentation (files remain flat)
- **Option D**: Use `indent-blankline.nvim` with custom logic (partial solution)
**Recommendation**: Start with **Option C** (no indentation) - tree-sitter handles folding/structure. Add virtual indent later if critical.
**Tree-sitter impact**: No - tree-sitter parses structure regardless of whitespace

#### 1.4 Fold on Startup
**Config Line 199**: `org-startup-folded t`
**Feasibility**: ✅ **TRIVIAL**
- Set `foldlevel=0` on org file open
- **Recommendation**: Include in initial setup

#### 1.5 Font Sizing for Headers
**Config Lines 38-41**: Different sizes for h1, h2
**Feasibility**: ⚠️ **TERMINAL LIMITATION**
- Neovim can't change font size in terminal (only GUI)
- Can use **highlight/color** instead to distinguish levels
- **Recommendation**: Use bold/color instead of size

#### 1.6 Relative Line Numbers
**Config Lines 110-111**: Already enabled
**Feasibility**: ✅ **ALREADY DONE**
- You already have `vim.opt.number = true` and `relativenumber = true`

#### 1.7 Syntax Highlighting in Source Blocks
**User Requirement**: Want syntax highlighting inside `#+begin_src` blocks
**Feasibility**: ✅ **EASY** - Tree-sitter already handles this!
- Tree-sitter org parser has injection queries for source blocks
- Automatically highlights code based on language tag
- **Recommendation**: Should work out of box with tree-sitter

---

### 2. TODO KEYWORDS & STATUS

#### 2.1 Custom TODO Keywords
**Config Lines 186-190**:
```elisp
TODO(t) NEXT(n) WIP(w!) AWAIT(a@) BLOCKED(b@) IDEA(i) MAYBE | DONE(d@) NOTDOING(c@)
MEETING(m) | ENDED(e) CANCELED(c@) SKIPPED(s@)
[ ](T) [-](S) [?](W) | [x](D)
```
**Feasibility**: ✅ **MODERATE**
- Store as Lua table configuration
- Tree-sitter can parse TODO keywords
- Implement state cycling with `SPC m t`
- **Which-key integration**: Show popup with available states
- **Recommendation**: Essential for workflow

#### 2.2 TODO State Transitions with Which-Key
**Your Requirement**: `SPC m t` shows popup with TODO states
**Feasibility**: ✅ **MODERATE**
- Use which-key to show available states
- Parse current state, show valid next states
- **Recommendation**: High value, implement with TODO feature

---

### 3. TIMESTAMPS & SCHEDULING

#### 3.1 Insert Inactive Timestamp
**Config Lines 161-165**: `SPC m d i` inserts `[2024-06-29 Sat 14:30]`
**Your Keybinding**: Already have `<leader>t` for timestamps
**Feasibility**: ✅ **EASY**
- You already have timestamp insertion at line 8 of keymaps.lua
- Need to add inactive (square brackets) variant
- **Recommendation**: Extend existing functionality

#### 3.2 Schedule and Deadline
**Config**: `SPC m d s` (schedule), `SPC m d d` (deadline)
**Feasibility**: ✅ **MODERATE**
- Use `vim.ui.input` or Telescope for date picker
- Insert `SCHEDULED: <2024-06-29 Sat>` or `DEADLINE:`
- **Recommendation**: Important for agenda, should implement

---

### 4. SEARCH & NAVIGATION

#### 4.1 Search All Headlines (`SPC m /`)
**Doom Behavior**: Search through all org headlines in current file
**Feasibility**: ✅ **EASY** - Telescope Integration!
- Use tree-sitter to extract all headlines
- Feed to Telescope picker
- Jump to selected headline
- **Recommendation**: High value, natural fit for Telescope

#### 4.2 Search Everywhere (`SPC /`)
**Your Config**: Likely uses consult-ripgrep
**User Clarification**: Keep existing neovim binding - just triggers Telescope ripgrep
**Feasibility**: ✅ **ALREADY DONE**
- You have `<C-f>` mapped to `live_grep`
- This is exactly what's needed
- **Recommendation**: No changes needed - existing binding is perfect

---

### 5. CAPTURE SYSTEM

#### 5.1 Capture Templates
**Config Lines 428-464**: Multiple capture templates with clock-in
**User Clarification**: Only need TWO templates:
- `t`: Todo (no clock change)
- `W`: Work (interrupt - with clock-in)

**Feasibility**: ✅ **MODERATE** (simplified from original assessment)
- Show which-key menu with 2 options
- Insert at inbox.org
- `W` template: clock in + jump to captured item
- Support date formatting: `%<%m%d>`, `%U` (inactive timestamp), `%?` (cursor)
- **Recommendation**: Much simpler with only 2 templates, Phase 3

**Template Structure**:
```lua
templates = {
  { key = "t", desc = "Todo", template = "* TODO %?\n%U" },
  { key = "W", desc = "Work (interrupt)", template = "* %<%m%d> %?\n%U", 
    clock_in = true, jump_to_captured = true },
}
```

---

### 6. REFILE

#### 6.1 Refile Functionality (`SPC m s r`) ⭐ **HIGH PRIORITY**
**Doom Behavior**: Move headline to another file/headline
**User Requirement**: Integrate with Telescope - **very important to workflow**
**Feasibility**: ✅ **MODERATE**
- Extract headline + full subtree under cursor (tree-sitter)
- Telescope picker: scan all headlines in agenda files
- Preview shows context of destination
- Insert subtree under selected destination headline
- Delete from source location
- **Recommendation**: **MOVED TO PHASE 2** - user says this is critical workflow component
- **Implementation notes**:
  - Build refile target cache on demand
  - Format: "filename.org: * Parent > ** Child"
  - Use telescope's preview to show destination context

---

### 7. AGENDA & ORG-SUPER-AGENDA

#### 7.1 Basic Agenda View
**Config Lines 330-410**: Custom agenda with super-agenda grouping
**Your Keybinding**: `SPC z`
**Feasibility**: ✅ **MODERATE** (with simplified scope)

**Updated Requirements** (from user):
- **Section 1 - "Today" View**: All clocked time + scheduled items for today in org-agenda format
- **Section 2 - TODO List**: Items that are:
  - Scheduled for today
  - Overdue (past scheduled/deadline date)
  - Deadline approaching (based on warning period, e.g., `-14d`)

**Implementation Requirements**:
- Parse all agenda files for TODO items
- Extract SCHEDULED/DEADLINE timestamps
- Parse warning period syntax: `DEADLINE: <2026-07-03 Fri -14d>` → show 14 days before
- Default warning period: 14 days (if not specified)
- Group clock entries by headline for "today" view
- Sort TODO list: overdue first, then by date
- Render in dedicated buffer with syntax highlighting
- **Navigation keybindings**:
  - `j/k`: Move between items
  - `<CR>`: Jump to item in current window (close agenda)
  - `<Tab>`: Preview item in split window (keep agenda open)

**Agenda Preview/Navigation (TAB behavior)**:
**User Requirement**: When cursor on headline in agenda:
- `<Tab>` splits window (smart direction based on size)
- Opens source file in split
- Jumps to headline
- Unfolds headline content
- Keeps drawers (`:LOGBOOK:`, `:PROPERTIES:`) folded

**Feasibility**: ✅ **MODERATE**
- Store file + line metadata for each agenda item
- Detect available window space: `vim.o.columns` / `vim.o.lines`
- Split logic:
  - If `columns >= 160`: vertical split (`:vsplit`)
  - Otherwise: horizontal split (`:split`)
- Jump to line and set fold levels:
  - Unfold current headline: `vim.cmd('normal! zv')`
  - Fold drawers: `vim.cmd('normal! zc')` on drawer lines
- Alternative: Use preview window (`:pedit`) for simpler implementation

**Implementation Complexity**: Medium
- Basic jump (`:edit +line file`): Easy
- Smart splitting: Easy
- Fold state management: Moderate (need to detect drawer boundaries)

**Recommendation**: Implement both `<CR>` (jump) and `<Tab>` (preview) navigation. Use vim split commands, detect terminal size for direction.

**Agenda Date Navigation**:
**User Requirement**: Navigate through dates in agenda view
- `[` - Go back one day (re-render agenda for previous day)
- `]` - Go forward one day (re-render agenda for next day)

**Feasibility**: ✅ **EASY**
- Track current agenda date in buffer-local variable
- On `[` or `]`: adjust date, regenerate agenda buffer
- Preserve cursor position (by item index, not line number)
- **Implementation**: Simple date arithmetic, trigger agenda refresh

**Agenda Refresh**:
**User Requirement**: `g r` to refresh/regenerate agenda
**Feasibility**: ✅ **TRIVIAL**
- Re-parse all agenda files
- Regenerate buffer with current date
- Restore cursor position if possible
- Standard vim pattern: `g r` for refresh

**Agenda Clock Commands**:
**User Requirement**: Clock in/out from agenda without leaving
- `SPC m c i` on agenda headline → clock in at source location, stay in agenda
- `SPC m c o` from anywhere → clock out, update agenda display if needed

**Feasibility**: ✅ **MODERATE**
- Agenda items store file + line reference
- Clock in: Update source file's LOGBOOK, update global clock state
- Update modeline immediately
- **Optionally**: Update agenda buffer to show clock indicator on item
- Clock out: Update source file, update modeline
- No need to leave agenda buffer

**Implementation Notes**:
- Clock commands check if in agenda buffer
- If yes: get headline metadata, operate on source file
- If no: operate on current headline normally
- After clocking in from agenda: optionally mark item with clock indicator (e.g., `⏰`)

**Recommendation**: Essential workflow optimization. Implement alongside clock system in Phase 2.

**Agenda Schedule/Deadline Commands**:
**User Requirement**: Set schedule/deadline from agenda without leaving
- `SPC m d s` on agenda headline → prompt for date, add SCHEDULED to source
- `SPC m d d` on agenda headline → prompt for date, add DEADLINE to source (with warning period)

**Feasibility**: ✅ **MODERATE**
- Similar pattern to clock commands
- Get headline metadata from agenda item
- Prompt for date (text input or picker)
- For deadline: also prompt for warning period (e.g., `-14d`)
- Update source file, insert timestamp after headline
- **Optionally**: Refresh agenda to show updated scheduling
- Stay in agenda buffer

**Implementation Notes**:
- Schedule/deadline commands check if in agenda buffer
- If yes: operate on source file via stored reference
- If no: operate on current headline normally
- After updating: optionally trigger agenda refresh to show changes immediately
- Format: `SCHEDULED: <2026-06-29 Sun>` or `DEADLINE: <2026-07-03 Thu -14d>`

**Recommendation**: Important for quick planning workflow. Implement alongside schedule/deadline in Phase 3.

#### 7.2 Agenda Files Configuration
**Config Lines 317-325**: List of org files to include
**Feasibility**: ✅ **TRIVIAL**
- Store as Lua table
- You have consistent location: `~/Documents/notes/`
- **Recommendation**: Easy config

---

### 8. CLOCKING & LOGBOOK

#### 8.1 Clock In/Out (`SPC m c i`, `SPC m c o`)
**Feasibility**: ✅ **MODERATE**
- Create/append to `:LOGBOOK:` drawer
- Format: `CLOCK: [2024-06-29 Sat 14:30]--[2024-06-29 Sat 15:45] => 1:15`
- Store active clock in global state
- **Recommendation**: Essential for your workflow, high priority

#### 8.2 Clock Persistence
**Config Lines 470-472**: Save clock through Emacs restart
**Feasibility**: ✅ **MODERATE**
- Save active clock to file (e.g., `~/.local/state/nvim/org-clock`)
- Restore on startup
- **Recommendation**: Nice-to-have, add after basic clocking works

#### 8.3 Modeline Clock Display
**Your Requirement**: Show current headline + time on right side
**Feasibility**: ✅ **MODERATE**
- Update lualine config to show:
  - Clock indicator (e.g., 🕐)
  - Current headline text
  - Duration (HH:MM)
- **Recommendation**: High value for awareness, good lualine integration

#### 8.4 Jump to Current Clock (`SPC m c g`)
**Config Lines 479-486**: Jump and narrow to clocked headline
**Feasibility**: ✅ **EASY**
- Store file + position when clocking in
- Jump to location
- Optional: use folds to "narrow"
- **Recommendation**: Simple, should include

#### 8.5 Log DONE Tasks
**Config Lines 148-151**: Log timestamp when marking DONE
**Feasibility**: ✅ **MODERATE**
- When changing to DONE state, add to `:LOGBOOK:`
- Format: `- State "DONE" from "TODO" [2024-06-29 Sat 14:30]`
- **Recommendation**: Part of TODO state transition system

---

### 9. CLOCK TABLES ⭐ **CRITICAL - DAILY WORKFLOW**

#### 9.1 Clock Tables
**User Clarification**: Essential part of daily workflow, use extensively
**Feasibility**: ✅ **MODERATE-COMPLEX** - but required
- Parse `:BEGIN: clocktable` dynamic block
- Extract parameters: `:maxlevel`, `:scope`, `:block`, `:tstart`, `:tend`
- Scan specified scope (file/tree/agenda) for CLOCK entries in date range
- Sum durations by headline hierarchy
- Render org table with formatting
- **Recommendation**: **MOVED TO PHASE 2** - user requires this daily
- **Implementation priority**: After basic clocking works, before agenda

**Example dynamic block**:
```org
#+BEGIN: clocktable :maxlevel 2 :scope file :block today
#+END:
```

#### 9.2 Ctrl+C Evaluation (Update Clock Tables) ⭐ **ESSENTIAL**
**User Requirement**: Ctrl+C must update clock tables
**Feasibility**: ✅ **MODERATE**
- Detect if cursor is in/near clocktable block
- Re-parse parameters and regenerate table
- Update content between `#+BEGIN:` and `#+END:`
- **Recommendation**: **PHASE 2** - implement alongside clock tables
- **Implementation**: Keybinding `<C-c>` when in clocktable block
- **Scope**: Only clock tables needed, NOT other dynamic block types (formulas, etc.)

---

### 10. PROMOTE/DEMOTE

#### 10.1 Headline Promote/Demote (`>>`, `<<`)
**Feasibility**: ✅ **EASY**
- Detect current headline level via tree-sitter
- Add/remove `*` characters
- Update child headlines recursively (optional)
- **Recommendation**: Simple and useful, include

---

### 11. CONFIGURATION ITEMS FROM CONFIG.ORG

#### 11.1 Font & Theme (Lines 12-61)
**Relevance**: ❌ **NOT NEEDED**
- Editor appearance, not org functionality
- You have neovim theme configured

#### 11.2 Key Remapping (Lines 115-123)
**Relevance**: ❌ **NOT NEEDED**
- MacOS/Emacs specific
- Neovim handles this differently

#### 11.3 Disable Company Completion (Lines 82-98)
**Relevance**: ❌ **NOT NEEDED**
- You may want completion in nvim, different ecosystem

#### 11.4 Log Settings (Lines 170-180)
**Relevance**: ✅ **NEEDED**
- Note headings format for state changes
- Essential for logbook feature

#### 11.5 Duration Format (Lines 155-157)
**Relevance**: ✅ **NEEDED**
- Always show as `H:MM` (not days)
- Important for clock display

#### 11.6 Hide Emphasis Markers (Line 195)
**Relevance**: ❌ **DO NOT IMPLEMENT**
- User clarification: Do NOT conceal emphasis characters
- Want to see `*bold*`, `_italic_` etc. explicitly

#### 11.7 Evil-mode settings (Lines 525-550)
**Relevance**: ✅ **PARTIALLY**
- Split behavior (Lines 533-538): You might want similar
- Visual line navigation (Lines 547-550): You already have this (keymaps.lua:36-37)

#### 11.8 Open docx/pptx/xlsx with external app (Lines 493-498)
**Relevance**: ❌ **NOT NEEDED**
- User clarification: Doesn't use this feature in org-mode
- Skip implementation

#### 11.9 Custom Function: Extract Clock to New Heading (Lines 221-275)
**Relevance**: 🤔 **SPECIALIZED**
- Very specific workflow function
- Probably low priority, add later if needed

---

## RECOMMENDED IMPLEMENTATION PHASES

### PHASE 1: Core Editing (Week 1-2) ⭐ **UPDATED**
**Goal**: Make org files usable for notes
1. ✅ Folding (TAB cycling, fold on startup)
2. ✅ **Structural editing** (`dd` on headline, `<A-j>/<A-k>` to move) - **NEW**
3. ✅ Headline promote/demote (`>>`, `<<`)
4. ✅ TODO state cycling (`SPC m t` with which-key)
5. ✅ Timestamp insertion (extend existing `<leader>t`)
6. ✅ Search headlines (`SPC m /` with Telescope)
7. ✅ Syntax highlighting via tree-sitter (including source blocks)

**Estimated Complexity**: Low-Medium
**Value**: Immediate usability
**Note**: Virtual indentation display deferred (complex, not essential)

### PHASE 2: Time Tracking & Organization (Week 3-6) ⭐ **EXPANDED & CRITICAL**
**Goal**: Enable complete daily workflow (clocking, tables, refile)
1. ✅ Clock in/out (`SPC m c i/o`)
2. ✅ Logbook drawer creation
3. ✅ Modeline/lualine clock display
4. ✅ Jump to clock (`SPC m c g`)
5. ✅ Clock persistence across sessions
6. ✅ State change logging (DONE timestamps)
7. ⭐ **Clock tables** (parse, generate, format) - **MOVED FROM PHASE 5**
8. ⭐ **Ctrl+C evaluation** (update clock tables) - **MOVED FROM PHASE 5**
9. ⭐ **Refile with Telescope** - **MOVED FROM PHASE 5**

**Estimated Complexity**: Medium-High
**Value**: CRITICAL - user cannot migrate without these features
**Rationale**: Clock tables + refile are essential daily workflow, not optional

### PHASE 3: Capture & Schedule (Week 7-8)
**Goal**: Quick capture and date management
1. ✅ Two capture templates: `t` (Todo), `W` (Work interrupt) - **SIMPLIFIED**
2. ✅ Which-key template picker
3. ✅ Schedule/Deadline insertion (`SPC m d s/d`)
4. ✅ Deadline warning period parsing (`-14d`)
5. ✅ Date picker (text input with relative dates)

**Estimated Complexity**: Medium
**Value**: High - rapid capture is crucial
**Note**: Only 2 templates needed (simplified from original 5)

### PHASE 4: Agenda (Week 9-12)
**Goal**: Overview of tasks (simplified scope)
1. ⚠️ Parse agenda files for TODO items
2. ⚠️ Extract SCHEDULED/DEADLINE with warning periods
3. ⚠️ "Today" view: clocked time + scheduled items
4. ⚠️ TODO list: today/overdue/approaching deadline
5. ⚠️ Agenda buffer rendering with syntax highlighting
6. ⚠️ **Navigation keybindings**:
   - `j/k` movement between items
   - `<CR>` jump to item (close agenda)
   - `<Tab>` preview in split (keep agenda open)
   - `[` / `]` navigate back/forward one day
   - `g r` refresh agenda
7. ⚠️ **Commands from agenda** (operate on headline without leaving):
   - `SPC m c i` clock in
   - `SPC m c o` clock out
   - `SPC m d s` schedule
   - `SPC m d d` deadline
8. ⚠️ **Smart window splitting** based on terminal size
9. ⚠️ **Fold state management** (unfold headline, fold drawers)
10. ⚠️ Date-based filtering (no super-agenda grouping)

**Estimated Complexity**: Medium-High
**Value**: High for weekly planning
**Note**: Preview navigation adds moderate complexity but is essential for workflow

### PHASE 5: Polish & Optional Features (Week 13+)
**Goal**: Nice-to-have improvements
1. 🤔 Virtual indentation display (if desired)
2. 🤔 Advanced date picker (Telescope calendar)
3. 🤔 Additional capture templates (if needed)
4. 🤔 Custom functions (extract clock, etc.)
5. ❌ ~~Hide emphasis markers~~ (user does not want)
6. ❌ ~~Open external files~~ (not used)

**Estimated Complexity**: Low-Medium
**Value**: Optional enhancements

---

## TECHNICAL ARCHITECTURE RECOMMENDATIONS

### File Structure
```
nvim/.config/nvim/lua/
├── plugins/
│   └── org-mode.lua          # Plugin manager declaration
└── org/
    ├── init.lua              # Main setup and config
    ├── config.lua            # User configuration (agenda files, keywords, etc.)
    ├── fold.lua              # Folding logic
    ├── todo.lua              # TODO state management
    ├── timestamp.lua         # Date/time utilities
    ├── clock.lua             # Clocking system
    ├── capture.lua           # Capture templates
    ├── schedule.lua          # Schedule/deadline
    ├── agenda.lua            # Agenda views
    ├── refile.lua            # Refile functionality
    ├── telescope.lua         # Telescope integrations
    └── treesitter.lua        # Tree-sitter queries
```

### Key Dependencies
- `nvim-treesitter/nvim-treesitter` (already have)
- Tree-sitter org parser: `:TSInstall org`
- `nvim-telescope/telescope.nvim` (already have)
- `folke/which-key.nvim` (already have)
- `nvim-lualine/lualine.nvim` (already have)

### Data Structures
```lua
-- Global state
_G.org_state = {
  active_clock = {
    file = nil,
    line = nil,
    headline = nil,
    start_time = nil,
  },
  agenda_files = {}, -- from config
  todo_keywords = {}, -- from config
}
```

---

## KEYBINDING MAPPING

### Doom → Neovim Mapping
| Feature | Doom Emacs | Proposed Neovim | Status |
|---------|-----------|----------------|--------|
| Capture | `SPC X` | `<leader>X` | ✅ Available |
| TODO state | `SPC m t` | `<leader>mt` | ✅ Available |
| Refile | `SPC m s r` | `<leader>msr` | ✅ Available |
| Search headlines | `SPC m /` | `<leader>m/` | ✅ Available |
| Search everywhere | `SPC /` | `<leader>/` | ⚠️ Conflicts with existing? |
| Agenda | `SPC z` | `<leader>z` | ✅ Available |
| Agenda preview | `TAB` (in agenda) | `<Tab>` (in agenda) | ✅ Available |
| Agenda jump | `RET` (in agenda) | `<CR>` (in agenda) | ✅ Available |
| Agenda prev day | `[` (in agenda) | `[` (in agenda) | ✅ Available |
| Agenda next day | `]` (in agenda) | `]` (in agenda) | ✅ Available |
| Agenda refresh | `g r` (in agenda) | `g r` (in agenda) | ✅ Available |
| Clock in (agenda) | `SPC m c i` (agenda) | `<leader>mci` (agenda) | ✅ Available |
| Clock out (agenda) | `SPC m c o` (agenda) | `<leader>mco` (agenda) | ✅ Available |
| Schedule (agenda) | `SPC m d s` (agenda) | `<leader>mds` (agenda) | ✅ Available |
| Deadline (agenda) | `SPC m d d` (agenda) | `<leader>mdd` (agenda) | ✅ Available |
| Insert timestamp | `SPC m d i` | `<leader>mdi` | ✅ Available |
| Schedule | `SPC m d s` | `<leader>mds` | ✅ Available |
| Deadline | `SPC m d d` | `<leader>mdd` | ✅ Available |
| Clock in | `SPC m c i` | `<leader>mci` | ✅ Available |
| Clock out | `SPC m c o` | `<leader>mco` | ✅ Available |
| Clock goto | `SPC m c g` | `<leader>mcg` | ✅ Available |
| Fold toggle | `TAB` | `<Tab>` | ✅ Available |
| Promote | N/A (evil) | `<<` | ✅ Available |
| Demote | N/A (evil) | `>>` | ✅ Available |
| Delete headline | `dd` (headline) | `dd` (headline context) | ✅ Available |
| Move headline up | N/A | `<A-k>` (headline context) | ✅ Already mapped |
| Move headline down | N/A | `<A-j>` (headline context) | ✅ Already mapped |

**Note**: `<leader>` is `<Space>` in your config

---

## RISKS & LIMITATIONS

### Known Limitations
1. **Terminal Font Sizing**: Can't vary font size for headlines like Emacs
2. **Agenda Complexity**: Full super-agenda will be simplified
3. **No Babel**: Code block execution not planned (different paradigm)
4. **Performance**: Large agenda files may be slower than Emacs (Lua vs C)

### Migration Risks
1. **Learning Curve**: Even with same keybindings, behaviors may differ
2. **File Compatibility**: Must maintain org-mode file format
3. **Clock Data**: Need to ensure clock persistence format is correct
4. **Two Systems**: During migration, keeping both in sync

---

## DECISION POINTS

### Q1: Agenda Scope ✅ **DECIDED**
**Decision**: Simplified agenda view with two main sections:
1. **"Today" view (top section)**: 
   - Show all clocked time entries for today
   - Show all scheduled items for today
   - Format should match org-agenda display style (date grid)
2. **TODO list (bottom section)**:
   - Items scheduled for today
   - Overdue items (scheduled/deadline in the past)
   - Items with approaching deadlines based on warning period
   - **Deadline warning syntax**: `DEADLINE: <2026-07-03 Fri -14d>` means show 14 days before due date

**Rationale**: User doesn't make extensive use of super-agenda groups. Focus on time-based filtering rather than tag/project grouping.

**Implementation Notes**:
- Parse `-Nd` warning period from deadline timestamps
- Default warning period: 14 days (configurable)
- Sort by: overdue first, then by date
- No need for complex super-agenda grouping initially

### Q2: Capture Location ✅ **DECIDED**
**Decision**: **which-key style menu** (Option B)

**Rationale**: Closer to Doom Emacs behavior, more intuitive for showing template descriptions.

**Implementation**:
- `SPC X` opens which-key menu
- Show: `t: Todo`, `T: Todo (interrupt)`, `m: Meeting`, `M: Meeting (interrupt)`, `W: Work (interrupt)`
- After selection, prompt for title/content
- Templates with `clock_in = true` start clock automatically

### Q3: Date Picker
**Decision**: Start with **text input** (Option B), upgrade later if needed

**Rationale**: Simpler to implement, gets us to working state faster. Can add Telescope calendar view in Phase 5 if desired.

**Implementation**:
- `vim.ui.input` for date entry
- Support formats: `YYYY-MM-DD`, `+3d` (relative), `Mon` (next Monday)
- Show current date as default/hint
- Add warning period prompt for deadlines (e.g., `-14d`)

### Q4: Feature Set ✅ **DECIDED**
**Decision**: Proceed with **full phased implementation plan**

**Phase commitment**:
- **Phase 1** (Core Editing): Week 1-2
- **Phase 2** (Time Tracking): Week 3-4
- **Phase 3** (Capture & Schedule): Week 5-6
- **Phase 4** (Agenda): Week 7-10
- **Phase 5** (Advanced): Week 11+ (as needed)

**Rationale**: Phased approach provides incremental value while building toward full workflow replacement.

---

## NEXT STEPS

1. ✅ Review this feasibility study together
2. ✅ Decide on target feature set for MVP
3. ✅ Confirm keybinding mappings
4. ✅ Install tree-sitter org parser: `:TSInstall org`
5. ✅ Create basic plugin structure
6. ✅ Implement Phase 1 features
7. ✅ Test with your actual org files
8. ✅ Iterate based on usage

---

## ESTIMATED TIMELINE ⭐ **UPDATED**

- **Phase 1 (Core Editing)**: 12-18 hours (added structural editing)
- **Phase 2 (Time Tracking & Organization)**: 30-40 hours (added clock tables, refile)
- **Phase 3 (Capture & Schedule)**: 8-12 hours (simplified to 2 templates)
- **Phase 4 (Agenda)**: 15-20 hours (simplified, no super-agenda)
- **Phase 5 (Polish)**: 5-10 hours (minimal scope)

**Total for Phases 1-2**: ~42-58 hours (minimum viable for migration - includes clock tables & refile)
**Total for Phases 1-3**: ~50-70 hours (includes capture)
**Total for Phases 1-4**: ~65-90 hours (full workflow replacement)

**Critical Path**: Phase 2 is now the longest due to clock tables + refile, but these are essential for user's workflow

---

## CONCLUSION

**Is this feasible?** ✅ **YES**

**Key Success Factors**:
1. Tree-sitter provides parsing foundation
2. Your existing neovim setup has the right infrastructure
3. Focusing on YOUR actual usage (not all org-mode) is achievable
4. Phased approach allows iterative value delivery

**Highest Value Features** (Do First):
1. Folding + structural editing + TODO states (Phase 1)
2. Clocking with modeline display (Phase 2.1)
3. **Clock tables with Ctrl+C update** (Phase 2.2) - **CRITICAL**
4. **Refile with Telescope** (Phase 2.3) - **CRITICAL**

**Biggest Challenges**:
1. **Clock tables**: Parsing parameters, date range logic, hierarchy summing, table formatting
2. **Refile**: Building target cache, tree-sitter subtree extraction, insertion logic
3. Structural editing: Tree-sitter boundary detection for `dd` and move operations
4. Maintaining org-mode file format compatibility (must be readable in Emacs)

**Migration Blocker Features** (must have before switching from Emacs):
- ✅ Basic editing (Phase 1)
- ⭐ Clock in/out + display (Phase 2.1)
- ⭐ Clock tables + update (Phase 2.2) - user uses daily
- ⭐ Refile (Phase 2.3) - very important to workflow
- ✅ Capture (Phase 3) - reduced to 2 templates
- ⚠️ Agenda (Phase 4) - can work with simplified version

**Recommendation**: 
- Complete **Phases 1-2** before attempting migration (includes all critical features)
- Phase 3 (capture) is important but can be manually worked around temporarily
- Phase 4 (agenda) is important for planning but not daily blocking
