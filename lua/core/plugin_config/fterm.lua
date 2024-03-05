require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
})

-- Example keybindings
vim.keymap.set('n', '<c-t>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<c-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- Make LazyGit terminal
local fterm = require('FTerm')

local lazygit = fterm:new({
  ft = 'fterm_lazygit',
  cmd = 'lazygit',
})

vim.keymap.set('n', '<c-g>', function()
  lazygit:toggle()
end)

vim.keymap.set('t', '<c-g>', function()
  lazygit:toggle()
  vim.api.nvim_command('redraw!')
end)
