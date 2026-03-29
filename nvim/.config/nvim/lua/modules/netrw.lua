-- ========================================================================== --
--                                NETRW SETUP                                 --
-- ========================================================================== --

-- 1. General Configuration
vim.g.netrw_banner = 0                -- Hide help banner
vim.g.netrw_liststyle = 0             -- Flat list view (most stable for navigation)
vim.g.netrw_browse_split = 0          -- Open files in the current window
vim.g.netrw_fastbrowse = 0            -- Always refresh to see new files
vim.g.netrw_hide = 1                  -- Hide files matching netrw_list_hide
vim.g.netrw_localcopydircmd = 'cp -r' -- Ensure directory copying works on Unix

-- 2. File Filtering (Clean view)
-- Hide current/parent dirs and common web junk if not handled by gitignore
vim.g.netrw_list_hide = [[\(^\|\s\s\)\.\.\/\?\($\|\s\s\),\(^\|\s\s\)\.\/\?\($\|\s\s\)]]

-- 3. Navigation Keybindings
-- '-' opens netrw in the current file's directory and focuses the file
vim.keymap.set("n", "-", function()
    local current_file = vim.fn.expand("%:t")
    vim.cmd("Ex %:p:h")

    if current_file ~= "" then
        vim.schedule(function()
            -- Find the file under cursor and center it
            vim.fn.search('\\<' .. current_file .. '\\>', "wc")
        end)
    end
end, { desc = "Netrw: Current directory", silent = true })

-- '_' opens netrw in the project root (CWD)
vim.keymap.set("n", "_", ":Ex .<CR>", { desc = "Netrw: Project root", silent = true })

-- 4. Buffer-local mappings (LHS/RHS stabilization)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        local function bind(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true, nowait = true })
        end

        -- Sidebar-like navigation
        bind("h", "-")    -- Go up
        bind("l", "<CR>") -- Open file/dir

        -- File Management (Marks & Operations)
        bind("Y", "mfmc") -- Mark then Copy
        bind("P", "mtmm") -- Mark then Move/Paste

        -- Renaming & Creation
        bind("r", "R") -- Rename
        bind("N", "d") -- Create Directory
        bind("n", "%") -- Create File

        -- Fast bookmark jumps
        bind("g1", "1gb")
        bind("g2", "2gb")
        bind("g3", "3gb")

        -- Clean exit (remap 'q' and 'jk' from autocmds if needed)
        bind("q", ":bd<CR>")

        -- UI tweaks for the file list
        vim.opt_local.number = true
        vim.opt_local.relativenumber = true
        vim.opt_local.bufhidden = "wipe" -- Crucial: don't leak netrw buffers
    end,
})
