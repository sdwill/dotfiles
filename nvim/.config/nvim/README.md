# Modern Neovim Configuration

This is a minimal, modern Neovim configuration using Lua and the lazy.nvim plugin manager.

## Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── config/
│   │   ├── options.lua         # General Neovim options
│   │   ├── keymaps.lua         # Key mappings
│   │   ├── autocmds.lua        # Autocommands
│   │   └── lazy.lua            # lazy.nvim setup
│   └── plugins/
│       ├── colorschemes.lua    # Color schemes
│       ├── editing.lua         # Editing utilities (surround, obsession)
│       ├── treesitter.lua      # Treesitter config
│       ├── lsp.lua             # LSP configuration
│       ├── completion.lua      # nvim-cmp with native vim.snippet
│       ├── telescope.lua       # Fuzzy finder
│       ├── telescope_utils.lua # Telescope helper functions
│       ├── ui.lua              # UI plugins (lualine, startify, which-key, etc.)
│       ├── todo-comments.lua   # TODO highlighting
│       ├── zen-mode.lua        # Distraction-free mode
│       ├── terminal.lua        # Terminal management
│       └── autosave.lua        # Auto-save
└── README.md                   # This file
```

## First Run

On first launch, lazy.nvim will automatically:
1. Install itself
2. Install all configured plugins
3. Set up Treesitter parsers

Just run `nvim` and wait for plugins to install.

## Plugin Management

- **Install/Update plugins**: `:Lazy` then press `U` to update all
- **Install missing plugins**: `:Lazy install`
- **Remove unused plugins**: `:Lazy clean`
- **Check plugin status**: `:Lazy`

## Key Changes from Old Config

### Package Manager
- **Old**: vim-plug (`:PlugInstall`, `:PlugUpdate`)
- **New**: lazy.nvim (`:Lazy` for everything)

### Snippets
- **Old**: LuaSnip plugin
- **New**: Native `vim.snippet` (Neovim 0.10+)
  - LSP servers still provide snippets
  - Use `<Tab>` to jump forward, `<Shift-Tab>` to jump back

### LSP
- Removed deprecated `nvim-lsp-installer`
- To add LSP servers, edit `lua/plugins/lsp.lua`
- Install LSP servers manually (e.g., via `mason.nvim` if you add it, or system package manager)

### File Structure
- All config is now in `~/.config/nvim/` (not `~/.vim/`)
- Everything is Lua (no more `.vimrc` or `.vim` files)
- Each plugin has its own file in `lua/plugins/`

## Adding New Plugins

1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/myplugin.lua`)
2. Add plugin spec:

```lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy", -- or cmd = "Command", or keys = {...}
    opts = {
      -- plugin options
    },
  },
}
```

3. Restart Neovim or run `:Lazy reload`

## Color Schemes

Available themes (all lazy-loaded except everforest):
- `everforest` (default, soft background)
- `edge`
- `sonokai`
- `tokyonight`
- `kanagawa`

To switch: `:colorscheme tokyonight` (or edit `lua/plugins/colorschemes.lua`)

## LSP Servers

The config includes an example Lua LSP setup. To add more servers:

1. Install the LSP server (e.g., `npm install -g pyright` for Python)
2. Edit `lua/plugins/lsp.lua` and add:

```lua
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
```

## Key Mappings

All the same as before, plus:
- `<leader><Space>` - Telescope main menu
- `<C-p>` - Find files (git-aware)
- `<C-f>` - Live grep
- `<leader>fb` - Browse buffers
- `<leader>fc` - Browse commands
- `<leader>g` - Zen mode
- `<c-\>` - Toggle terminal

## Removed Features

- VSCode-specific checks (removed)
- vim-fugitive (Git integration - can add back if needed)
- All writing plugins except todo-comments (pandoc, vimtex, bullets, etc.)
- Ranger integration
- vim-sneak, vim-commentary, vim-easy-align, close-buffers, vim-maximizer
- 18+ unused color schemes

## Total Plugins: 24

Down from 50+ in the old config!
