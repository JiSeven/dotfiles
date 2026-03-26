-- 1. Setup Leader (Must be very first)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Declarative Packages (Nvim 0.12 native way)
vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.files" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/mofiqul/dracula.nvim",     name = "dracula" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

-- 3. Load core configurations
require("core.options")
require("core.keymaps")
