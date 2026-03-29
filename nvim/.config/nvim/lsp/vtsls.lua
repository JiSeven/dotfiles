return {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  settings = {
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      inlayHints = {
        parameterNames = { enabled = "all" },
      },
    },
  },
}
