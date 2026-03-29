return {
  -- Команда запуска сервера (убедитесь, что установлен: npm i -g vscode-langservers-extracted)
  cmd = { 'vscode-css-language-server', '--stdio' },
  
  -- Типы файлов, которые будет обслуживать этот конфиг
  filetypes = { "css", "scss", "less" },
  
  -- Маркеры для определения корня проекта
  root_markers = { "package.json", ".git" },
  
  -- Специфичные настройки сервера
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore" -- полезно, если используете Tailwind (@tailwind)
      }
    },
    scss = { validate = true },
    less = { validate = true },
  },
}

