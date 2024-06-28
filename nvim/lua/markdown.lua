local m = {}
m.md_setup = function()
  vim.cmd(":setlocal spell spelllang=en_us,it")
  vim.cmd(":set tw=80")
end
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md,*.vpc,*.txt",
  callback = m.md_setup
})
