local vim = vim
local vimp = vim.api.nvim_set_keymap
local key_opts = { noremap = true, silent = true, buffer = bufnr }
-- Mappings.
-- Filetree mapping
vimp('n', '<F2>', '<CMD>Oil<CR>', key_opts)
vimp('n', '<F3>', ':Neotree buffers toggle=true<CR>', key_opts)
vimp('n', '<F4>', ':Neotree git_status position=right toggle=true<CR>', key_opts)
vimp('n', '<F5>', ':Neotree toggle=true<CR>', key_opts)
vimp('n', '<C-c>', ':Neotree filesystem reveal right toggle=true<CR>', key_opts)
-- Buffers mapping
-- This is overridden in presenting mode
vimp('n', '<TAB>', ':BufferLineCycleNext<CR>', key_opts)
vimp('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', key_opts)
-- bdelete! %d
vimp('n', '<Leader>w', [[:Neotree close <CR> :bd # <CR> :BufferLineCyclePrev<CR> ]], { noremap = true, silent = true })
-- vimp('n', '<Leader>W', ':lua require(\'close_buffers\').wipe({ type = \'all\', force = true })<CR>', key_opts)
-- vimp('n', '<Leader><S-W>', ':lua require(\'close_buffers\').wipe({ type = \'other\' })<CR>', key_opts)
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
vimp('n', '<Leader>/',
  ":lua require'fzf-lua'.live_grep({ cmd = \"rg --sort=path --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e\"})<CR>'",
  key_opts)
vimp('n', '<Leader>/h',
  ":lua require'fzf-lua'.live_grep({ cmd = \"rg --sort=path --hidden --follow --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e\"})<CR>'",
  key_opts)
vimp('n', '<C-f>', ":FzfLua grep_cword<CR>", key_opts)
vimp('v', '<C-f>', ":FzfLua grep_visual<CR>", key_opts)
vimp('n', '<C-l>', ":lua require('fzf-lua').files({ resume = true })<CR>", key_opts)
-- copy filepath to clipboard
vimp('n', '<Leader>F', ":let @+=@%<CR>", key_opts)

-- LSP Mappings
-- All lsp function are under 'a'
-- All lsp diagnostic are under 'd'
-- All trouble function are under function keys
--
--

vimp('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', key_opts)
vimp('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', key_opts)
vimp('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', key_opts)
vimp('n', '<S-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', key_opts)
vim.keymap.set("n", "<C-space>", '<cmd>lua vim.lsp.buf.hover()<CR>', key_opts)
vim.api.nvim_set_keymap('n', '<Leader>mv', '<cmd>lua vim.lsp.buf.rename()<CR>', key_opts)
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

-- General mapping
vimp('n', '<F12>', ':e $MYVIMRC<CR>', key_opts)
vimp('n', '<S-F12>', ':luafile %<CR>', key_opts)
