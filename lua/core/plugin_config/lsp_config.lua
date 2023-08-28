local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.ensure_installed({
  'rust_analyzer',
  'fortls',
})
lsp.on_attach(function (client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)


require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()

local cmp = require('cmp')
local cmp_config = lsp.defaults.cmp_config({})

cmp.setup(cmp_config)
