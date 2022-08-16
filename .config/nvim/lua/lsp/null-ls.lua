local null_ls = require("null-ls")

local M = {}

M.setup = function(on_attach)
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local sources = {null_ls.builtins.formatting.prettierd, null_ls.builtins.diagnostics.eslint_d,
                     null_ls.builtins.diagnostics.stylelint}

    null_ls.setup({
        debug = false,
        on_attach = on_attach,
        sources = sources
    })
end

return M
