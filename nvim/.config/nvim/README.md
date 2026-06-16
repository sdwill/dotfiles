# Modern Neovim Configuration

This is a minimal, modern Neovim configuration using **native vim.pack** package manager and the new **vim.lsp.config** API.

Compatible with **Neovim 0.12+**

## Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── config/
│   │   ├── bootstrap.lua       # Plugin installation & management
│   │   ├── options.lua         # General Neovim options
│   │   ├── keymaps.lua         # Key mappings
│   │   ├── autocmds.lua        # Autocommands
│   │   └── plugins.lua         # Plugin loader
│   └── plugins/
│       ├── lsp.lua             # LSP with vim.lsp.config
│       ├── completion.lua      # nvim-cmp with native vim.snippet
│       ├── treesitter.lua      # Treesitter config
│       ├── telescope.lua       # Fuzzy finder
│       ├── lualine.lua         # Status line
│       ├── which-key.lua       # Keybinding hints
│       ├── todo-comments.lua   # TODO highlighting
│       ├── zen-mode.lua        # Distraction-free mode
│       ├── toggleterm.lua      # Terminal management
│       └── autosave.lua        # Auto-save
├── README.md                   # This file
└── CHEATSHEET.md              # Quick reference
```

## First Run

On first launch, the bootstrap script will automatically:
1. Create the plugin directory
2. Clone all configured plugins via git
3. Generate helptags

Just run `nvim` and wait ~30 seconds for plugins to install.

## Plugin Management Commands

All plugin management is done via custom commands:

- **`:PackStatus`** - Show installed plugins and their status
- **`:PackUpdate`** - Update all plugins to latest version
- **`:PackClean`** - Remove unused plugins
- **`:TSBootstrap`** - Install/update Treesitter parsers

No external plugin manager needed - everything uses Neovim's built-in `vim.pack`!

## Key Changes from 0.11

### Native Package Manager
- **Old**: lazy.nvim (`:Lazy` commands)
- **New**: Built-in vim.pack (`:Pack*` commands)
- Plugins installed to `~/.local/share/nvim/site/pack/plugins/start/`

### LSP Configuration
- **Old**: `require('lspconfig').server.setup()`
- **New**: `vim.lsp.config(name, config)` + `vim.lsp.enable(name)`
- See `:help lspconfig-nvim-0.11` for migration details

### Snippets
- Native `vim.snippet` (Neovim 0.10+)
- LSP servers provide snippets automatically
- Tab/Shift-Tab to navigate snippet fields

## Adding LSP Servers

1. **Install the language server**:
   ```bash
   # Python example
   pip install pyright
   
   # JavaScript/TypeScript example  
   npm install -g typescript-language-server typescript
   
   # Rust example
   rustup component add rust-analyzer
   ```

2. **Configure in `lua/plugins/lsp.lua`**:
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

3. **Restart Neovim**

## Installed Plugins (24 total)

### Core Editing
- vim-surround - Manipulate surrounding quotes/brackets
- vim-obsession - Session management

### LSP & Completion
- nvim-lspconfig - LSP configuration helpers
- nvim-cmp - Completion engine
- cmp-nvim-lsp, cmp-buffer, cmp-path, cmp-cmdline - Completion sources

### Treesitter
- nvim-treesitter - Better syntax highlighting

### Navigation
- plenary.nvim - Lua utilities (required by Telescope)
- telescope.nvim - Fuzzy finder
- telescope-file-browser.nvim - File browser extension

### UI
- lualine.nvim - Status line
- vim-startify - Start screen
- which-key.nvim - Keybinding hints
- nvim-web-devicons - File icons
- taboo.vim - Custom tab names

### Features
- todo-comments.nvim - TODO highlighting
- zen-mode.nvim - Distraction-free mode
- nvim-toggleterm.lua - Terminal management
- auto-save.nvim - Auto-save files

### Color Schemes
- everforest (default)
- edge
- sonokai
- tokyonight
- kanagawa

## Color Schemes

To switch themes:
```vim
:colorscheme tokyonight
```

Or edit `lua/config/plugins.lua` to change the default.

## Key Mappings

All the same as before:
- `<leader>` = Space
- `<localleader>` = Comma
- `<leader>w` = Save
- `<leader>q` = Quit
- `<leader>g` = Zen mode
- `<C-p>` = Find files (git-aware)
- `<C-f>` = Live grep
- `<leader><Space>` = Telescope menu
- `<leader>fb` = Browse buffers
- `<leader>fc` = Browse commands
- `<c-\>` = Toggle terminal
- See [CHEATSHEET.md](CHEATSHEET.md) for complete list

## Troubleshooting

### Plugins not loading
Run `:PackStatus` to check installation, then `:PackUpdate` if needed

### LSP not working
1. Check server is installed: `:LspInfo`
2. Verify config in `lua/plugins/lsp.lua`
3. Check server is enabled: `vim.lsp.enable("server_name")`
4. Restart Neovim

### Treesitter syntax highlighting issues
Run `:TSBootstrap` (alias for `:TSUpdate`)

### Completion not working
1. Make sure you're in insert mode
2. Start typing - completion appears automatically
3. Use `<C-Space>` to manually trigger

## Health Checks

- `:checkhealth` - Check Neovim installation
- `:LspInfo` - Show LSP client info
- `:TSModuleInfo` - Show Treesitter status

## Philosophy

This config follows modern Neovim best practices:
- ✅ **Native** - Uses built-in vim.pack and vim.lsp.config
- ✅ **Minimal** - Only essential plugins (24 total)
- ✅ **Pure Lua** - No VimScript
- ✅ **Modular** - Easy to understand and modify
- ✅ **Current** - Compatible with Neovim 0.12+
- ✅ **Fast** - No plugin manager overhead

Enjoy your clean, modern Neovim setup! 🎉
