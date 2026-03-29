require("tokyonight").setup({
    style = "night",
    transparent = true, -- Это критично: Neovim просвечивает WezTerm
    on_highlights = function(hl, c)
        -- 1. Сливаем фон колонок с фоном терминала (WezTerm)
        hl.SignColumn = { bg = "none" }
        hl.LineNr = { fg = c.dark3, bg = "none" }
        hl.CursorLineNr = { fg = c.magenta, bg = "none", bold = true }

        -- 2. Убираем разделители окон, чтобы всё было единым пространством
        hl.WinSeparator = { fg = c.border_highlight, bg = "none" }

        -- 3. Подсветка текущей строки — только легкий налет, без жирных полос
        hl.CursorLine = { bg = c.bg_highlight }

        -- 4. Чтобы Floating windows (FZF/LSP) были читаемы на прозрачном фоне
        hl.NormalFloat = { bg = c.bg_dark }
        hl.FloatBorder = { fg = c.blue0, bg = "none" }
    end,
})

vim.cmd.colorscheme "tokyonight"
