; invoking Lazy setup
(local p (require :packages))
(p.setup)

(require :impatient)
(require :theme)
(require :options)
(require :lualine.themes.gruvbox-material)
((. (require :nvim_comment) :setup))
((. (require :bufferline) :setup))
((. (require :gitlinker) :setup))


(require :oil_manager)
(require :bindings)
(require :markdown)
(require :lib)
(require :lualine_manager)

(require :coding.snippets)
(require :coding.dap)
(require :coding.lsp)
(require :coding.autocompletition)
(require :coding.on_attach)
;; Treesitter install dictionaries every time the editor restart
(require :coding.treesitter)
(require :coding.elixir-tools)

(require :autogroups)
