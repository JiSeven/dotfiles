require('lualine').setup {
	options = {
		theme = 'dracula',
		component_separators = '|',
    	section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_c = {
			{'filename', path = 1}
		},
	}
}
