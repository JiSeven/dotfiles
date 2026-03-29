-- 1. LSP-related Events (Attach behavior)
vim.api.nvim_create_autocmd('LspAttach', {
    desc = "Setup buffer-local LSP settings on attach",
    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- Global LSP Mappings
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

        -- Link completion to LSP Omnifunc
        if client and client:supports_method('textDocument/completion', args.buf) then
            vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        end

        -- Enable Inlay Hints if supported
        if client and client:supports_method('textDocument/inlayHint', args.buf) then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end

        -- Auto-format on save if server supports it
        if client and client:supports_method('textDocument/formatting', args.buf) then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, async = false })
                end,
            })
        end
    end,
})

-- 2. Diagnostic & UI Tweaks
-- Show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

-- Highlight text on yank (copy)
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Visual feedback on copy",
    callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})

-- 3. Specialized Buffer Behavior (Quickfix, Help, etc.)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf" },
    callback = function(event)
        -- Quickfix specific: delete items with 'dd'
        if event.match == "qf" then
            vim.keymap.set("n", "dd", function()
                local qflist = vim.fn.getqflist()
                local line = vim.fn.line(".")
                table.remove(qflist, line)
                vim.fn.setqflist(qflist, 'r')
                vim.fn.setpos(".", { 0, line, 1, 0 })
            end, { buffer = event.buf, desc = "Delete item from Quickfix" })
        end
    end,
})

-- 4. File Management & Grep
-- Auto-open quickfix after :grep
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "grep",
    command = "cwindow",
})

-- Automatically create missing parent directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Ensure directory exists before saving",
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then return end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":h"), "p")
    end,
})
