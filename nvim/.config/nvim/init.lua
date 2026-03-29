-- Plugin management (Native package system)
vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
})
-- Core modules loading
require("core.options")
require("core.keymaps")
require("core.lsp")
require("core.theme")
require("modules.netrw")
require("modules.fzf")
require("modules.statusline")
require("modules.git")
require("autocmds")
