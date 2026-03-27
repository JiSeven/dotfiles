vim.lsp.enable({ "lua_ls", "vtsls", "tailwindcss", "biome" })

local map = vim.keymap.set
local sev = vim.diagnostic.severity

-- Custom background highlights for errors and warnings
local colors = { err = "#31101A", warn = "#2B2B1B", info = "#1F2332", hint = "#1E231E" }
vim.api.nvim_set_hl(0, "DiagnosticErrorLine", { bg = colors.err })
vim.api.nvim_set_hl(0, "DiagnosticWarnLine", { bg = colors.warn })

vim.diagnostic.config({
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = { border = "rounded", source = "if_many" },
  virtual_text = { spacing = 4, prefix = "●" },
  -- 0.12 Native line highlighting
  linehl = {
    [sev.ERROR] = "DiagnosticErrorLine",
    [sev.WARN] = "DiagnosticWarnLine",
  },
  signs = {
    text = { [sev.HINT] = "  ", [sev.ERROR] = "✘", [sev.WARN] = "▲" },
  },
})

-- Global diagnostic keymaps
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
-- Jumping: Now with auto-open float window
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next Diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev Diagnostic" })
map("n", "]e", function() vim.diagnostic.jump({ count = 1, severity = sev.ERROR, float = true }) end,
  { desc = "Next Error" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = sev.ERROR, float = true }) end,
  { desc = "Prev Error" })

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions and highlights',
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local caps = client.server_capabilities

    -- Enable native LSP omnifunc
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    if client.server_capabilities.completionProvider then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    local bmap = function(mode, lhs, rhs, desc)
      map(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
    end

    -- NAVIGATION & INFO
    bmap('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    bmap('n', 'gr', vim.lsp.buf.references, 'Show references')
    bmap('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
    bmap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')

    -- REFACTORING
    bmap('n', 'rn', vim.lsp.buf.rename, 'Rename symbol')
    bmap({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')

    -- FORMATTING (Native 0.12)
    if caps.documentFormattingProvider then
      if client.name == "vtsls" then
        local biome_active = #vim.lsp.get_clients({ name = "biome", bufnr = bufnr }) > 0
        if biome_active then
          client.server_capabilities.documentFormattingProvider = false
        end
      end

      bmap('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, 'Format')

      -- Auto-format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = false })
        end,
      })
    end

    -- MODERN FEATURES (Inlay Hints)
    if caps.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      bmap('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
      end, 'Toggle Inlay Hints')
    end

    -- CODELENS (Automatic in 0.12)
    if caps.codeLensProvider then
      bmap('n', '<leader>cl', vim.lsp.codelens.run, 'Run CodeLens')
    end
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  desc = "Show diagnostics on cursor hold",
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
      scope = "cursor",
      header = "",
      prefix = "",
    })
  end,
})
