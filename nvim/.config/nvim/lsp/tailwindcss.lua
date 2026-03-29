return {
  -- Имя бинарника (убедитесь, что он в PATH)
  cmd = { "tailwindcss-language-server", "--stdio" },

  -- Указываем типы файлов, где нужен Tailwind
  filetypes = { 
    "html", "javascriptreact", "typescriptreact", 
    "css", "scss", "sass", "javascript", "typescript" 
  },

  -- Маркеры, по которым сервер поймет, что это проект с Tailwind
  root_markers = { 
    "tailwind.config.js", "tailwind.config.ts", 
    "postcss.config.js", "package.json", ".git" 
  },

  -- Специфичные настройки для автодополнения внутри строк
  settings = {
    tailwindCSS = {
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        recommendedVariantOrder = "warning",
      },
      experimental = {
        classRegex = {
          -- Позволяет дополнять классы внутри функций cva или clsx (если используете)
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*)\"['`]" },
          { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
      validate = true,
    },
  },
}

