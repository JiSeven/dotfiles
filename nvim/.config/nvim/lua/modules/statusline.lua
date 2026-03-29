require('lualine').setup({
    options = {
        theme = 'tokyonight', -- Automatic sync with your theme
        -- component_separators = { left = '│', right = '│' },
        -- section_separators = { left = '', right = '' }, -- No bulky arrows, clean VS Code look
        globalstatus = true, -- One statusline for all splits (Neovim 0.11+ feature)
        -- disabled_filetypes = { statusline = { 'netrw', 'fzf' } },
    },
    -- sections = {
    --     lualine_a = { 'mode' },
    --     lualine_b = { { 'branch', icon = ' ' }, { 'diff', symbols = { added = '+', modified = '~', removed = '-' } } },
    --     lualine_c = { { 'filename', path = 1 } }, -- 1: relative path (important for web)
    --     lualine_x = {
    --         { 'diagnostics', sources = { 'nvim_diagnostic' }, symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
    --         'filetype'
    --     },
    --     lualine_y = { 'progress' },
    --     lualine_z = { 'location' }
    -- },
    -- inactive_sections = {
    --     lualine_a = {},
    --     lualine_b = {},
    --     lualine_c = { 'filename' },
    --     lualine_x = { 'location' },
    --     lualine_y = {},
    --     lualine_z = {}
    -- },
})
