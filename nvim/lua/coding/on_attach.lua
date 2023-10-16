local vim = vim
local api = vim.api
local vimp = vim.api.nvim_set_keymap
local key_opts = { noremap = true, silent = true, buffer = bufnr }
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vimp('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', key_opts)
    vimp('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', key_opts)
    vimp('n', '<C-space>', '<cmd>lua vim.lsp.buf.hover()<CR>', key_opts)
    vimp('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', key_opts)
    vimp('n', '<S-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', key_opts)
    vimp('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', key_opts)

    -- require("lsp_signature").on_attach({ bind = true }, bufnr)
    require("lsp-inlayhints").on_attach(client, bufnr, true)
    print("dbg on_attach executed")
  end,
})

api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function(_)
    -- require("lsp-inlayhints").opts({ inlay_hints = { highlight = "Comment" } })
  end,
})
--  {
--   "lvimuser/lsp-inlayhints.nvim",
--   event = "",
--   opts = { inlay_hints = { highlight = "Comment" } },
-- }
