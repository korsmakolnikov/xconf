(local wk (require :which-key))
(local dap (require :dap))
(wk.register {:C {:name :+Configuration :o [":e $MYVIMRC<CR>" "Open init.lua"]}
              :R {:d [":FzfLua deregister_ui_select<CR>"
                      "De-register fzf-lua with vim.ui.select"]
                  :name :+Fzf-lua
                  :r [":FzfLua register_ui_select<CR>"
                      "Register fzf-lua as UI Interface for vim.ui.select"]}
              :S {:name :+Snippy :y ["<Plug>(snippy-cut-text)" "Cut text"]}
              :b {:d [":bd<CR>" :Delete] :name :+Buffer}
              :c {:a [":FzfLua args<CR>" "Find args"]
                  :b [":FzfLua buffers<CR>" "Find buffers"]
                  :f [":FzfLua files<CR>" "Find files"]
                  :h [":FzfLua oldfiles<CR>" "Find in history"]
                  :l {:b [":FzfLua blines<CR>" "Find better lines"]
                      :i [":FzfLua lines<CR>" "Find lines"]
                      :l [":FzfLua loclist<CR>" "Find location"]
                      :name "+Locations & lines"
                      :s [":FzfLua loclist_stack<CR>" "Find location stack"]}
                  :name "+Fzf Commands"
                  :q {:name :Quickfix
                      :q [":FzfLua quickfix<CR>" "Find quickfix"]
                      :s [":FzfLua quickfix_stack<CR>" "Find quickfix stack"]}
                  :t [":FzfLua tabs<CR>" "Find tabs"]}
              :d {:B [(dap.toggle_breakpoint) "Toggle breakpoint"]
                  :C [(dap.continue) "Dap continue"]
                  :R [":lua require'dap'.repl.open()<CR>" :REPL]
                  :b [":FzfLua dap_breakpoints<CR>" "List breakpoints"]
                  :c [":FzfLua dap_commands<CR>" "DAP commands"]
                  :f [":FzfLua dap_frames<CR>" "Active session jump to frame"]
                  :name :+DAP
                  :o [":FzfLua dap_configurations<CR>" "DAP configurations"]
                  :v [":FzfLua dap_variables<CR>" "Active session variables"]}
              :g {:C [":FzfLua git_bcommits<CR>" "Commits buffer"]
                  :S [":FzfLua git_stash<CR>" :Stash]
                  :b [":FzfLua git_branches<CR>" :Branches]
                  :c [":FzfLua git_commits<CR>" "Commits project"]
                  :f [":FzfLua git_files<CR>" "Find versioned files"]
                  :name :+Git
                  :s [":FzfLua git_status<CR>" :Status]
                  :t [":FzfLua git_tags<CR>" :Tags]
                  :y ["<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>"
                      :Gitlinker]}
              :i {:b [":FzfLua complete_bline<CR>"
                      "Complete line (current buffer)"]
                  :f [":FzfLua complete_file<CR>" "Complete file under cursor"]
                  :l [":FzfLua complete_line<CR>"
                      "Complete line (all buffers)"]
                  :name :+Completition
                  :p [":FzfLua complete_path<CR>" "Complete path under cursor"]}
              :l {:D [":FzfLua lsp_declarations<CR>" "Find declaration"]
                  :F [":lua vim.lsp.buf.formatting_sync(nil, 5000)<CR>"
                      "Sync buffer format"]
                  :R ["<cmd>lua vim.lsp.buf.rename()<CR>" "Rename symbol"]
                  :S [":FzfLua lsp_workspace_symbols<CR>"
                      "Find Workspace symbols"]
                  :a [":FzfLua lsp_code_actions<CR>" "Find code actions"]
                  :c {:i [":FzfLua lsp_incoming_calls<CR>" "Incoming calls"]
                      :name :+Calls
                      :o [":FzfLua lsp_outgoing_calls<CR>" "Outgoing calls"]}
                  :d [":FzfLua lsp_definitions<CR>" "Find definition"]
                  :e {:f [":lua vim.diagnostic.open_float()<CR>" "Error float"]
                      :n [":lua vim.diagnostic.goto_next()<CR>" "Next error"]
                      :name :+Diagnostic
                      :p [":lua vim.diagnostic.goto_prev()<CR>"
                          "Previous error"]}
                  :f [":FzfLua lsp_finder<CR>"
                      "All LSP locations combined view"]
                  :h {:h ["<cmd>lua vim.lsp.buf.hover()<CR>" "Lsp hover"]
                      :name :+Helper
                      :s ["<cmd>lua vim.lsp.buf.signature_help()<CR>"
                          "Signature help"]}
                  :i [":FzfLua lsp_implementations<CR>" "Find implementation"]
                  :n {:D ["<cmd>lua vim.lsp.buf.declaration()<CR>"
                          "Jump to declaration"]
                      :d ["<cmd>lua vim.lsp.buf.definition()<CR>"
                          "Jump to definition"]
                      :i ["<cmd>lua vim.lsp.buf.implementation()<CR>"
                          "Jump to implementation"]
                      :name :+Nav}
                  :name :+LSP
                  :r [":FzfLua lsp_references<CR>" "Find references"]
                  :s [":FzfLua lsp_document_symbols<CR>" "Find symbols"]
                  :t [":FzfLua lsp_typedefs<CR>" "Find type definition"]
                  :w {:name :+Workspace
                      :s [":FzfLua lsp_live_workspace_symbols<CR>"
                          "Find symbols"]
                      :x [":FzfLua diagnostics_workspace<CR>"
                          "Find diagnostic"]}
                  :x [":FzfLua diagnostics_document<CR>" "Find diagnostic"]}
              :m {:? [":FzfLua man_pages<CR>" "Man pages"]
                  :H [":FzfLua command_history<CR>" "Commands history"]
                  :a [":FzfLua autocmds<CR>" :Autocommands]
                  :b [":FzfLua builtin<CR>" "Fzf-lua builtin commands"]
                  :c [":FzfLua commands<CR>" "Nvim commands"]
                  :e [":FzfLua registers<CR>" :Registers]
                  :f [":FzfLua filetypes<CR>" :Filetypes]
                  :g [":FzfLua changes<CR>" :Changes]
                  :h [":FzfLua help_tags<CR>" "Help tags"]
                  :j [":FzfLua jumps<CR>" :Jumps]
                  :k [":FzfLua keymaps<CR>" "Key mapping"]
                  :l [":FzfLua highlights<CR>" "Highlight groups"]
                  :m [":FzfLua marks<CR>" :Marks]
                  :n [":FzfLua menus<CR>" :Menus]
                  :name "+Fzf Misc"
                  :o [":FzfLua colorschemes<CR>" "Color schemas"]
                  :p [":FzfLua profiles<CR>" "Fzf-lua configuration profiles"]
                  :r [":FzfLua resume<CR>" "Resume last command/query"]
                  :s [":FzfLua search_history<CR>" ""]
                  :t [":FzfLua tagstack<CR>" :Tags]
                  :x [":FzfLua spell_suggest<CR>" "Spelling suggestions"]
                  :z [":FzfLua packadd<CR>" :Packadd]}
              :n {:b [":Neotree buffers toggle=true<CR>" "Neotree buffers"]
                  :g [":Neotree git_status position=right toggle=true<CR>"
                      "Neotree git status"]
                  :n [":Neotree toggle=true<CR>" "Neotree toggle"]
                  :name :+Neotree}
              :s {:<C-l> [":lua require('fzf-lua').files({ resume = true })<CR>"
                          "Resume file search"]
                  :<C-s> [":FzfLua grep_cword<CR>" "Grep word under cursor"]
                  :G {:C [":FzfLua lgrep_curbuf<CR>" ""]
                      :W [":FzfLua grep_cWORD<CR>" "Grep WORD under cursor"]
                      :c [":FzfLua grep_curbuf<CR>" ""]
                      :g [":FzfLua grep<CR>" :Grep]
                      :l [":FzfLua grep_last<CR>" "Grep resume"]
                      :name :+Grep
                      :p [":FzfLua grep_project<CR>" "Grep project"]
                      :v [":FzfLua grep_visual<CR>" "Visual grep"]
                      :w [":FzfLua grep_cword<CR>" "Grep word under cursor"]}
                  :b [":FzfLua live_grep_glob<CR>" "Live grep glob"]
                  :g [":FzfLua live_grep<CR>" "Live grep project"]
                  :n [":FzfLua live_grep_native<CR>" "Live grep native"]
                  :name :+Search
                  :r [":FzfLua live_grep_resume<CR>" "Live grep resume"]}
              :t {:SW [":FzfLua tags_grep_cWORD<CR>" "Grep WORD under cursor"]
                  :Sp [":FzfLua tags_grep<CR>" "Grep project tags"]
                  :Sw [":FzfLua tags_grep_cword<CR>" "Grep word under cursor"]
                  :b [":FzfLua btags<CR>" "Find tags buffer"]
                  :g [":FzfLua tags_live_grep<CR>" "Live grep"]
                  :name :+Tags
                  :p [":FzfLua tags<CR>" "Find tags project"]}
              :y [":let @+=@%<CR>" "Yank file path"]}
             {:prefix :<Leader>})
(wk.register {:<C-c> [":lua require'oil_manager'.toggle_on_current_folder()<CR>"
                      "Oil current directory"]
              :<C-f> [":lua require'oil_manager'.toggle_on_root_folder()<CR>"
                      :Oil]
              :<S-ESC> [":noh<CR>" "No highlights"]
              :<S-TAB> [":BufferLineCyclePrev<CR>" "Previous tab"]
              :<TAB> [":BufferLineCycleNext<CR>" "Next tab"]
              "\\" [":Neotree reveal<cr>" :Neotree]})
(wk.register {:<C-f> [":FzfLua grep_visual<CR>" "Grep visual"]
              :<S-Tab> [:<gv :S-Tab]
              :<Tab> [">gv |" :Tab]} {:mode :v})
(wk.register {:s {:name :+Search
                  :v [":FzfLua grep_visual<CR>" "Grep tags visual"]}}
             {:mode :v :prefix :<Leader>})
(wk.register {:<S-Tab> [:<gv :S-Tab] :<Tab> [">gv |" :Tab]} {:mode :x})	
