# Migration to Neovim 0.12 & Native vim.pack

## What Changed

### Plugin Manager: lazy.nvim → vim.pack
- **Removed**: lazy.nvim plugin manager
- **Added**: Native vim.pack with custom bootstrap script
- **Result**: Simpler, faster, no external dependencies

### LSP: lspconfig → vim.lsp.config
- **Old API**: `require('lspconfig').server.setup({...})`
- **New API**: `vim.lsp.config(name, {...})` + `vim.lsp.enable(name)`
- **Why**: Old API deprecated in 0.11, removed in 0.12
- **See**: `:help lspconfig-nvim-0.11`

## Migration Steps

### 1. Clean Up Old Setup

```bash
# Remove lazy.nvim cache and plugins
rm -rf ~/.local/share/nvim/lazy/
rm -rf ~/.cache/nvim/

# The new config is already in place
```

### 2. First Launch

```bash
nvim
```

On first launch:
- Plugins auto-install via vim.pack (~30 seconds)
- All 24 plugins will be cloned to `~/.local/share/nvim/site/pack/plugins/start/`
- Helptags will be generated

### 3. Update Treesitter Parsers

```vim
:TSBootstrap
```

### 4. Verify Installation

```vim
:PackStatus          " Check all plugins installed
:checkhealth         " Run health checks
:LspInfo             " Verify LSP (after opening a file)
```

## New Commands

### Plugin Management

| Old (lazy.nvim) | New (vim.pack) |
|----------------|----------------|
| `:Lazy` | `:PackStatus` |
| `:Lazy update` | `:PackUpdate` |
| `:Lazy clean` | `:PackClean` |
| `:Lazy sync` | `:PackUpdate` |
| N/A | `:TSBootstrap` |

### LSP Configuration

**Old way** (deprecated):
```lua
local lspconfig = require('lspconfig')
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
```

**New way** (0.12+):
```lua
vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable("pyright")
```

## Adding New LSP Servers

Edit `~/.config/nvim/lua/plugins/lsp.lua`:

1. Define the server with `vim.lsp.config(name, config)`
2. Enable it with `vim.lsp.enable(name)`
3. Restart Neovim

Example servers are commented out in the file - uncomment and modify as needed.

## Performance Improvements

- **Faster startup**: No plugin manager overhead
- **Simpler**: Fewer abstractions, direct vim.pack usage
- **Modern**: Uses latest Neovim APIs (vim.lsp.config, vim.snippet)

## Troubleshooting

### "Plugin X not found"
Run `:PackStatus` to check installation, then `:PackUpdate`

### LSP errors about lspconfig
The old lspconfig framework is deprecated. The new config uses `vim.lsp.config` directly.
If you see warnings, check that `lua/plugins/lsp.lua` uses the new API.

### Plugins not loading
```vim
:PackStatus          " Check what's installed
:PackUpdate          " Update all plugins
```

Then restart Neovim.

### Treesitter not highlighting
```vim
:TSBootstrap         " Update parsers
:TSModuleInfo        " Check status
```

### Completion not working
Make sure nvim-cmp and its sources are installed:
```vim
:PackStatus | grep cmp
```

## Files Changed

### Removed
- `lua/config/lazy.lua` - lazy.nvim setup
- `lua/plugins/colorschemes.lua` - merged into plugins.lua
- `lua/plugins/editing.lua` - merged into plugins.lua
- `lua/plugins/ui.lua` - split into individual plugin files
- `lua/plugins/terminal.lua` - renamed to toggleterm.lua

### Added
- `lua/config/bootstrap.lua` - vim.pack bootstrap & commands
- `lua/config/plugins.lua` - central plugin loader

### Updated
- `init.lua` - new bootstrap flow
- `lua/plugins/lsp.lua` - uses vim.lsp.config API
- `lua/plugins/*.lua` - all use pcall guards for safety

## Rollback (if needed)

If you need to rollback to the lazy.nvim version:

```bash
cd ~/dotfiles/nvim/.config/nvim
git checkout HEAD~1  # Go back to previous commit
rm -rf ~/.local/share/nvim/site/pack/
nvim  # lazy.nvim will reinstall plugins
```

## Benefits of New Setup

✅ **Native**: Uses Neovim's built-in package manager
✅ **Simple**: ~150 lines of bootstrap code vs full plugin manager
✅ **Fast**: No lazy-loading overhead, plugins load at startup
✅ **Transparent**: You can see exactly what's happening
✅ **Future-proof**: Uses latest Neovim 0.12 APIs

## Questions?

- Check `:help vim.lsp.config`
- Check `:help packages`
- Run `:checkhealth` for diagnostics
- See README.md for full documentation
