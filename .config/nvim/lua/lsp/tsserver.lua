local utils = require 'utils'

local M = {}
M.setup = function(on_attach, capabilities)
    require("typescript").setup({
        server = {
            on_attach = function(client, bufnr)
                utils.buf_map(bufnr, "n", "<leader>rf", ":TypescriptRenameFile<CR>")

                on_attach(client, bufnr)
            end,
            capabilities = capabilities
        }
    })
end

return M
