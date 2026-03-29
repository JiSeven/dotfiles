return {
  cmd = { "lua-language-server" }, 
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git", "init.lua" },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT', -- Neovim uses LuaJIT
      },
      diagnostics = {
        globals = { 'vim' }, -- Stop 'undefined global vim' warnings
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

