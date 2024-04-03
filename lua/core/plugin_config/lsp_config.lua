local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.ensure_installed({
	"rust_analyzer",
	"fortls",
	"pyright",
})

require("lspconfig").rust_analyzer.setup({})
require("lspconfig").fortls.setup({})
require("lspconfig").pyright.setup({
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
})

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
		vim.diagnostic.setloclist()
	end, opts)
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

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()

local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item()
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),
	}),
})
