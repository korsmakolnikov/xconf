local vim = vim

local vimp = vim.api.nvim_set_keymap
local key_opts = { noremap = true, silent = true, buffer = bufnr }

--local oil_manager = require "oil_manager"

-- Mappings.
-- Filetree mapping
vimp('n', '<F3>', ':Neotree buffers toggle=true<CR>', key_opts)
vimp('n', '<F4>', ':Neotree git_status position=right toggle=true<CR>', key_opts)
vimp('n', '<F5>', ':Neotree toggle=true<CR>', key_opts)
-- Buffers mapping
-- Tab mapping
vimp('x', '<Tab>', '>gv |', key_opts)
vimp('x', '<S-Tab>', '<gv', key_opts)
-- This is overridden in presenting mode

-- FZF mapping
-- git is under 'g' except list files that is bound to leader-space
-- rg is under 'r' except grep project that is bound to leader-/
-- history is under 'h'
-- vimp('n', '<Leader><Space>', ":FzfLua git_files<CR>", key_opts)
-- -- Git
-- -- FZF rg
-- vimp('n', '<Leader>/',
--   ":lua require'fzf-lua'.live_grep({ cmd = \"rg --sort=path --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e\"})<CR>'",
--   key_opts)
-- vimp('n', '<Leader>/h',
--   ":lua require'fzf-lua'.live_grep({ cmd = \"rg --sort=path --hidden --follow --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e\"})<CR>'",
--   key_opts)

-- copy filepath to clipboard

-- General mapping
vimp('n', '<F12>', ':e $MYVIMRC<CR>', key_opts)
-- does it works?
vimp('n', '<S-F12>', ':luafile %<CR>', key_opts)

-- FZF new mapping
--

local wk = require("which-key")
local dap = require("dap")

-- Normal mode
wk.register({
  ["c"] = {
    name = "+Fzf Commands",
    a = { ":FzfLua args<CR>", "Find args" },
    b = { ":FzfLua buffers<CR>", "Find buffers" },
    f = { ":FzfLua files<CR>", "Find files" },
    h = { ":FzfLua oldfiles<CR>", "Find in history" },
    t = { ":FzfLua tabs<CR>", "Find tabs" },
    ["l"] = {
      name = "+Locations & lines",
      l = { ":FzfLua loclist<CR>", "Find location" },
      s = { ":FzfLua loclist_stack<CR>", "Find location stack" },
      i = { ":FzfLua lines<CR>", "Find lines" },
      b = { ":FzfLua blines<CR>", "Find better lines" },
    },
    ["q"] = {
      name = "Quickfix",
      q = { ":FzfLua quickfix<CR>", "Find quickfix" },
      s = { ":FzfLua quickfix_stack<CR>", "Find quickfix stack" },
    },
  },

  ["i"] = {
    name = "+Completition",
    p = { ":FzfLua complete_path<CR>", "Complete path under cursor" },
    f = { ":FzfLua complete_file<CR>", "Complete file under cursor" },
    l = { ":FzfLua complete_line<CR>", "Complete line (all buffers)" },
    b = { ":FzfLua complete_bline<CR>", "Complete line (current buffer)" },
  },

  ["d"] = {
    name = "+DAP",
    c = { ":FzfLua dap_commands<CR>", "DAP commands" },
    C = { dap.continue(), "Dap continue" },
    o = { ":FzfLua dap_configurations<CR>", "DAP configurations" },
    b = { ":FzfLua dap_breakpoints<CR>", "List breakpoints" },
    B = { dap.toggle_breakpoint(), "Toggle breakpoint" },
    v = { ":FzfLua dap_variables<CR>", "Active session variables" },
    f = { ":FzfLua dap_frames<CR>", "Active session jump to frame" },
    R = { ":lua require'dap'.repl.open()<CR>", "REPL" }
  },

  ["n"] = {
    name = "+Fzf-lua",
    r = { ":FzfLua register_ui_select<CR>", "Register fzf-lua as UI Interface for vim.ui.select" },
    d = { ":FzfLua deregister_ui_select<CR>", "De-register fzf-lua with vim.ui.select" },
  },

  ["m"] = {
    name = "+Fzf Misc",
    r = { ":FzfLua resume<CR>", "Resume last command/query" },
    b = { ":FzfLua builtin<CR>", "Fzf-lua builtin commands" },
    p = { ":FzfLua profiles<CR>", "Fzf-lua configuration profiles" },
    h = { ":FzfLua help_tags<CR>", "Help tags" },
    ["?"] = { ":FzfLua man_pages<CR>", "Man pages" },
    o = { ":FzfLua colorschemes<CR>", "Color schemas" },
    l = { ":FzfLua highlights<CR>", "Highlight groups" },
    c = { ":FzfLua commands<CR>", "Nvim commands" },
    H = { ":FzfLua command_history<CR>", "Commands history" },
    s = { ":FzfLua search_history<CR>", "" },
    m = { ":FzfLua marks<CR>", "Marks" },
    j = { ":FzfLua jumps<CR>", "Jumps" },
    g = { ":FzfLua changes<CR>", "Changes" },
    e = { ":FzfLua registers<CR>", "Registers" },
    t = { ":FzfLua tagstack<CR>", "Tags" },
    a = { ":FzfLua autocmds<CR>", "Autocommands" },
    k = { ":FzfLua keymaps<CR>", "Key mapping" },
    f = { ":FzfLua filetypes<CR>", "Filetypes" },
    n = { ":FzfLua menus<CR>", "Menus" },
    x = { ":FzfLua spell_suggest<CR>", "Spelling suggestions" },
    z = { ":FzfLua packadd<CR>", "Packadd" },
  },

  ["l"] = {
    name = "+LSP",
    ["n"] = {
      name = "+Nav",
      d = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Jump to declaration" },
      D = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Jump to definition" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Jump to implementation" },
    },
    ["e"] = {
      name = "+Diagnostic",
      n = { ":lua vim.diagnostic.goto_next()<CR>", "Next error" },
      f = { ":lua vim.diagnostic.open_float()<CR>", "Error float" },
      p = { ":lua vim.diagnostic.goto_prev()<CR>", "Previous error" },
    },
    ["h"] = {
      name = "+Helper",
      s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
      h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Lsp hover" },
    },
    r = { ":FzfLua lsp_references<CR>", "Find references" },
    d = { ":FzfLua lsp_definitions<CR>", "Find definition" },
    D = { ":FzfLua lsp_declarations<CR>", "Find declaration" },
    t = { ":FzfLua lsp_typedefs<CR>", "Find type definition" },
    i = { ":FzfLua lsp_implementations<CR>", "Find implementation" },
    s = { ":FzfLua lsp_document_symbols<CR>", "Find symbols" },
    S = { ":FzfLua lsp_workspace_symbols<CR>", "Find Workspace symbols" },
    a = { ":FzfLua lsp_code_actions<CR>", "Find code actions" },
    f = { ":FzfLua lsp_finder<CR>", "All LSP locations combined view" },
    x = { ":FzfLua diagnostics_document<CR>", "Find diagnostic" },
    F = { ":lua vim.lsp.buf.formatting_sync(nil, 5000)<CR>", "Sync buffer format" },
    R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol" },
    ["c"] = {
      name = "+Calls",
      i = { ":FzfLua lsp_incoming_calls<CR>", "Incoming calls" },
      o = { ":FzfLua lsp_outgoing_calls<CR>", "Outgoing calls" },
    },
    ["w"] = {
      name = "+Workspace",
      x = { ":FzfLua diagnostics_workspace<CR>", "Find diagnostic" },
      s = { ":FzfLua lsp_live_workspace_symbols<CR>", "Find symbols" },
    },
  },

  ["g"] = {
    name = "+Git",
    f = { ":FzfLua git_files<CR>", "Find versioned files" },
    s = { ":FzfLua git_status<CR>", "Status" },
    c = { ":FzfLua git_commits<CR>", "Commits project" },
    C = { ":FzfLua git_bcommits<CR>", "Commits buffer" },
    b = { ":FzfLua git_branches<CR>", "Branches" },
    t = { ":FzfLua git_tags<CR>", "Tags" },
    S = { ":FzfLua git_stash<CR>", "Stash" },
  },

  ["t"] = {
    name = "+Tags",
    p = { ":FzfLua tags<CR>", "Find tags project" },
    b = { ":FzfLua btags<CR>", "Find tags buffer" },
    Sp = { ":FzfLua tags_grep<CR>", "Grep project tags" },
    Sw = { ":FzfLua tags_grep_cword<CR>", "Grep word under cursor" },
    SW = { ":FzfLua tags_grep_cWORD<CR>", "Grep WORD under cursor" },
    g = { ":FzfLua tags_live_grep<CR>", "Live grep" },
  },

  ["s"] = {
    name = "+Search",
    g = { ":FzfLua live_grep<CR>", "Live grep project" },
    r = { ":FzfLua live_grep_resume<CR>", "Live grep resume" },
    b = { ":FzfLua live_grep_glob<CR>", "Live grep glob" },
    n = { ":FzfLua live_grep_native<CR>", "Live grep native" },
    ["G"] = {
      name = "+Grep",
      g = { ":FzfLua grep<CR>", "Grep" },
      l = { ":FzfLua grep_last<CR>", "Grep resume" },
      w = { ":FzfLua grep_cword<CR>", "Grep word under cursor" },
      W = { ":FzfLua grep_cWORD<CR>", "Grep WORD under cursor" },
      v = { ":FzfLua grep_visual<CR>", "Visual grep" },
      p = { ":FzfLua grep_project<CR>", "Grep project" },
      c = { ":FzfLua grep_curbuf<CR>", "" },
      C = { ":FzfLua lgrep_curbuf<CR>", "" },
    },
    -- to deprecate?
    ["<C-s>"] = { ":FzfLua grep_cword<CR>", "Grep word under cursor" },
    ["<C-l>"] = { ":lua require('fzf-lua').files({ resume = true })<CR>", "Resume file search" },
  },

  ["y"] = { ":let @+=@%<CR>", "Yank file path" }
}, { prefix = "<Leader>" })

wk.register({
  ["<C-f>"] = { ":lua require'oil_manager'.toggle_on_root_folder()<CR>", "Oil" },
  ["<C-c>"] = { ":lua require'oil_manager'.toggle_on_current_folder()<CR>", "Oil current directory" },
  ["<TAB>"] = { ':BufferLineCycleNext<CR>', "Next tab" },
  ["<S-TAB>"] = { ':BufferLineCyclePrev<CR>', "Previous tab" },
  ["\\"] = { ":Neotree reveal<cr>", "Neotree" },
})

-- Visual mode
wk.register({
  ["<C-f>"] = { ":FzfLua grep_visual<CR>", "Grep visual" },
}, { mode = "v" })

wk.register({
  ["s"] = {
    name = "+Search",
    v = { ":FzfLua grep_visual<CR>", "Grep tags visual" }
  },
}, { prefix = "<Leader>", mode = "v" })
