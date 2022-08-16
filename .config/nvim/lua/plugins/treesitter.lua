require("nvim-treesitter.configs").setup({
    ensure_installed = {"css", "fish", "javascript", "json", "jsonc", "lua", "scss", "tsx", "typescript"},
    highlight = {
        enable = false
    },
    -- plugins
    context_commentstring = {
        enable = true,
        enable_autocmd = false
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ["."] = "textsubjects-smart"
        }
    },
    autotag = {
        enable = true
    }
})
