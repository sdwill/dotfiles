# Migration Guide

## How to Switch to the New Config

### Current State
Your old configuration is in:
- `/Users/swill/dotfiles/vim/.vimrc`
- `/Users/swill/dotfiles/vim/.vim/`
- `/Users/swill/dotfiles/nvim/.config/nvim/init.vim` (just sources .vimrc)

### New Configuration Location
The new modern config is in:
- `/Users/swill/dotfiles/nvim/.config/nvim/` (all Lua files)

### Steps to Migrate

1. **Backup your current config** (already done - your old files are untouched)

2. **Test the new config**:
   ```bash
   # The new config is already in place at ~/.config/nvim/
   # Just launch nvim:
   nvim
   ```

3. **First launch**:
   - lazy.nvim will auto-install
   - All plugins will be downloaded
   - This takes 1-2 minutes
   - You'll see a progress window

4. **After installation completes**:
   - Close and reopen Neovim
   - Everything should work!

5. **Update Treesitter parsers** (if needed):
   ```vim
   :TSUpdate
   ```

6. **Check plugin status**:
   ```vim
   :Lazy
   ```

### If You Want to Keep Both Configs

The old config uses `~/.vim/` and the new one uses `~/.config/nvim/`, so they don't conflict.

To use the **old config**: `vim` (or create an alias)
To use the **new config**: `nvim`

### If You Want to Remove the Old Config

Once you're happy with the new setup:

```bash
# Remove old vim config
rm -rf ~/dotfiles/vim/.vim/
rm ~/dotfiles/vim/.vimrc

# Update the nvim symlink if needed
# (your dotfiles stow setup should already handle this)
```

## Differences to Note

### Plugin Management
- **Old**: `:PlugInstall`, `:PlugUpdate`, `:PlugClean`
- **New**: `:Lazy` (does everything)

### Snippets
- No more LuaSnip
- LSP servers provide snippets automatically
- Tab/Shift-Tab to navigate snippet fields

### Configuration Files
- No more `.vimrc`
- Everything is Lua in `~/.config/nvim/lua/`
- Each plugin has its own file

### Removed VSCode Checks
All `if !exists('g:vscode')` checks are gone - this is a pure Neovim config now.

### To Add LSP Servers

1. Install the language server:
   ```bash
   # Python example
   pip install pyright
   
   # JavaScript/TypeScript example  
   npm install -g typescript-language-server
   ```

2. Add to `~/.config/nvim/lua/plugins/lsp.lua`:
   ```lua
   lspconfig.pyright.setup({
     capabilities = capabilities,
     on_attach = on_attach,
   })
   ```

3. Restart Neovim

## Troubleshooting

### Plugins not loading
Run `:Lazy install` then restart Neovim

### LSP not working
1. Check if server is installed: `:LspInfo`
2. Add server config to `lua/plugins/lsp.lua`
3. Restart Neovim

### Treesitter syntax highlighting issues
Run `:TSUpdate` to update parsers

### Completion not working
1. Make sure you're in insert mode
2. Start typing - completion should appear automatically
3. Use `<C-Space>` to manually trigger

### Can't find a keymap
Run `<leader>` and wait - which-key will show you available mappings

## Getting Help

- Lazy.nvim docs: `:help lazy.nvim`
- Check plugin status: `:Lazy`
- Neovim health check: `:checkhealth`
- LSP status: `:LspInfo`
- Treesitter status: `:TSModuleInfo`
