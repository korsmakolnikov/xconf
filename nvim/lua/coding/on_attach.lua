-- :fennel:1719609310
local api = vim.api
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
local function _1_(args)
  if not (args.data and args.data.client_id) then
    return 
  else
  end
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  return require("lsp-inlayhints").on_attach(client, bufnr, true)
end
return vim.api.nvim_create_autocmd("LspAttach", {callback = _1_, group = "LspAttach_inlayhints"})