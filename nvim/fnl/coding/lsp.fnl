(local api vim.api)

(api.nvim_create_autocmd :BufWritePre
                         {:command "lua vim.lsp.buf.format()" :pattern "*"})

(local capabilities ((. (require :cmp_nvim_lsp) :default_capabilities)))

(local servers [:clangd :jsonls :elmls :hls :lua_ls :bashls :yamlls :fennel_ls])

(each [_ lsp (pairs servers)]
  ((. (require :lspconfig) lsp :setup) {: capabilities
                                        :flags {:debounce_text_changes 150}}))

((. (require :lspconfig) :intelephense :setup) {: capabilities
                                                :settings {:intelephense {:environment {:includePaths [:/home/blacksheep/.composer/vendor/]}
                                                                          :files {:maxSize 5000000}
                                                                          :stubs [:bcmath
                                                                                  :bz2
                                                                                  :Core
                                                                                  :curl
                                                                                  :date
                                                                                  :dom
                                                                                  :fileinfo
                                                                                  :filter
                                                                                  :gd
                                                                                  :gettext
                                                                                  :hash
                                                                                  :iconv
                                                                                  :imap
                                                                                  :intl
                                                                                  :json
                                                                                  :libxml
                                                                                  :mbstring
                                                                                  :mcrypt
                                                                                  :mysql
                                                                                  :mysqli
                                                                                  :password
                                                                                  :pcntl
                                                                                  :pcre
                                                                                  :PDO
                                                                                  :pdo_mysql
                                                                                  :Phar
                                                                                  :readline
                                                                                  :regex
                                                                                  :session
                                                                                  :SimpleXML
                                                                                  :sockets
                                                                                  :sodium
                                                                                  :standard
                                                                                  :superglobals
                                                                                  :tokenizer
                                                                                  :xml
                                                                                  :xdebug
                                                                                  :xmlreader
                                                                                  :xmlwriter
                                                                                  :yaml
                                                                                  :zip
                                                                                  :zlib
                                                                                  :wordpress-stubs
                                                                                  :woocommerce-stubs
                                                                                  :acf-pro-stubs
                                                                                  :wordpress-globals
                                                                                  :wp-cli-stubs
                                                                                  :genesis-stubs
                                                                                  :polylang-stubs]}}})

((. (require :lspconfig) :gopls :setup) {: capabilities
                                         :flags {:debounce_text_changes 150}
                                         :settings {:gopls {:hints {:assignVariableTypes true
                                                                    :compositeLiteralFields true
                                                                    :compositeLiteralTypes true
                                                                    :constantValues true
                                                                    :functionTypeParameters true
                                                                    :parameterNames true
                                                                    :rangeVariableTypes true}}}})

((. (require :go) :setup) {:lsp_inlay_hints {:enable false}})

((. (require :lspconfig) :tsserver :setup) {: capabilities
                                            :root_dir ((. (require :lspconfig)
                                                          :util :root_pattern) :package.json)
                                            :single_file_support false})

((. (require :lspconfig) :rust_analyzer :setup) {: capabilities
                                                 :settings {:rust-analyzer {:cargo {:extraArgs [:--profile
                                                                                                :rust-analyzer]
                                                                                    :extraEnv {:CARGO_PROFILE_RUST_ANALYZER_INHERITS :dev}
                                                                                    :loadOutDirsFromCheck true}
                                                                            :checkOnSave {:command :clippy}
                                                                            :inlay_hints {:closingBraceHints {:enable true
                                                                                                              :minLines 0}
                                                                                          :typeHints {:enable true}}
                                                                            :procMacro {:enable true}}}})

(local inlay-hints-default-configuration
       {:debug_mode false
        :enabled_at_startup true
        :inlay_hints {:highlight :LspInlayHint
                      :labels_separator "  "
                      :max_len_align false
                      :max_len_align_padding 1
                      :only_current_line false
                      :parameter_hints {:prefix "<- "
                                        :remove_colon_end true
                                        :remove_colon_start false
                                        :separator ", "
                                        :show true}
                      :priority 0
                      :type_hints {:prefix ""
                                   :remove_colon_end false
                                   :remove_colon_start false
                                   :separator ", "
                                   :show true}}})

((. (require :lsp-inlayhints) :setup) inlay-hints-default-configuration)

((. (require :lspconfig) :cmake :setup) {})

