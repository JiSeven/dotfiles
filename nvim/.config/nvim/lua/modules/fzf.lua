-- Helper: Get ignore patterns from .gitignore
local function get_gitignore_patterns()
    local patterns = { "%.git/", "node_modules/" } -- Default ignores
    local f = io.open(".gitignore", "r")
    if f then
        for line in f:lines() do
            -- Ignore comments and empty lines
            if not line:match("^#") and line:match("%S") then
                -- Convert glob to lua pattern (basic conversion)
                local p = line:gsub("%.", "%%."):gsub("%*", ".*"):gsub("/", "")
                table.insert(patterns, p)
            end
        end
        f:close()
    end
    return patterns
end

local function open_fzf_win(cmd, callback)
    local buf = vim.api.nvim_create_buf(false, true)
    local width, height = math.floor(vim.o.columns * 0.8), math.floor(vim.o.lines * 0.8)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = 'minimal',
        border = 'rounded'
    })

    local temp = os.tmpname()
    vim.fn.termopen(cmd .. ' > ' .. temp, {
        on_exit = function()
            if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
            if vim.fn.filereadable(temp) == 1 then
                local content = vim.fn.readfile(temp)
                if content and content[1] ~= "" then callback(content[1]) end
                os.remove(temp)
            end
        end
    })
    vim.cmd('startinsert')
end

-- 1. Project Files (FD respects .gitignore natively)
local function fzf_files()
    open_fzf_win('fd --type f --hidden --exclude .git --strip-cwd-prefix | fzf', function(selected)
        vim.cmd('edit ' .. selected)
    end)
end

-- 2. LSP Symbols (Manually filtered by .gitignore patterns)
local function fzf_lsp_symbols()
    vim.lsp.buf_request(0, "workspace/symbol", { query = "" }, function(err, result)
        if err or not result or vim.tbl_isempty(result) then return end

        local ignores = get_gitignore_patterns()
        local lines = {}
        for _, symbol in ipairs(result) do
            local path = vim.uri_to_fname(symbol.location.uri)
            local rel_path = vim.fn.fnamemodify(path, ":.")

            local skip = false
            for _, p in ipairs(ignores) do
                if rel_path:find(p) then
                    skip = true; break
                end
            end

            if not skip then
                local kind = vim.lsp.protocol.SymbolKind[symbol.kind] or "Unknown"
                table.insert(lines, string.format("%s [%s] %s:%d",
                    symbol.name, kind, rel_path, symbol.location.range.start.line + 1))
            end
        end

        local input_temp = os.tmpname()
        local f = io.open(input_temp, "w")
        f:write(table.concat(lines, "\n"))
        f:close()

        open_fzf_win('cat ' .. input_temp .. ' | fzf', function(selected)
            local file_pos = selected:match("([^%s]+:%d+)$")
            if file_pos then vim.cmd("edit " .. file_pos) end
            os.remove(input_temp)
        end)
    end)
end

vim.keymap.set('n', '<leader>f', fzf_files, { desc = "FZF Files" })
-- Using lowercase 's' for symbols as per your preference
vim.keymap.set('n', '<leader>ls', fzf_lsp_symbols, { desc = "FZF Symbols" })
