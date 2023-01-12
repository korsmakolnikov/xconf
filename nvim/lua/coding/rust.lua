local vim = vim
local api = vim.api
local vimp = vim.api.nvim_set_keymap
local key_opts = { noremap=true, silent=true, buffer=bufnr }
local rt = require("rust-tools")
local rust_tools_opts = {
  tools = {
    reload_workspace_from_cargo_toml = true,
    inlay_hints = { 
      parameter_hints_prefix = "-> ",
    },
    hover_actions = {
      auto_focus = false,
    },
  },
  server = {
    on_attach = function(_, bufnr)
      local up = true
      local down = false
      local move_up = function() 
        rt.move_item.move_item(up) 
      end
      local move_down = function()
        rt.move_item.move_item(down) 
      end

      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- why this do not work?
      -- vim.keymap.set("v", "<C-space>", "rt.hover_range.hover_range()", { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("x", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      -- Parent module
      vim.keymap.set("n", "<C-p>", rt.parent_module.parent_module, { buffer = bufnr })
      -- Move up/down
      vim.keymap.set("n", "<C-j>", move_down, { buffer = bufnr })
      vim.keymap.set("n", "<C-k>", move_up, { buffer = bufnr })

      vimp('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', key_opts)
      vimp('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', key_opts)
      vimp('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', key_opts)
      vimp('n', '<S-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', key_opts)
      vimp('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', key_opts)
      api.nvim_set_keymap('n', '<Leader>mv', '<cmd>lua vim.lsp.buf.rename()<CR>', key_opts)
    end,
  },
}
rt.setup(rust_tools_opts)

-- nvim_lspg['rust-analyzer'].setup {
--   inlayHints = { locationLinks = false } 
-- }
--
