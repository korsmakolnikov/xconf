local api = vim.api
-- local vimp = vim.api.nvim_set_keymap
-- local key_opts = { noremap = true, silent = true, buffer = bufnr }
api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "lua vim.lsp.buf.format()",
})

-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   vimp('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', key_opts)
--   vimp('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', key_opts)
--   vimp('n', '<C-space>', '<cmd>lua vim.lsp.buf.hover()<CR>', key_opts)
--   vimp('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', key_opts)
--   vimp('n', '<S-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', key_opts)
--   vimp('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', key_opts)
--
--   -- require("lsp_signature").on_attach({ bind = true }, bufnr)
--   require("lsp-inlayhints").on_attach(client, bufnr)
-- end
--
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'jsonls', 'elmls', 'hls', 'ccls', 'lua_ls', 'bashls', 'yamlls' }
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

require 'lspconfig'.gopls.setup {
  capabilities = capabilities,
  -- on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
}

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
