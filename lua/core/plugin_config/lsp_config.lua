local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.ensure_installed({
	"rust_analyzer",
	"fortls",
	"ruff",
	"pyright",
})

require("lspconfig").rust_analyzer.setup({})
require("lspconfig").fortls.setup({})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
require("lspconfig").pyright.setup({
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
		pyright = {
			disableOrganizeImports = true,
		},
	},
})

require("lspconfig").ruff.setup({
	init_options = {
		settings = {
			args = {},
		},
	},
})

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "gr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "<leader>gca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>gf", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "<leader>gd", function()
		vim.diagnostic.setqflist()
	end, opts)
	vim.keymap.set("n", "<leader>tf", function()
		vim.lsp.buf.format({ async = true })
	end, {})
	vim.keymap.set("n", "<leader>grn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<leader>gpd", function()
		vim.lsp.buf.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>gnd", function()
		vim.lsp.buf.goto_next()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

lsp.setup()

