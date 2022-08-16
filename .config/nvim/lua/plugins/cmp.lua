local cmp = require("cmp")

local snippy = require("snippy")

cmp.setup({
    snippet = {
        expand = function(args)
            snippy.expand_snippet(args.body)
        end
    },
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered()
    },
    mapping = {
        ["<C-n>"] = cmp.mapping(function()
            cmp.select_next_item()
        end, {"i", "s"}),
        ["<C-p>"] = cmp.mapping(function()
            cmp.select_prev_item()
        end, {"i", "s"}),
        ["<C-e>"] = cmp.mapping(function()
            cmp.abort()
        end, {"i", "s"}),
        ["<C-y>"] = cmp.mapping(function()
            cmp.confirm()
        end, {"i", "s"}),
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.get_selected_entry() then
                cmp.confirm()
            else
                fallback()
            end
        end, {"i", "s"})
    },
    sources = { -- only show one snippet, and always show at top
    {
        name = "snippy",
        priority = 9999,
        keyword_length = 2,
        max_item_count = 1
    }, {
        name = "nvim_lsp",
        keyword_length = 3
    }, {
        name = "tmux",
        keyword_length = 3
    }, {
        name = "buffer",
        keyword_length = 3,
        option = {
            -- complete from visible buffers
            get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
            end
        }
    }, {
        name = "path"
    }}
})
