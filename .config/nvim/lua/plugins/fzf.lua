local utils = require("utils")

require('fzf-lua').setup({
	winopts = {
		width = 0.5,
		preview = {
			layout = 'vertical',
			vertical = 'down:65%'
		},
		hl = { border = "FloatBorder" }
	}
})

utils.nmap("<Leader>ff", ":FzfLua files<CR>")
utils.nmap("<Leader>fs", ":FzfLua live_grep_glob<CR>")
