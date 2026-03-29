-- Neovim 0.12 сам подцепит этот файл
return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  settings = {
    -- Тут можно крутить настройки специфичные для TS
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
    },
  },
}

