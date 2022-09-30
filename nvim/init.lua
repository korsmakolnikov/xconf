local key_opts = { noremap=true, silent=true }
local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
local vimp = vim.api.nvim_set_keymap
local cmd = vim.cmd
local api = vim.api

-- ensure that packer is installed
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(packer_install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_install_path})
end

cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

require('plugins')

require('github-theme').setup()

cmd('colorscheme github_*')
vim.g.mapleader = ","
vim.opt.matchpairs = vim.bo.matchpairs .. ",<:>"

local set = vim.opt
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
vim.wo.wrap = false
set.termguicolors = true
vim.o.cc = '80'
vim.o.virtualedit = 'all'
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.autoindent = true
vim.o.number = true
vim.o.wildmode = 'longest,list'
vim.o.syntax = 'on'
vim.o.mouse = 'a'
vim.o.clipboard=vim.o.clipboard..'unnamedplus'
vim.o.ttyfast = true
vim.o.backupdir = '~/.config/nvim/backup'
vim.o.cmdheight = 3
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess=vim.o.shortmess..'c'
vim.g.loaded_python_provider = '0'
vim.g.goyo_width = '80'

-- Neovide
vim.g.neovide_fullscreen=true
set.guifont = 'Fira Code:h10'
vim.g.neovide_cursor_vfx_mode = "railgun"

-- autogroup provides
-- TODO autoformat files doesn't work!
vim.api.nvim_command([[
augroup SetAutoindent
autocmd BufEnter *.go :set autoindent noexpandtab tabstop=8 shiftwidth=8
autocmd BufEnter *.rs :set autoindent noexpandtab tabstop=4 shiftwidth=4
augroup END 
]])

-- Highlight on yank
local lspGrp = api.nvim_create_augroup("BufWritePre", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "lua vim.lsp.buf.formatting_sync(nil, 5000)",
  group = lspGrp,
})

-- Filetree mapping
vimp('n', '<F2>', ':Neotree toggle=true<CR>', key_opts)
vimp('n', '<F3>', ':Neotree buffers toggle=true<CR>', key_opts)
vimp('n', '<F4>', ':Neotree git_status position=right toggle=true<CR>', key_opts)
vimp('n', '<C-c>', ':Neotree filesystem reveal right toggle=true<CR>', key_opts)
-- Buffers mapping
vimp('n', '<TAB>', ':BufferLineCycleNext<CR>', key_opts)
vimp('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', key_opts)
vimp( 'n', '<leader>w', [[<CMD>lua require('close_buffers').delete({type = 'this'})<CR>]], { noremap = true, silent = true })
vimp('n', '<Leader>W', ':lua require(\'close_buffers\').wipe({ type = \'all\', force = true })<CR>', key_opts)
vimp('n', '<Leader>o', ':lua require(\'close_buffers\').wipe({ type = \'other\' })<CR>', key_opts)
-- Tab mapping
vimp('x', '<Tab>', '>gv |', key_opts)
vimp('x', '<S-Tab>', '<gv', key_opts)
-- FZF mapping
-- git is under 'g' except list files that is bound to leader-space
-- rg is under 'r' except grep project that is bound to leader-/
-- history is under 'h'
vimp('n', '<Leader>.', ":FzfLua oldfiles<CR>", key_opts)
vimp('n', '<Leader>hs', ":FzfLua search_history<CR>", key_opts)
vimp('n', '<Leader>hc', ":FzfLua command_history<CR>", key_opts)
vimp('n', '<Leader>:', ":FzfLua resume<CR>", key_opts)
vimp('n', '<Leader>,', ":FzfLua buffers<CR>", key_opts)
vimp('n', '<Leader>m', ":FzfLua marks<CR>", key_opts)
vimp('n', '<Leader>k', ":FzfLua keymaps<CR>", key_opts)
vimp('n', '<Leader>r', ":FzfLua registers<CR>", key_opts)
vimp('n', '<Leader>j', ":FzfLua jump<CR>", key_opts)
vimp('n', '<Leader>f', ":FzfLua files<CR>", { noremap = true, silent = true })
vimp('n', '<Leader><Space>', ":FzfLua git_files<CR>", key_opts)
-- Git
vimp('n', '<Leader>g', ":FzfLua git_bcommits<CR>", key_opts)
vimp('n', '<Leader>gs', ":FzfLua git_status<CR>", key_opts)
vimp('n', '<Leader>gp', ":FzfLua git_commits<CR>", key_opts)
vimp('n', '<Leader>gb', ":FzfLua git_branches<CR>", key_opts)
vimp('n', '<Leader>gc', ":FzfLua changes<CR>", key_opts)
-- FZF rg
vimp('n', '<Leader>rl', ":FzfLua grep_curbuf<CR>", key_opts)
vimp('n', '<Leader>/', ":FzfLua live_grep<CR>", key_opts)
vimp('n', '<C-f>', ":FzfLua grep_cword<CR>", key_opts)
vimp('v', '<C-f>',":FzfLua grep_visual<CR>", key_opts)
vimp('n', '<C-l>', ":FzfLua grep_last<CR>", key_opts)

-- LSP Mappings
-- All lsp function are under 'a'
-- All lsp diagnostic are under 'd'
-- All trouble function are under function keys
vimp('n', '<Leader>a', ":FzfLua lsp_code_actions<CR>", key_opts)
vimp('n', '<Leader>Ad', ":FzfLua lsp_definitions<CR>", key_opts)
vimp('n', '<Leader>AD', ":FzfLua lsp_declarations<CR>", key_opts)
vimp('n', '<Leader>At', ":FzfLua lsp_typedefs<CR>", key_opts)
vimp('n', '<Leader>Ai', ":FzfLua lsp_implementations<CR>", key_opts)
vimp('n', '<Leader>Ar', ":FzfLua lsp_references<CR>", key_opts)
vimp('n', '<Leader>As', ":FzfLua lsp_document_symbols<CR>", key_opts)
vimp('n', '<Leader>Aws', ":FzfLua lsp_workspace_symbols<CR>", key_opts)
vimp('n', '<Leader>d', ":FzfLua lsp_document_diagnostics<CR>", key_opts)
vimp('n', '<Leader>da', ":FzfLua lsp_workspace_diagnostics<CR>", key_opts)
vimp('n', '<Leader>e', ':lua vim.diagnostic.goto_next()<CR>', key_opts)
vimp('n', '<Leader>z', ':lua vim.diagnostic.open_float()<CR>', key_opts)
vimp('n', '<Leader>E', ':lua vim.diagnostic.goto_prev()<CR>', key_opts)
vimp('n', '<Leader>Af', ':lua vim.lsp.buf.formatting_sync(nil, 5000)<CR>', key_opts)

-- Trouble
vimp("n", "<F6>", "<cmd>TroubleToggle workspace_diagnostics<cr>", key_opts)
vimp("n", "<F7>", "<cmd>TroubleToggle document_diagnostics<cr>", key_opts)
vimp("n", "<F8>", "<cmd>TroubleToggle quickfix<cr>", key_opts)
-- General mapping
vimp('n', '<F12>', ':e $MYVIMRC<CR>', key_opts)
vimp('n', '<S-F12>', ':luafile %<CR>', key_opts)

-- Config LSP

local nvim_lsp = require'lspconfig'
local on_attach = function(client, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-space>', '<cmd>lua vim.lsp.buf.hover()<CR>', key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<S-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', key_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', key_opts)
end

local servers = { 'gopls', 'elmls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end


local rt = require("rust-tools")
local rust_tools_opts = {
  tools = {
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

      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', key_opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', key_opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', key_opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<S-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', key_opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', key_opts)
      vim.api.nvim_set_keymap('n', '<Leader>mv', '<cmd>lua vim.lsp.buf.rename()<CR>', key_opts)
    end,
  },
}
rt.setup(rust_tools_opts)

local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

local custom_gruvbox = require'lualine.themes.gruvbox-material'

function shorten_by(w)
  return function(s)
    local ellipsis = "…"
    return s:sub(1, w) .. ellipsis
  end
end

local shorten_branch_name = shorten_by(10)

require('lualine').setup {
  sections = {
    lualine_b = {{'branch', fmt = shorten_branch_name}, 'diff', 'diagnostics' },
    lualine_c = {'filename', "require'lsp-status'.status()", "require'lsp-status'.register_progress()"},
    lualine_x = {'encoding', 'filetype', "os.date('%H:%M')"},
  }
} 

require('nvim_comment').setup()

-- DAP debug

vim.keymap.set("n", "<F5>", require'dap'.continue, { buffer = bufnr })
-- nnoremap <silent> <F9> <Cmd>lua require'dap'.step_over()<CR>
-- nnoremap <silent> <F10> <Cmd>lua require'dap'.step_into()<CR>
-- nnoremap <silent> <F11> <Cmd>lua require'dap'.step_out()<CR>
vim.keymap.set("n", "<Leader>b", require'dap'.toggle_breakpoint, { buffer = bufnr })
-- nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
-- nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb',
}

dap.configurations.env = function()
  local variables = {}
  for k, v in pairs(vim.fn.environ()) do
    table.insert(variables, string.format("%s=%s", k, v))
  end
  return variables
end

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("dapui").setup()
vim.keymap.set("n", "<M-k>", require'dapui'.eval, { buffer = bufnr })
dap.listeners.after.event_initialized["dapui_config"] = function()
  require'dapui'.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  require'dapui'.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  require'dapui'.close()
end

vim.opt.termguicolors = true
require("bufferline").setup{}

require('close_buffers').setup({
  preserve_window_layout = { 'this' },
  next_buffer_cmd = function(windows)
    require('bufferline').cycle(1)
    local bufnr = vim.api.nvim_get_current_buf()

    for _, window in ipairs(windows) do
      vim.api.nvim_win_set_buf(window, bufnr)
    end
  end,
})
