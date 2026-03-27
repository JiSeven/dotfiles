local map = vim.keymap.set

-- Disable Space in Normal/Visual mode to prevent cursor jumps
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- =============================================================================
-- SMART NAVIGATION (Neovim + WezTerm)
-- =============================================================================

-- Seamlessly switch between Neovim splits and WezTerm panes
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- =============================================================================
-- WINDOW & BUFFER MANAGEMENT
-- =============================================================================

-- Splits
map("n", "<leader>v", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>s", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>x", "<C-w>c", { desc = "Close window" })
map("n", "<leader>ww", "<C-w>p", { desc = "Jump to previous window" })

-- Resizing (Ctrl + Shift + Arrows)
map("n", "<C-S-Up>", "<cmd>resize +2<CR>", { desc = "Increase height" })
map("n", "<C-S-Down>", "<cmd>resize -2<CR>", { desc = "Decrease height" })
map("n", "<C-S-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-S-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })

-- Buffers
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Last buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- =============================================================================
-- SEARCH & QUICKFIX
-- =============================================================================

map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })

-- Fzf-lua shortcuts
map("n", "<c-p>", "<cmd>FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", { desc = "Grep project" })
map("n", "<leader>,", "<cmd>FzfLua buffers<cr>", { desc = "Switch buffers" })
map("n", "<leader>fr", "<cmd>FzfLua resume<cr>", { desc = "Resume search" })

-- Quickfix toggle & navigation
map("n", "[q", "<cmd>cprev<cr>", { desc = "Prev Quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next Quickfix" })
map("n", "<leader>q", function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then qf_exists = true end
  end
  if qf_exists then vim.cmd("cclose") else vim.cmd("copen") end
end, { desc = "Toggle Quickfix" })

-- =============================================================================
-- SNIPPETS & COMPLETION (Native 0.12)
-- =============================================================================

-- Snippet placeholder navigation
map({ "i", "s" }, "<C-l>", function()
  return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1) or "<C-l>"
end, { expr = true, desc = "Next snippet placeholder" })

map({ "i", "s" }, "<C-h>", function()
  return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1) or "<C-h>"
end, { expr = true, desc = "Prev snippet placeholder" })

-- Native PUM (Popup Menu) navigation
map("i", "<Tab>", function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>" end, { expr = true })
map("i", "<S-Tab>", function() return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>" end, { expr = true })
map("i", "<CR>", function() return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>" end, { expr = true })

-- =============================================================================
-- UTILS & EXPLORER
-- =============================================================================

map("n", "<leader>z", "zMzvzz", { desc = "Focus current fold" })
map("n", "<leader><Tab>", "za", { desc = "Toggle fold" })
map("n", "<leader>w", "<cmd>setlocal wrap!<CR>", { desc = "Toggle wrap" })
map("n", "z=", "1z=", { desc = "Auto-fix spelling" })

map("n", "-", function()
  local mini_files = require("mini.files")
  if not mini_files.close() then
    mini_files.open(vim.api.nvim_buf_get_name(0))
  end
end, { desc = "Toggle File Explorer" })
