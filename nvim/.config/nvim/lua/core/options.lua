local opt = vim.opt

-- Appearance and navigation
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Relative line numbers for easier jumping
opt.cursorline = true     -- Highlight the line with the cursor
opt.wrap = false          -- Disable line wrapping
opt.scrolloff = 10        -- Keep 10 lines of context above/below cursor
opt.sidescrolloff = 8     -- Keep 8 columns of context left/right of cursor
opt.smoothscroll = true   -- Enable smooth scrolling (native in recent versions)

-- Indentation
opt.tabstop = 2       -- Number of spaces a tab counts for
opt.shiftwidth = 2    -- Size of an indent
opt.expandtab = true  -- Use spaces instead of tabs
opt.shiftround = true -- Round indent to multiple of shiftwidth

-- Search
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true  -- Case-sensitive if search contains uppercase
opt.hlsearch = false  -- Do not keep search results highlighted

-- Interface and System
opt.signcolumn = "yes" -- Always show the sign column to prevent layout shifts
opt.undofile = true    -- Persistent undo (Nvim handles directory automatically)
opt.updatetime = 300   -- Delay before triggering CursorHold
opt.timeoutlen = 300   -- Time to wait for a mapped sequence to complete
opt.mouse = "a"        -- Enable mouse support
opt.confirm = true     -- Confirm to save changes before exiting

-- Editing behavior
opt.virtualedit = "block"      -- Allow cursor to move past end of line in visual block mode
opt.iskeyword:append("-")      -- Treat dash-separated words as a single word
opt.formatoptions = "jcroqlnt" -- Smart auto-formatting of comments and text
vim.opt.breakindent = true

-- Advanced display settings
opt.list = true -- Show invisible characters (tabs, etc.)
opt.fillchars = {
  foldopen = " ",
  foldclose = " ",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ", -- Hide the tildes (~) at the end of buffer
}

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99 -- Начинаем с открытыми фолдами

-- Native Filetype API
vim.filetype.add({
  extension = {
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})

-- Better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.opt.pumheight = 10 -- Limit popup menu height
