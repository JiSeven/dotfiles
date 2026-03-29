vim.lsp.enable({ "vtsls", "lua_ls", "eslint", "tailwindcss", "biome" })

vim.diagnostic.config({
	virtual_text = false, -- ЭТО ГЛАВНОЕ: убирает текст из буфера
	signs = true, -- Оставляем иконки слева
	underline = true, -- Оставляем подчеркивание в коде
	update_in_insert = false,
	severity_sort = true,
	float = {
		focused = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		-- Inlay Hints (0.12 native)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end
	end,
})
