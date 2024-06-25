(local cmp (require :cmp))

(cmp.setup {:formatting {:format (fn [entry vim-item]
                                   (when (vim.tbl_contains [:path]
                                                           entry.source.name)
                                     (local (icon hl-group)
                                            ((. (require :nvim-web-devicons)
                                                :get_icon) (. (entry:get_completion_item)
                                                                                                                                           :label)))
                                     (when icon (set vim-item.kind icon)
                                       (set vim-item.kind_hl_group hl-group)
                                       (let [___antifnl_rtn_1___ vim-item]
                                         (lua "return ___antifnl_rtn_1___"))))
                                   (((. (require :lspkind) :cmp_format) {:with_text false}) entry
                                                                                            vim-item))}
            :mapping (cmp.mapping.preset.insert {:<C-Space> (cmp.mapping.complete)
                                                 :<C-b> (cmp.mapping.scroll_docs (- 4))
                                                 :<C-e> (cmp.mapping.abort)
                                                 :<C-f> (cmp.mapping.scroll_docs 4)
                                                 :<CR> (cmp.mapping.confirm {:select true})
                                                 :<S-Tab> (cmp.mapping.select_prev_item)
                                                 :<Tab> (cmp.mapping.select_next_item)})
            :snippet {:expand (fn [args]
                                ((. (require :snippy) :expand_snippet) args.body))}
            :sources (cmp.config.sources [{:name :nvim_lsp}
                                          {:name :snippy}
                                          {:name :treesitter}
                                          {:name :buffer-lines
                                           :option {:line_number_separator ":"
                                                    :line_numbers true
                                                    :max_size 0}}
                                          {:name :spell
                                           :option {:enable_in_context (fn []
                                                                         true)
                                                    :keep_all_entries false
                                                    :preselect_correct_word true}}]
                                         [{:name :buffer}])
            :window {:completion (cmp.config.window.bordered)
                     :documentation (cmp.config.window.bordered)}})

((. (require :cmp) :setup :cmdline) ["/" "?"]
                                    {:mapping ((. (require :cmp) :mapping
                                                  :preset :cmdline))
                                     :sources [{:name :buffer
                                                :option {:keyword_pattern "\\k\\+"}}
                                               {:name :buffer-lines}]})

(cmp.setup.cmdline ":"
                   {:mapping (cmp.mapping.preset.cmdline)
                    :sources (cmp.config.sources [{:name :path}]
                                                 [{:name :cmdline}])})

(cmp.setup.filetype :gitcommit
                    {:sources (cmp.config.sources [{:name :cmp_git}]
                                                  [{:name :buffer}])})

