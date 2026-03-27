local dracula = require("dracula")

dracula.setup({
  -- Customization (optional)
  colors = {
    bg = "#282A36",
    fg = "#F8F8F2",
    selection = "#44475A",
    comment = "#6272A4",
    red = "#FF5555",
    pink = "#FF79C6",
  },
  transparent_bg = false, -- Set to true if your terminal has its own wallpaper
  italic_comment = true,
})

-- Apply the theme
vim.cmd([[colorscheme dracula]])

-- ═══════════════════════════════════════════════════════════
-- FIXING OUR STATUSLINE COLORS FOR DRACULA
-- ═══════════════════════════════════════════════════════════
-- Чтобы наш нативный статуслайн сочетался с темой
vim.api.nvim_set_hl(0, "StatusLineMode", { fg = "#282A36", bg = "#BD93F9", bold = true })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#44475A", fg = "#F8F8F2" })
