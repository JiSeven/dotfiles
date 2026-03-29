vim.g.mapleader = " "

local opt = vim.opt

-- 1. UI & Appearance
opt.number = true         -- Show absolute line number
opt.relativenumber = true -- Show relative line numbers for jumps
opt.cursorline = true     -- Highlight the text line under the cursor
opt.signcolumn = "yes"    -- Always show the sign column (prevent shifts)
opt.scrolloff = 8         -- Minimal number of screen lines to keep above/below
opt.guicursor = "a:block" -- Keep cursor as a block in all modes
opt.pumheight = 10        -- Limit completion menu height
opt.termguicolors = true  -- Enable 24-bit RGB color (standard for modern themes)

-- 2. Behavior & Timings
opt.timeoutlen = 300                        -- Time to wait for a mapped sequence to complete
opt.updatetime = 300                        -- Faster completion and diagnostic popup response
opt.undofile = true                         -- Save undo history to a file
opt.formatoptions:remove({ "c", "r", "o" }) -- Stop auto-commenting on new lines

-- 3. Indentation & Tabs
opt.tabstop = 4      -- Number of spaces that a <Tab> counts for
opt.shiftwidth = 4   -- Number of spaces to use for each step of indent
opt.expandtab = true -- Use spaces instead of tabs

-- 4. Splits & Search
opt.splitright = true -- Put new vertical splits to the right
opt.splitbelow = true -- Put new horizontal splits below
opt.hlsearch = false  -- Clear search highlights after executing search
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true  -- Override 'ignorecase' if search contains capitals

-- 5. Completion (Built-in Omnifunc)
-- menuone: popup even for 1 match, noinsert: don't insert text until selection
opt.completeopt = { "menu", "menuone", "noinsert" }

-- 6. Built-in File Navigation & Grep
opt.path:append("**") -- Recursive search for :find
opt.wildignore:append({ "**/node_modules/**", "**/.git/**", "**/dist/**", "*.pyc" })

-- Use Ripgrep for :grep if available
if vim.fn.executable("rg") == 1 then
    opt.grepprg = "rg --vimgrep --smart-case --no-heading"
    opt.grepformat = "%f:%l:%c:%m"
end
