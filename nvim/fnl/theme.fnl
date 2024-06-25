((. (require :onedark) :setup) {:cmp_itemkind_reverse false
                                :code_style {:comments :none
                                             :functions :bold
                                             :keywords :none
                                             :strings :none
                                             :variables :bold}
                                :colors {}
                                :diagnostics {:background true
                                              :darker true
                                              :undercurl true}
                                :ending_tildes false
                                :highlights {}
                                :lualine {:transparent false}
                                :style :darker
                                :term_colors true
                                :toggle_style_key nil
                                :toggle_style_list [:dark
                                                    :darker
                                                    :cool
                                                    :deep
                                                    :warm
                                                    :warmer
                                                    :light]
                                :transparent false})

((. (require :onedark) :load))

