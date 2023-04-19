_G.presenting_mode = function()
  local vimp = vim.api.nvim_set_keymap
  local key_opts = { noremap = true, silent = true, buffer = bufnr }
  vim.cmd([[:set wrap]])
  vim.cmd([[:set nonumber]])
  vim.cmd([[:Goyo 120]])
  require('lualine').hide()
  vimp('n', '<Right>', ':bn<CR>', key_opts)
  vimp('n', '<Left>', ':bp<CR>', key_opts)
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.vp",
  command = ":lua _G.presenting_mode()",
})
