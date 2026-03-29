return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"html",
		"javascriptreact",
		"typescriptreact",
		"css",
		"postcss",
		"sass",
		"scss",
		"less",
	},
	root_markers = {
		"tailwind.config.js",
		"tailwind.config.ts",
		"postcss.config.js",
		"package.json",
	},
	-- Настройки для автодополнения и цвета (в 0.12 это работает из коробки)
	settings = {
		tailwindCSS = {
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
			},
			experimental = {
				classRegex = {
					-- Если используешь библиотеки типа cva или tailwind-variants, добавь регексы сюда
				},
			},
		},
	},
}
