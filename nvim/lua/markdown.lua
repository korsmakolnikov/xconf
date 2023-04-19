vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md,*.vpc,*.txt",
  command = ":setlocal spell spelllang=en_us,it",
})
