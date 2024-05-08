local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
		null_ls.builtins.diagnostics.ruff,
	},

	vim.keymap.set("n", "<leader>tf", function()
		vim.lsp.buf.format({ async = true })
	end, {}),
})
