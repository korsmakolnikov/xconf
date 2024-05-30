local function shorten_by(w)
  return function(s)
    local ellipsis = "…"
    return s:sub(1, w) .. ellipsis
  end
end

local shorten_branch_name = shorten_by(10)

require('lualine').setup({
  options = {
    globalstatus = true
  },
  sections = {
    lualine_b = { { 'branch', fmt = shorten_branch_name }, 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 }, "require'lsp-status'.status()", "require'lsp-status'.register_progress()" },
    lualine_x = { 'encoding', 'filetype', "os.date('%H:%M')" },
  }
})
