-- :fennel:1719598980
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local function s()
  return require("mason").setup({ui = {icons = {package_installed = "\226\156\147", package_pending = "\226\158\156", package_uninstalled = "\226\156\151"}}})
end
local function lsp()
  return require("mason-lspconfig").setup({ensure_installed = {"clangd", "clojure_lsp", "cmake", "diagnosticls", "docker_compose_language_service", "dockerls", "dotls", "elixirls", "elmls", "elp", "eslint", "fennel_ls", "gopls", "graphql", "helm_ls", "html", "intelephense", "jqls", "jsonls", "lexical", "lua_ls", "marksman", "phpactor", "psalm", "rust_analyzer", "spectral", "sqlls", "sqls", "vacuum", "vimls", "yamlls"}})
end
local function autodeps()
  return require("mason-tool-installer").setup({auto_update = true, debounce_hours = 5, ensure_installed = {"bash-debug-adapter", "bzl", "graphql-language-service-cli", "jq", "json-to-struct", "jsonlint", "stylua", "shellcheck", "luaformatter", "php-cs-fixer", "php-debug-adapter", "yamlfmt", "yamllint", "go-debug-adapter", "goimports", "goimports-reviser", "golangci-lint", "golangci-lint-langserver", "golines", "gomodifytags", "gospel", "gotests", "gotestsum", "gofumpt", "shfmt", "cmakelint", "codelldb", "cpplint", "cpptools", "asmfmt", "yamlfix", "yamlfmt", "yamllint"}, run_on_start = true, start_delay = 3000})
end
return {setup = s, lsp = lsp, autodeps = autodeps}