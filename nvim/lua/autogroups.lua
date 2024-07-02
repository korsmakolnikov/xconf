-- :fennel:1719952905
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
local function _1_()
  return require("go.format").goimport()
end
vim.api.nvim_create_autocmd("BufWritePre", {callback = _1_, group = format_sync_grp, pattern = "*.go"})
vim.api.nvim_create_autocmd("BufEnter", {command = ":set autoindent noexpandtab tabstop=4 shiftwidth=4", pattern = {"*.rs", "*.s", "*.asm"}})
return vim.api.nvim_create_autocmd("BufEnter", {command = ":set autoindent noexpandtab tabstop=8 shiftwidth=8", pattern = "*.go"})