local utils = require("utils")
local builtin = require("nnn").builtin

require("nnn").setup({
    replace_netrw = "picker",
    mappings = {{"<C-t>", builtin.open_in_tab}, {"<C-s>", builtin.open_in_split}, {"<C-v>", builtin.open_in_vsplit},
                {"<C-p>", builtin.open_in_preview}, {"<C-y>", builtin.copy_to_clipboard},
                {"<C-e>", builtin.populate_cmdline}}
})

utils.nmap("<Leader>e", ":e .<cr>")
utils.nmap("-", function()
    -- check if current buffer's file exists, since the picker won't open otherwise
    return vim.loop.fs_stat(vim.api.nvim_buf_get_name(0)) and vim.cmd(":NnnPicker %") or vim.cmd("NnnPicker")
end)
