local map = vim.keymap.set

-- 1. Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- 2. Window & Buffer Management
map("n", "<leader>v", ":vsplit<CR>")
map("n", "<leader>s", ":split<CR>")
map("n", "<leader>b", ":ls<CR>:b ", { desc = "Search open buffers" })

-- Close buffer without breaking layout
map("n", "<leader>q", "<cmd>bp|sp|bn|bd<cr>", { desc = "Close buffer keep split" })

-- 3. Fast Escape
map("i", "jk", "<Esc>")
map("c", "jk", "<C-c>")

-- 4. File & Folder Creation (Relative to current file)
map("n", "<leader>n", ":e %:p:h/", { desc = "New file in current dir" })
map("n", "<leader>N", ":silent !mkdir -p %:p:h/", { desc = "New folder in current dir" })

-- 5. LSP Diagnostics (Modern API 0.11+)
map('n', '<leader>e', vim.diagnostic.open_float, { desc = "Line Diagnostic" })
map('n', '<leader>xx', vim.diagnostic.setqflist, { desc = "Project Diagnostics" })

-- 6. Search & Replace (Quickfix Way)
map("n", "<leader>gw", ":silent grep! <cword><CR>:copen<CR>", { desc = "Grep word under cursor" })
map("n", "<leader>gg", ":grep! ", { desc = "Manual grep search" })

-- Advanced replace: Pre-fills search term and places cursor for replacement
map("n", "<leader>gr",
    [[:cfdo %s/<C-r>///gc | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
    { desc = "Project replace" })

-- 7. Git Integration
map('n', '<leader>gd', ':vertical diffsplit !git show HEAD:%<CR>', { desc = "Git Diff Split" })

-- 8. Smart Tab Completion (LSP Omnifunc)
map('i', '<Tab>', function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
    end
    return vim.api.nvim_replace_termcodes('<C-x><C-o>', true, true, true)
end, { expr = true, replace_keycodes = false })
