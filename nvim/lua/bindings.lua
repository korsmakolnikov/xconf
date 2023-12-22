local vim = vim

local vimp = vim.api.nvim_set_keymap
local key_opts = { noremap = true, silent = true, buffer = bufnr }

--local oil_manager = require "oil_manager"

-- Mappings.
-- Filetree mapping
vimp('n', '<F2>', ":lua require'oil_manager'.toggle_on_root_folder()<CR>", key_opts)
vimp('n', '<C-c>', ":lua require'oil_manager'.toggle_on_current_folder()<CR>", key_opts)
vimp('n', '<F3>', ':Neotree buffers toggle=true<CR>', key_opts)
vimp('n', '<F4>', ':Neotree git_status position=right toggle=true<CR>', key_opts)
vimp('n', '<F5>', ':Neotree toggle=true<CR>', key_opts)
-- Buffers mapping
-- Tab mapping
vimp('n', '<TAB>', ':BufferLineCycleNext<CR>', key_opts)
vimp('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', key_opts)
vimp('x', '<Tab>', '>gv |', key_opts)
vimp('x', '<S-Tab>', '<gv', key_opts)

-- FZF mapping
-- git is under 'g' except list files that is bound to leader-space
-- rg is under 'r' except grep project that is bound to leader-/
-- history is under 'h'
-- vimp('n', '<Leader>.', ":FzfLua oldfiles<CR>", key_opts)
-- vimp('n', '<Leader>hs', ":FzfLua search_history<CR>", key_opts)
-- vimp('n', '<Leader>hc', ":FzfLua command_history<CR>", key_opts)
-- vimp('n', '<Leader>:', ":FzfLua resume<CR>", key_opts)
-- vimp('n', '<Leader>,', ":FzfLua buffers<CR>", key_opts)
-- vimp('n', '<Leader>m', ":FzfLua marks<CR>", key_opts)
-- vimp('n', '<Leader>k', ":FzfLua keymaps<CR>", key_opts)
-- vimp('n', '<Leader>r', ":FzfLua registers<CR>", key_opts)
-- vimp('n', '<Leader>j', ":FzfLua jump<CR>", key_opts)
-- vimp('n', '<Leader>f', ":FzfLua files<CR>", { noremap = true, silent = true })
-- vimp('n', '<Leader><Space>', ":FzfLua git_files<CR>", key_opts)
-- -- Git
-- vimp('n', '<Leader>g', ":FzfLua git_bcommits<CR>", key_opts)
-- vimp('n', '<Leader>gs', ":FzfLua git_status<CR>", key_opts)
-- vimp('n', '<Leader>gp', ":FzfLua git_commits<CR>", key_opts)
-- vimp('n', '<Leader>gb', ":FzfLua git_branches<CR>", key_opts)
-- vimp('n', '<Leader>gc', ":FzfLua changes<CR>", key_opts)
-- -- FZF rg
-- vimp('n', '<Leader>rl', ":FzfLua grep_curbuf<CR>", key_opts)
-- vimp('n', '<Leader>/',
--   ":lua require'fzf-lua'.live_grep({ cmd = \"rg --sort=path --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e\"})<CR>'",
--   key_opts)
-- vimp('n', '<Leader>/h',
--   ":lua require'fzf-lua'.live_grep({ cmd = \"rg --sort=path --hidden --follow --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e\"})<CR>'",
--   key_opts)

-- copy filepath to clipboard
vimp('n', '<Leader>F', ":let @+=@%<CR>", key_opts)

-- LSP Mappings
-- All lsp function are under 'a'
-- All lsp diagnostic are under 'd'
-- All trouble function are under function keys

vimp('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', key_opts)
vimp('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', key_opts)
vimp('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', key_opts)
vimp('n', '<S-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', key_opts)
vim.keymap.set("n", "<C-space>", '<cmd>lua vim.lsp.buf.hover()<CR>', key_opts)
vim.api.nvim_set_keymap('n', '<Leader>mv', '<cmd>lua vim.lsp.buf.rename()<CR>', key_opts)
-- vimp('n', '<Leader>a', ":FzfLua lsp_code_actions<CR>", key_opts)
-- vimp('n', '<Leader>Ad', ":FzfLua lsp_definitions<CR>", key_opts)
-- vimp('n', '<Leader>AD', ":FzfLua lsp_declarations<CR>", key_opts)
-- vimp('n', '<Leader>At', ":FzfLua lsp_typedefs<CR>", key_opts)
-- vimp('n', '<Leader>Ai', ":FzfLua lsp_implementations<CR>", key_opts)
-- vimp('n', '<Leader>Ar', ":FzfLua lsp_references<CR>", key_opts)
-- vimp('n', '<Leader>As', ":FzfLua lsp_document_symbols<CR>", key_opts)
-- vimp('n', '<Leader>Aws', ":FzfLua lsp_workspace_symbols<CR>", key_opts)
-- vimp('n', '<Leader>d', ":FzfLua lsp_document_diagnostics<CR>", key_opts)
-- vimp('n', '<Leader>da', ":FzfLua lsp_workspace_diagnostics<CR>", key_opts)
vimp('n', '<Leader>e', ':lua vim.diagnostic.goto_next()<CR>', key_opts)
vimp('n', '<Leader>z', ':lua vim.diagnostic.open_float()<CR>', key_opts)
vimp('n', '<Leader>E', ':lua vim.diagnostic.goto_prev()<CR>', key_opts)
vimp('n', '<Leader>Af', ':lua vim.lsp.buf.formatting_sync(nil, 5000)<CR>', key_opts)

-- General mapping
vimp('n', '<F12>', ':e $MYVIMRC<CR>', key_opts)
vimp('n', '<S-F12>', ':luafile %<CR>', key_opts)

-- FZF new mapping
--
-- commands
vimp('n', '<Leader>ca', ":FzfLua args<CR>", key_opts)            -- open buffers
vimp('n', '<Leader>cb', ":FzfLua buffers<CR>", key_opts)         -- find or fd on a path
vimp('n', '<Leader>cf', ":FzfLua files<CR>", key_opts)           -- opened files history
vimp('n', '<Leader>ch', ":FzfLua oldfiles<CR>", key_opts)        -- quickfix list
vimp('n', '<Leader>cll', ":FzfLua loclist<CR>", key_opts)        -- quickfix stack
vimp('n', '<Leader>cls', ":FzfLua loclist_stack<CR>", key_opts)  -- location list
vimp('n', '<Leader>cli', ":FzfLua lines<CR>", key_opts)          -- location stack
vimp('n', '<Leader>clb', ":FzfLua blines<CR>", key_opts)         -- open buffers lines
vimp('n', '<Leader>cqq', ":FzfLua quickfix<CR>", key_opts)       -- current buffer lines
vimp('n', '<Leader>cqs', ":FzfLua quickfix_stack<CR>", key_opts) -- open tabs
vimp('n', '<Leader>ct', ":FzfLua tabs<CR>", key_opts)            -- argument list

-- search
vimp('n', '<Leader>Sg', ":FzfLua grep<CR>", key_opts)             -- search for a pattern with grep or rg
vimp('n', '<Leader>Sl', ":FzfLua grep_last<CR>", key_opts)        -- run search again with the last pattern
vimp('n', '<Leader>Sw', ":FzfLua grep_cword<CR>", key_opts)       -- search word under cursor
vimp('n', '<Leader>SW', ":FzfLua grep_cWORD<CR>", key_opts)       -- search WORD under cursor
vimp('n', '<Leader>Sv', ":FzfLua grep_visual<CR>", key_opts)      -- search visual selection
vimp('n', '<Leader>Sp', ":FzfLua grep_project<CR>", key_opts)     -- search all project lines (fzf.vim's :Rg)
vimp('n', '<Leader>Sc', ":FzfLua grep_curbuf<CR>", key_opts)      -- search current buffer lines
vimp('n', '<Leader>SC', ":FzfLua lgrep_curbuf<CR>", key_opts)     -- live grep current buffer
vimp('n', '<Leader>sg', ":FzfLua live_grep<CR>", key_opts)        -- live grep current project
vimp('n', '<Leader>sr', ":FzfLua live_grep_resume<CR>", key_opts) -- live grep continue last search
vimp('n', '<Leader>sb', ":FzfLua live_grep_glob<CR>", key_opts)   -- live_grep with rg --glob support
vimp('n', '<Leader>sn', ":FzfLua live_grep_native<CR>", key_opts) -- performant version of live_grep
vimp('n', '<C-f>', ":FzfLua grep_cword<CR>", key_opts)
vimp('v', '<C-f>', ":FzfLua grep_visual<CR>", key_opts)
vimp('n', '<C-l>', ":lua require('fzf-lua').files({ resume = true })<CR>", key_opts)

-- tags
vimp('n', '<Leader>tp', ":FzfLua tags<CR>", key_opts)              -- search project tags
vimp('n', '<Leader>tb', ":FzfLua btags<CR>", key_opts)             --search buffer tags
vimp('n', '<Leader>tSp', ":FzfLua tags_grep<CR>", key_opts)        --grep project tags
vimp('n', '<Leader>tSw', ":FzfLua tags_grep_cword<CR>", key_opts)  --tags_grep word under cursor
vimp('n', '<Leader>tSW', ":FzfLua tags_grep_cWORD<CR>", key_opts)  --tags_grep WORD under cursor
vimp('n', '<Leader>tSv', ":FzfLua tags_grep_visual<CR>", key_opts) -- tags_grep visual selection
vimp('n', '<Leader>tg', ":FzfLua tags_live_grep<CR>", key_opts)    -- live grep project tags

-- git
vimp('n', '<Leader>gf', ":FzfLua git_files<CR>", key_opts)    --git ls-files
vimp('n', '<Leader>gs', ":FzfLua git_status<CR>", key_opts)   -- git status
vimp('n', '<Leader>gc', ":FzfLua git_commits<CR>", key_opts)  --git commit log (project)
vimp('n', '<Leader>gC', ":FzfLua git_bcommits<CR>", key_opts) -- git commit log (buffer)
vimp('n', '<Leader>gb', ":FzfLua git_branches<CR>", key_opts) -- git branches
vimp('n', '<Leader>gt', ":FzfLua git_tags<CR>", key_opts)     -- git tags
vimp('n', '<Leader>gS', ":FzfLua git_stash<CR>", key_opts)    --git stash

-- LSP
vimp('n', '<Leader>lr', ":FzfLua lsp_references<CR>", key_opts)              -- References
vimp('n', '<Leader>ld', ":FzfLua lsp_definitions<CR>", key_opts)             --Definitions
vimp('n', '<Leader>lD', ":FzfLua lsp_declarations<CR>", key_opts)            -- Declarations
vimp('n', '<Leader>lt', ":FzfLua lsp_typedefs<CR>", key_opts)                -- Type Definitions
vimp('n', '<Leader>li', ":FzfLua lsp_implementations<CR>", key_opts)         --Implementations
vimp('n', '<Leader>ls', ":FzfLua lsp_document_symbols<CR>", key_opts)        -- Document Symbols
vimp('n', '<Leader>lS', ":FzfLua lsp_workspace_symbols<CR>", key_opts)       --Workspace Symbols
vimp('n', '<Leader>lws', ":FzfLua lsp_live_workspace_symbols<CR>", key_opts) -- Workspace Symbols (live query)
vimp('n', '<Leader>la', ":FzfLua lsp_code_actions<CR>", key_opts)            -- Code Actions
vimp('n', '<Leader>lci', ":FzfLua lsp_incoming_calls<CR>", key_opts)         -- Incoming Calls
vimp('n', '<Leader>lco', ":FzfLua lsp_outgoing_calls<CR>", key_opts)         -- Outgoing Calls
vimp('n', '<Leader>lf', ":FzfLua lsp_finder<CR>", key_opts)                  -- All LSP locations, combined view
vimp('n', '<Leader>lx', ":FzfLua diagnostics_document<CR>", key_opts)        -- Document Diagnostics
vimp('n', '<Leader>lwx', ":FzfLua diagnostics_workspace<CR>", key_opts)      --Workspace Diagnostics
vimp('n', '<Leader>lz', ":FzfLua lsp_document_diagnostics<CR>", key_opts)    -- alias to diagnostics_document
vimp('n', '<Leader>lwz', ":FzfLua lsp_workspace_diagnostics<CR>", key_opts)  --alias to diagnostics_workspace

-- Misc
vimp('n', '<Leader>mr', ":FzfLua resume<CR>", key_opts)          -- resume last command/query
vimp('n', '<Leader>mb', ":FzfLua builtin<CR>", key_opts)         --fzf-lua builtin commands
vimp('n', '<Leader>mp', ":FzfLua profiles<CR>", key_opts)        -- fzf-lua configuration profiles
vimp('n', '<Leader>mh', ":FzfLua help_tags<CR>", key_opts)       --help tags
vimp('n', '<Leader>m?', ":FzfLua man_pages<CR>", key_opts)       --man pages
vimp('n', '<Leader>mo', ":FzfLua colorschemes<CR>", key_opts)    -- color schemes
vimp('n', '<Leader>ml', ":FzfLua highlights<CR>", key_opts)      -- highlight groups
vimp('n', '<Leader>mc', ":FzfLua commands<CR>", key_opts)        -- neovim commands
vimp('n', '<Leader>mH', ":FzfLua command_history<CR>", key_opts) --command history
vimp('n', '<Leader>ms', ":FzfLua search_history<CR>", key_opts)  -- search history
vimp('n', '<Leader>mm', ":FzfLua marks<CR>", key_opts)           --:marks
vimp('n', '<Leader>mj', ":FzfLua jumps<CR>", key_opts)           --:jumps
vimp('n', '<Leader>mg', ":FzfLua changes<CR>", key_opts)         --:changes
vimp('n', '<Leader>me', ":FzfLua registers<CR>", key_opts)       --:registers
vimp('n', '<Leader>mt', ":FzfLua tagstack<CR>", key_opts)        -- :tags
vimp('n', '<Leader>ma', ":FzfLua autocmds<CR>", key_opts)        -- :autocmd
vimp('n', '<Leader>mk', ":FzfLua keymaps<CR>", key_opts)         --key mappings
vimp('n', '<Leader>mf', ":FzfLua filetypes<CR>", key_opts)       --filetypes
vimp('n', '<Leader>mn', ":FzfLua menus<CR>", key_opts)           --menus
vimp('n', '<Leader>mx', ":FzfLua spell_suggest<CR>", key_opts)   --spelling suggestions
vimp('n', '<Leader>mz', ":FzfLua packadd<CR>", key_opts)         --:packadd

-- Neovim api
vimp('n', '<Leader>nr', ":FzfLua register_ui_select<CR>", key_opts)   -- register fzf-lua as the UI interface for vim.ui.select
vimp('n', '<Leader>nd', ":FzfLua deregister_ui_select<CR>", key_opts) -- de-register fzf-lua with vim.ui.select

-- DAP
vimp('n', '<Leader>dc', ":FzfLua dap_commands<CR>", key_opts)       -- list,run nvim-dap builtin commands
vimp('n', '<Leader>do', ":FzfLua dap_configurations<CR>", key_opts) -- list,run debug configurations
vimp('n', '<Leader>db', ":FzfLua dap_breakpoints<CR>", key_opts)    --list,delete breakpoints
vimp('n', '<Leader>dv', ":FzfLua dap_variables<CR>", key_opts)      --active session variables
vimp('n', '<Leader>df', ":FzfLua dap_frames<CR>", key_opts)         -- active session jump to frame

-- completition
vimp('n', '<Leader>ip', ":FzfLua complete_path<CR>", key_opts)  --complete path under cursor (incl dirs)
vimp('n', '<Leader>if', ":FzfLua complete_file<CR>", key_opts)  --complete file under cursor (excl dirs)
vimp('n', '<Leader>il', ":FzfLua complete_line<CR>", key_opts)  --complete line (all open buffers)
vimp('n', '<Leader>ib', ":FzfLua complete_bline<CR>", key_opts) -- complete line (current buffer only)
