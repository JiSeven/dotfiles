local plugins = {
	-- UI & Theme
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

	-- Files & Navigation
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },

	-- LSP & Performance (Rust stack)
	{ src = "https://github.com/Saghen/blink.cmp", tag = "v1.10.1" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/williamboman/mason.nvim" },

	-- Git
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
}

vim.pack.add(plugins)

-- Базовая инициализация Mason для бинарников
require("mason").setup()
-- Инициализация Oil
require("oil").setup({
	default_file_explorer = true,
	-- Убираем флоат, чтобы открывался в текущем окне (на всю ширину)
	win_config = nil,
	view_options = {
		show_hidden = true,
	},
	skip_confirm_for_simple_edits = true,
	prompt_save_on_select_new_entry = false,
	keymaps = {
		-- Навигация в стиле Ranger/Yazi
		["h"] = "actions.parent", -- На уровень выше
		["l"] = "actions.select", -- Открыть файл или зайти в папку
		["<CR>"] = "actions.select", -- Оставляем Enter для выбора
		["<C-p>"] = false, -- Отключаем дефолтный превью, если мешает
		["<C-l>"] = false, -- Освобождаем для навигации между окнами
		["<C-h>"] = false,
	},
})

require("lualine").setup({
	options = {
		theme = "tokyonight",
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { statusline = { "dashboard", "alpha", "oil" } },
	},
	sections = {
		lualine_a = { {
			"mode",
		} },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			{ "filename", path = 1 },
		},
		lualine_x = {
			"encoding",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

require("blink.cmp").setup({
	keymap = { preset = "default" },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
})

require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "┆" },
	},
	signcolumn = true, -- Показать значки в левой колонке
	numhl = false, -- Не подсвечивать номера строк (слишком ярко)
	linehl = false, -- Не подсвечивать всю строку целиком
	word_diff = false, -- Не подсвечивать изменения внутри строки (шумно)

	-- Настройка всплывающего Blame (фишка для Fullstack командной разработки)
	current_line_blame = true, -- Показать кто изменил строку в конце (ghost text)
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- В конце строки
		delay = 500, -- Задержка появления (полсекунды)
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "   <author> • <author_time:%Y-%m-%d> • <summary>",
})

require("mini.pairs").setup({})
require("mini.surround").setup({})
