-- 1. Native LSP Activation
-- Scans ~/.config/nvim/lsp/*.lua and enables them
local lsp_path = vim.fn.stdpath("config") .. "/lsp"
local files = vim.fn.globpath(lsp_path, "*.lua", false, true)

if #files > 0 then
    for _, file in ipairs(files) do
        local server_name = vim.fn.fnamemodify(file, ":t:r")
        vim.lsp.enable(server_name)
    end
end

-- 2. Diagnostic Configuration
vim.diagnostic.config({
    virtual_text = false,     -- Disable noisy text at the end of the line
    signs = true,             -- Show icons in the gutter
    underline = true,         -- Underline erroneous code
    update_in_insert = false, -- Only update diagnostics when leaving insert mode
    severity_sort = true,     -- Order diagnostics by severity
    float = {
        border = 'rounded',   -- Use rounded borders for popups
        source = true,        -- Show LSP server name (e.g. vtsls)
        focusable = false,    -- Don't focus the float when it appears
    },
})

-- 3. Diagnostic Gutter Signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
