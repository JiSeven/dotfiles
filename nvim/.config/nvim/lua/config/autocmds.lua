local group = vim.api.nvim_create_augroup("NativeAutocmds", { clear = true })

require("conform").setup({
  formatters_by_ft = {
    -- Biome поддерживает почти всё во фронтенде
    javascript = { "biome" },
    typescript = { "biome" },
    javascriptreact = { "biome" },
    typescriptreact = { "biome" },
    json = { "biome" },
    lua = { "stylua" },
  },
})

-- Автоформат при сохранении
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  callback = function(args)
    require("conform").format({ bufnr = args.buf, lsp_fallback = true })
  end,
})
