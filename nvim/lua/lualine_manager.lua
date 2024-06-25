-- :fennel:1719609176
local function shorten_by(w)
  local function _1_(s)
    local ellipsis = "\226\128\166"
    return (s:sub(1, w) .. ellipsis)
  end
  return _1_
end
local shorten_branch_name = shorten_by(10)
return require("lualine").setup({options = {globalstatus = true}, sections = {lualine_b = {{"branch", fmt = shorten_branch_name}, "diff", "diagnostics"}, lualine_c = {{"filename", path = 1}, "require'lsp-status'.status()", "require'lsp-status'.register_progress()"}, lualine_x = {"encoding", "filetype", "os.date('%H:%M')"}}})