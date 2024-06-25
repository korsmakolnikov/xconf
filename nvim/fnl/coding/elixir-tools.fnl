(local elixir (require :elixir))

(local elixirls (require :elixir.elixirls))

(elixir.setup {:credo {:cmd :path/to/credo-language-server
                       :enable true
                       :port 9000}
               :elixirls {:branch :mh/all-workspace-symbols
                          :cmd :elixir-ls
                          :on_attach (fn [])
                          :repo :mhanberg/elixir-ls
                          :settings (elixirls.settings {:dialyzerEnabled true
                                                        :enableTestLenses false
                                                        :fetchDeps false
                                                        :suggestSpecs false})
                          :tag :v0.14.6}
               :nextls {:cmd :path/to/next-ls
                        :enable false
                        :init_options {:experimental {:completions {:enable false}}
                                       :mix_env :dev
                                       :mix_target :host}
                        :port 9000}})

