local gs = require("gitsigns")

local map = vim.keymap.set
-- 1. Лидер уже задан в init.lua, здесь только бинды

-- 2. Перемещение между окнами (Native feel)
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- 3. Работа с буферами (Tab-style)
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>x", "<cmd>confirm bd<cr>", { desc = "Close Buffer" })

-- 4. Файловый менеджер Oil (Твой "Native" проводник)
map("n", "-", "<CMD>Oil<CR>", { desc = "Open Parent Directory (Floating)" })
map("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open Oil (Current Window)" })

-- 5. Поиск (Telescope)
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Grep Project" })
map("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })

-- 6. Редактирование и UX
map("i", "jk", "<Esc>", { desc = "Fast Escape" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })

-- Умная очистка поиска при ESC
map("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Escape and Clear hlsearch" })

-- 7. Fullstack Utilities
-- Центрирование экрана при скролле (очень удобно при чтении длинных логов/кода)
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Перемещение выделенных строк (Alt+j / Alt+k) - мастхэв для рефакторинга
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- 8. LSP Diagnostics (Глобальные)
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- Навигация по изменениям (Hunks)
vim.keymap.set("n", "]c", function()
	if vim.wo.diff then
		return "]c"
	end
	vim.schedule(function()
		gs.next_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "Next Git Change" })

vim.keymap.set("n", "[c", function()
	if vim.wo.diff then
		return "[c"
	end
	vim.schedule(function()
		gs.prev_hunk()
	end)
	return "<Ignore>"
end, { expr = true, desc = "Prev Git Change" })

-- Действия с кодом
vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk" })
vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Change (Popup)" })
vim.keymap.set("n", "<leader>gb", function()
	gs.blame_line({ full = true })
end, { desc = "Git Blame Full" })
vim.keymap.set("n", "<leader>gd", gs.diffthis, { desc = "Git Diff (Split view)" })
