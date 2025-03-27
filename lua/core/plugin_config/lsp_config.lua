vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, opts)
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
  end,
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"rust_analyzer",
		"fortls",
		"ruff",
		"pyright",
		"zls",
	},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

