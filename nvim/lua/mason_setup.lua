require("mason").setup(
  {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  }
)

require('mason-tool-installer').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  ensure_installed = {

    -- you can pin a tool to a particular version
    -- { 'golangci-lint',        version = 'v1.47.0' },

    -- you can turn off/on auto_update per tool
    -- { 'bash-language-server', auto_update = true },
    'elixir-ls',
    'bash-language-server',
    'bash-debug-adapter',
    'bzl',
    'lua-language-server',
    'graphql-language-service-cli',
    'jq',
    'jq-lsp',
    'json-lsp',
    'json-to-struct',
    'jsonlint',
    'stylua',
    'shellcheck',
    'luacheck',
    'luaformatter',
    'yaml-language-server',
    'yamlfmt',
    'yamllint',
    'dot-language-server',
    'go-debug-adapter',
    'goimports',
    'goimports-reviser',
    'golangci-lint',
    'golangci-lint-langserver',
    'golines',
    'gomodifytags',
    'gopls',
    'gospel',
    'gotests',
    'gotestsum',
    'gofumpt',
    'luacheck',
    'shfmt',
    'cmake-language-server',
    'cmakelang',
    'cmakelint',
    'codelldb',
    'cpplint',
    'cpptools',
    'asmfmt',
    'docker-compose-language-service',
    'dockerfile-language-server',
    'yaml-language-server',
    'yamlfix',
    'yamlfmt',
    'yamllint',
  },

  -- if set to true this will check each tool for updates. If updates
  -- are available the tool will be updated. This setting does not
  -- affect :MasonToolsUpdate or :MasonToolsInstall.
  -- Default: false
  auto_update = true,

  -- automatically install / update on startup. If set to false nothing
  -- will happen on startup. You can use :MasonToolsInstall or
  -- :MasonToolsUpdate to install tools and check for updates.
  -- Default: true
  run_on_start = true,

  -- set a delay (in ms) before the installation starts. This is only
  -- effective if run_on_start is set to true.
  -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
  -- Default: 0
  start_delay = 3000, -- 3 second delay

  -- Only attempt to install if 'debounce_hours' number of hours has
  -- elapsed since the last time Neovim was started. This stores a
  -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
  -- This is only relevant when you are using 'run_on_start'. It has no
  -- effect when running manually via ':MasonToolsInstall' etc....
  -- Default: nil
  debounce_hours = 5, -- at least 5 hours between attempts to install/update
}
