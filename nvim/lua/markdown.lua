vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md,*,vp,*.txt",
  command = ":setlocal spell spelllang=en_us,it",
})
