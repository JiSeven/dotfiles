------------------------------------------------
--                                            --
--    This is a main configuation file for    --
--                    MyVim                  --
--      Change variables which you need to    --
--                                            --
------------------------------------------------

local icons = require('icons')

MyVim = {
  colorscheme = 'tokyonight', -- nightfly/tokyonight
  ui = {
    float = {
      border = 'rounded'
    }
  },
  plugins = {
    completion = {
      select_first_on_enter = false
    },
    package_info = {
      enabled = false
    },
  },
  icons = icons,
  statusline = {
    path_enabled = true,
    path = 'relative' -- absolute/relative
  }
}
