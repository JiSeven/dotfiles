local utils = require('utils')

local on_attach = function(client, bufnr)
    utils.buf_map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    utils.buf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    utils.buf_map(bufnr, "n", "<c-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
    utils.buf_map(bufnr, "n", "<c-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>")
    utils.buf_map(bufnr, "n", "<Leader>a", "<cmd>lua vim.diagnostic.open_float()<cr>")
    utils.buf_map(bufnr, "i", "<C-x><C-x>", "<cmd>lua vim.diagnostic.signature_help()<cr>")

    utils.buf_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
    utils.buf_map(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
    utils.buf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
    utils.buf_map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
    utils.buf_map(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    utils.buf_map(bufnr, "v", "ga", "<Esc><cmd>lua vim.lsp.buf.range_code_action()<cr>")

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    filter = function(client)
                        return client.name == "null-ls"
                    end
                })
            end
        })
    end

    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
    end

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for _, server in ipairs({'null-ls', 'tsserver'}) do
    require("lsp." .. server).setup(on_attach, capabilities)
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
