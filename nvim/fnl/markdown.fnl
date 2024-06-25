(vim.api.nvim_create_autocmd :BufEnter
                             {:command ":setlocal spell spelllang=en_us,it"
                              :pattern "*.md,*.vpc,*.txt"})

