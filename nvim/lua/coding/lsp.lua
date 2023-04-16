local vim = vim
local api = vim.api
local vimp = vim.api.nvim_set_keymap
local key_opts = { noremap = true, silent = true, buffer = bufnr }
-- Config LSP
function cst_formatting()
  if vim.lsp.buf.format~=nil then
    vim.lsp.buf.format { async = true }
  end
end

-- Highlight on yank
local lspGrp = api.nvim_create_augroup("BufWritePre", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "lua cst_formatting()",
  group = lspGrp,
})

local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vimp('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', key_opts)
  vimp('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', key_opts)
  vimp('n', '<C-space>', '<cmd>lua vim.lsp.buf.hover()<CR>', key_opts)
  vimp('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', key_opts)
  vimp('n', '<S-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', key_opts)
  vimp('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', key_opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'jsonls', 'tsserver', 'elmls', 'hls', 'ccls', 'lua_ls', 'bashls', 'yamlls' }
for _, lsp in pairs(servers) do
  require 'lspconfig'[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
  }
end

require 'lspconfig'.elixirls.setup {
  capabilities = capabilities,
  dialyzerEnabled = false,
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  cmd = { "elixir-ls" },
  settings = {
    elixirLS = {
      fetchDeps = false,
      mixEnv = "dev"
    }
  }
}

require 'lspconfig'.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
}
