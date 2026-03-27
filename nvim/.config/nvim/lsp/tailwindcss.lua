return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html", "css", "scss", "javascript", "javascriptreact",
    "typescript", "typescriptreact"
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
  root_dir = vim.fs.root(0, {
    "tailwind.config.js",
    "tailwind.config.ts",
    "postcss.config.js",
    "package.json",
    ".git"
  }),
}
