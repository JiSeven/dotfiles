local utils = require("utils")

require("fzf-lua").setup({
    keymap = {
        fzf = {
            ["ctrl-q"] = "select-all+accept"
        }
    },
    winopts = {
        height = 0.95,
        width = 0.95,
        preview = {
            scrollbar = false
        }
    },
    fzf_opts = {
        ["--layout"] = "default"
    },
    files = {
        actions = {
            ["ctrl-e"] = function(selected)
                for i, item in ipairs(selected) do
                    local command = i == 1 and "edit" or i % 2 == 0 and "vsplit" or "split"
                    vim.cmd(string.format("%s %s", command, item))
                end
            end
        }
    }
})

utils.nmap("<Leader>ff", ":FzfLua files<CR>")
utils.nmap("<Leader>fs", ":FzfLua live_grep_glob<CR>")
