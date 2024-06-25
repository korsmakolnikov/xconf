-- :fennel:1719609253
local cmp = require("cmp")
local function _1_(entry, vim_item)
  if vim.tbl_contains({"path"}, entry.source.name) then
    local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
    if icon then
      vim_item.kind = icon
      vim_item.kind_hl_group = hl_group
      local ___antifnl_rtn_1___ = vim_item
      return ___antifnl_rtn_1___
    else
    end
  else
  end
  return require("lspkind").cmp_format({with_text = false})(entry, vim_item)
end
local function _4_(args)
  return require("snippy").expand_snippet(args.body)
end
local function _5_()
  return true
end
cmp.setup({formatting = {format = _1_}, mapping = cmp.mapping.preset.insert({["<C-Space>"] = cmp.mapping.complete(), ["<C-b>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-e>"] = cmp.mapping.abort(), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<CR>"] = cmp.mapping.confirm({select = true}), ["<S-Tab>"] = cmp.mapping.select_prev_item(), ["<Tab>"] = cmp.mapping.select_next_item()}), snippet = {expand = _4_}, sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "snippy"}, {name = "treesitter"}, {name = "buffer-lines", option = {line_number_separator = ":", line_numbers = true, max_size = 0}}, {name = "spell", option = {enable_in_context = _5_, preselect_correct_word = true, keep_all_entries = false}}}, {{name = "buffer"}}), window = {completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered()}})
require("cmp").setup.cmdline({"/", "?"}, {mapping = require("cmp").mapping.preset.cmdline(), sources = {{name = "buffer", option = {keyword_pattern = "\\k\\+"}}, {name = "buffer-lines"}}})
cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})})
return cmp.setup.filetype("gitcommit", {sources = cmp.config.sources({{name = "cmp_git"}}, {{name = "buffer"}})})