(fn shorten-by [w]
  (fn [s]
    (let [ellipsis "…"] (.. (s:sub 1 w) ellipsis))))

(local shorten-branch-name (shorten-by 10))

((. (require :lualine) :setup) {:options {:globalstatus true}
                                :sections {:lualine_b [{1 :branch
                                                        :fmt shorten-branch-name}
                                                       :diff
                                                       :diagnostics]
                                           :lualine_c [{1 :filename :path 1}
                                                       "require'lsp-status'.status()"
                                                       "require'lsp-status'.register_progress()"]
                                           :lualine_x [:encoding
                                                       :filetype
                                                       "os.date('%H:%M')"]}})

