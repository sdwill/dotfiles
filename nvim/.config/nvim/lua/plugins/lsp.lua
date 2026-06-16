-- LSP configuration using new vim.lsp.config API (Neovim 0.11+)
-- See :help lspconfig-nvim-0.11

-- Setup completion capabilities
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.lsp.protocol.make_client_capabilities()
if has_cmp then
  capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
end

-- Common on_attach function for all LSP servers
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  -- Keymaps
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  -- Diagnostic keymaps
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- LSP server configurations using vim.lsp.config
-- See :help vim.lsp.config for available options

-- Example: Lua language server (commented out by default)
-- Uncomment if you want Lua LSP and have lua-language-server installed
-- Install: brew install lua-language-server (or via MacPorts/other)
--
-- vim.lsp.config("lua_ls", {
--   cmd = { "lua-language-server" },
--   filetypes = { "lua" },
--   root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     Lua = {
--       runtime = {
--         version = "LuaJIT",
--       },
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true),
--         checkThirdParty = false,
--       },
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- })
-- vim.lsp.enable("lua_ls")

-- Add more language servers here following the same pattern:
-- 1. Define with vim.lsp.config(name, config_table)
-- 2. Enable with vim.lsp.enable(name)

-- Example: Python (pyright)
-- First install: pip install pyright
-- vim.lsp.config("pyright", {
--   cmd = { "pyright-langserver", "--stdio" },
--   filetypes = { "python" },
--   root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     python = {
--       analysis = {
--         autoSearchPaths = true,
--         useLibraryCodeForTypes = true,
--         diagnosticMode = "workspace",
--       },
--     },
--   },
-- })
-- vim.lsp.enable("pyright")

-- Example: TypeScript/JavaScript (tsserver)
-- First install: npm install -g typescript-language-server typescript
-- vim.lsp.config("ts_ls", {
--   cmd = { "typescript-language-server", "--stdio" },
--   filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
--   root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
-- vim.lsp.enable("ts_ls")

-- Example: Rust (rust-analyzer)
-- First install: rustup component add rust-analyzer
-- vim.lsp.config("rust_analyzer", {
--   cmd = { "rust-analyzer" },
--   filetypes = { "rust" },
--   root_markers = { "Cargo.toml", "rust-project.json" },
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
-- vim.lsp.enable("rust_analyzer")
