local vim = vim
local api = vim.api
api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "lua vim.lsp.buf.format()",
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'clangd', 'jsonls', 'elmls', 'hls', 'lua_ls', 'bashls', 'yamlls' }
for _, lsp in pairs(servers) do
  require 'lspconfig'[lsp].setup {
    -- on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
  }
end

require 'lspconfig'.intelephense.setup({
  settings = {
    intelephense = {
      stubs = {
        "bcmath",
        "bz2",
        "Core",
        "curl",
        "date",
        "dom",
        "fileinfo",
        "filter",
        "gd",
        "gettext",
        "hash",
        "iconv",
        "imap",
        "intl",
        "json",
        "libxml",
        "mbstring",
        "mcrypt",
        "mysql",
        "mysqli",
        "password",
        "pcntl",
        "pcre",
        "PDO",
        "pdo_mysql",
        "Phar",
        "readline",
        "regex",
        "session",
        "SimpleXML",
        "sockets",
        "sodium",
        "standard",
        "superglobals",
        "tokenizer",
        "xml",
        "xdebug",
        "xmlreader",
        "xmlwriter",
        "yaml",
        "zip",
        "zlib",
        "wordpress-stubs",
        "woocommerce-stubs",
        "acf-pro-stubs",
        "wordpress-globals",
        "wp-cli-stubs",
        "genesis-stubs",
        "polylang-stubs"
      },
      environment = {
        includePaths = { '/home/blacksheep/.composer/vendor/' }
      },
      files = {
        maxSize = 5000000,
      },
    },
  },
  capabilities = capabilities,
  -- on_attach = on_attach
});

require 'lspconfig'.elixirls.setup {
  capabilities = capabilities,
  dialyzerEnabled = false,
  -- on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  cmd = { "/home/blacksheep/elixir-ls/release/language_server.sh" },
  settings = {
    elixirLS = {
      fetchDeps = false,
      mixEnv = "dev"
    }
  }
}

require 'lspconfig'.gopls.setup {
  capabilities = capabilities,
  -- on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}

require('go').setup({
  lsp_inlay_hints = {
    enable = false
  }
})


require 'lspconfig'.tsserver.setup {
  capabilities = capabilities,
  -- on_attach = on_attach,
  root_dir = require 'lspconfig'.util.root_pattern("package.json"),
  single_file_support = false
}

require 'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities,
  -- on_attach = on_attach,
  settings = {
    ['rust-analyzer'] = {
      inlay_hints = {
        closingBraceHints = {
          enable = true,
          minLines = 0,
        },
        typeHints = {
          enable = true
        },
      },
      cargo = {
        extraArgs = { "--profile", "rust-analyzer" },
        extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
      checkOnSave = {
        command = "clippy"
      },
    }
  }
}

local inlay_hints_default_configuration = {
  inlay_hints = {
    parameter_hints = {
      show = true,
      prefix = "<- ",
      separator = ", ",
      remove_colon_start = false,
      remove_colon_end = true,
    },
    type_hints = {
      -- type and other hints
      show = true,
      prefix = "",
      separator = ", ",
      remove_colon_start = false,
      remove_colon_end = false,
    },
    only_current_line = false,
    -- separator between types and parameter hints. Note that type hints are
    -- shown before parameter
    labels_separator = "  ",
    -- whether to align to the length of the longest line in the file
    max_len_align = false,
    -- padding from the left if max_len_align is true
    max_len_align_padding = 1,
    -- highlight group
    highlight = "LspInlayHint",
    -- virt_text priority
    priority = 0,
  },
  enabled_at_startup = true,
  debug_mode = false,
}
require("lsp-inlayhints").setup(inlay_hints_default_configuration)

require 'lspconfig'.cmake.setup {}
