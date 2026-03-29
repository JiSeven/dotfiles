vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("plugins")

require("config.options")
require("config.keymaps")
require("config.autocmds")

require("config.lsp")

vim.cmd.colorscheme("tokyonight-night")
