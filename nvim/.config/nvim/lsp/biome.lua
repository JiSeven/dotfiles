return {
  cmd = { "biome", "lsp-proxy" },
  filetypes = {
    "javascript", "javascriptreact", "typescript",
    "typescriptreact", "json", "jsonc", "css"
  },
  -- Указываем Biome искать свой конфиг biome.json
  root_dir = vim.fs.root(0, { "biome.json", "biome.jsonc", "package.json", ".git" }),
}
