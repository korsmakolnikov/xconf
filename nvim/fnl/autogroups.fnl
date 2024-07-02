(local format-sync-grp (vim.api.nvim_create_augroup :GoFormat {}))

(vim.api.nvim_create_autocmd :BufWritePre
                             {:callback (fn []
                                          ((. (require :go.format) :goimport)))
                              :group format-sync-grp
                              :pattern :*.go})

(vim.api.nvim_create_autocmd :BufEnter
                             {:command ":set autoindent noexpandtab tabstop=4 shiftwidth=4"
                              :pattern [:*.rs :*.s :*.asm]})

(vim.api.nvim_create_autocmd :BufEnter
                             {:command ":set autoindent noexpandtab tabstop=8 shiftwidth=8"
                              :pattern :*.go})

