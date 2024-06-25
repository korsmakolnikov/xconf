(local api vim.api)

(vim.api.nvim_create_augroup :LspAttach_inlayhints {})

(vim.api.nvim_create_autocmd :LspAttach
                             {:callback (fn [args]
                                          (when (not (and args.data
                                                          args.data.client_id))
                                            (lua "return "))
                                          (local bufnr args.buf)
                                          (local client
                                                 (vim.lsp.get_client_by_id args.data.client_id))
                                          (api.nvim_buf_set_option bufnr
                                                                   :omnifunc
                                                                   "v:lua.vim.lsp.omnifunc")
                                          ((. (require :lsp-inlayhints)
                                              :on_attach) client
                                                                                                                                  bufnr
                                                                                                                                  true))
                              :group :LspAttach_inlayhints})

