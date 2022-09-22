return require('packer').startup(function()
  use {'savq/paq-nvim', opt = true}

  -- Comment
  use "terrortylor/nvim-comment"

  -- Buffer utilities
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  use 'kazhala/close-buffers.nvim'

  -- Filetree
  use {'kyazdani42/nvim-web-devicons'}
  use {'MunifTanjim/nui.nvim'} 
  use {
   "nvim-neo-tree/neo-tree.nvim",
     branch = "v2.x",
     requires = { 
       "nvim-lua/plenary.nvim",
       "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
       "MunifTanjim/nui.nvim",
       {
         -- only needed if you want to use the commands with "_with_window_picker" suffix
         's1n7ax/nvim-window-picker',
         tag = "v1.*",
         config = function()
           require'window-picker'.setup({
             autoselect_one = true,
             include_current = false,
             filter_rules = {
               -- filter using buffer options
               bo = {
                 -- if the file type is one of following, the window will be ignored
                 filetype = { 'neo-tree', "neo-tree-popup", "notify", "quickfix" },

                 -- if the buffer type is one of following, the window will be ignored
                 buftype = { 'terminal' },
               },
             },
             other_win_hl_color = '#e35e4f',
           })
         end,
       }
     },
     config = function ()
       -- Unless you are still migrating, remove the deprecated commands from v1.x
       vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

       -- If you want icons for diagnostic errors, you'll need to define them somewhere:
       vim.fn.sign_define("DiagnosticSignError",
         {text = " ", texthl = "DiagnosticSignError"})
       vim.fn.sign_define("DiagnosticSignWarn",
         {text = " ", texthl = "DiagnosticSignWarn"})
       vim.fn.sign_define("DiagnosticSignInfo",
         {text = " ", texthl = "DiagnosticSignInfo"})
       vim.fn.sign_define("DiagnosticSignHint",
         {text = "", texthl = "DiagnosticSignHint"})
       -- NOTE: this is changed from v1.x, which used the old style of highlight groups
       -- in the form "LspDiagnosticsSignWarning"

       require("neo-tree").setup({
         close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
         popup_border_style = "rounded",
         enable_git_status = true,
         enable_diagnostics = true,
         sort_case_insensitive = false, -- used when sorting files and directories in the tree
         sort_function = nil , -- use a custom function for sorting files and directories in the tree 
         -- sort_function = function (a,b)
         --       if a.type == b.type then
         --           return a.path > b.path
         --       else
         --           return a.type > b.type
         --       end
         --   end , -- this sorts files and directories descendantly
         default_component_configs = {
           container = {
             enable_character_fade = true
           },
           indent = {
             indent_size = 2,
             padding = 1, -- extra padding on left hand side
             -- indent guides
             with_markers = true,
             indent_marker = "│",
             last_indent_marker = "└",
             highlight = "NeoTreeIndentMarker",
             -- expander config, needed for nesting files
             with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
             expander_collapsed = "",
             expander_expanded = "",
             expander_highlight = "NeoTreeExpander",
           },
           icon = {
             folder_closed = "",
             folder_open = "",
             folder_empty = "ﰊ",
             -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
             -- then these will never be used.
             default = "*",
             highlight = "NeoTreeFileIcon"
           },
           modified = {
             symbol = "[+]",
             highlight = "NeoTreeModified",
           },
           name = {
             trailing_slash = false,
             use_git_status_colors = true,
             highlight = "NeoTreeFileName",
           },
           git_status = {
             symbols = {
               -- Change type
               added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
               modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
               deleted   = "✖",-- this can only be used in the git_status source
               renamed   = "",-- this can only be used in the git_status source
               -- Status type
               untracked = "",
               ignored   = "",
               unstaged  = "",
               staged    = "",
               conflict  = "",
             }
           },
         },
         window = {
           position = "right",
           width = 50,
           mapping_options = {
             noremap = true,
             nowait = true,
           },
           mappings = {
             ["<space>"] = { 
                 "toggle_node", 
                 nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
             },
             ["<2-LeftMouse>"] = "open",
             ["<cr>"] = "open",
             ["S"] = "open_split",
             ["s"] = "open_vsplit",
             -- ["S"] = "split_with_window_picker",
             -- ["s"] = "vsplit_with_window_picker",
             ["t"] = "open_tabnew",
             ["w"] = "open_with_window_picker",
             ["C"] = "close_node",
             ["z"] = "close_all_nodes",
             --["Z"] = "expand_all_nodes",
             ["a"] = { 
               "add",
               -- some commands may take optional config options, see `:h neo-tree-mappings` for details
               config = {
                 show_path = "none" -- "none", "relative", "absolute"
               }
             },
             ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
             ["d"] = "delete",
             ["r"] = "rename",
             ["y"] = "copy_to_clipboard",
             ["x"] = "cut_to_clipboard",
             ["p"] = "paste_from_clipboard",
             ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
             -- ["c"] = {
             --  "copy",
             --  config = {
             --    show_path = "none" -- "none", "relative", "absolute"
             --  }
             --}
             ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
             ["q"] = "close_window",
             ["R"] = "refresh",
             ["?"] = "show_help",
             ["<"] = "prev_source",
             [">"] = "next_source",
           }
         },
         nesting_rules = {},
         filesystem = {
           filtered_items = {
             visible = false, -- when true, they will just be displayed differently than normal items
             hide_dotfiles = true,
             hide_gitignored = true,
             hide_hidden = true, -- only works on Windows for hidden files/directories
             hide_by_name = {
               --"node_modules"
             },
             hide_by_pattern = { -- uses glob style patterns
               --"*.meta"
             },
             never_show = { -- remains hidden even if visible is toggled to true
               --".DS_Store",
               --"thumbs.db"
             },
           },
           follow_current_file = false, -- This will find and focus the file in the active buffer every
                                        -- time the current file is changed while the tree is open.
           group_empty_dirs = false, -- when true, empty folders will be grouped together
           hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                   -- in whatever position is specified in window.position
                                 -- "open_current",  -- netrw disabled, opening a directory opens within the
                                                   -- window like netrw would, regardless of window.position
                                 -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
           use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                           -- instead of relying on nvim autocmd events.
           window = {
             mappings = {
               ["<bs>"] = "navigate_up",
               ["."] = "set_root",
               ["H"] = "toggle_hidden",
               ["/"] = "fuzzy_finder",
               ["D"] = "fuzzy_finder_directory",
               ["f"] = "filter_on_submit",
               ["<c-x>"] = "clear_filter",
               ["[g"] = "prev_git_modified",
               ["]g"] = "next_git_modified",
             }
           }
         },
         buffers = {
           follow_current_file = true, -- This will find and focus the file in the active buffer every
                                        -- time the current file is changed while the tree is open.
           group_empty_dirs = true, -- when true, empty folders will be grouped together
           show_unloaded = true,
           window = {
             mappings = {
               ["bd"] = "buffer_delete",
               ["<bs>"] = "navigate_up",
               ["."] = "set_root",
             }
           },
         },
         git_status = {
           window = {
             position = "float",
             mappings = {
               ["A"]  = "git_add_all",
               ["gu"] = "git_unstage_file",
               ["ga"] = "git_add_file",
               ["gr"] = "git_revert_file",
               ["gc"] = "git_commit",
               ["gp"] = "git_push",
               ["gg"] = "git_commit_and_push",
             }
           }
         }
       })

       vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
     end
  }

  -- Color schemes
  use {'rktjmp/lush.nvim'}
  use {'blueshirts/darcula'}
  use {'rakr/vim-one'}
  use {'projekt0n/github-nvim-theme'}

  -- FZF
  use {'junegunn/fzf', run = './install --bin'}
  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- Goyo distraction free mode
  -- turn on with command :Goyo, turn off by :Goyo!
  use {'junegunn/goyo.vim'}

  -- Git
  use {'airblade/vim-gitgutter'} -- TODO is it necessary?
  use {'tpope/vim-fugitive'}

  -- Docker file syntax
  use {'ekalinin/Dockerfile.vim'}

  -- Graphql syntax
  use {'jparise/vim-graphql'}

  -- Toml
  use {'cespare/vim-toml'}

  -- Status bar
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Nvim reloading
  use 'famiu/nvim-reload'

  -- LSP
  -- Collection of common configurations for the Nvim LSP client
  use {'neovim/nvim-lspconfig'}
  -- Completion framework
  use {'hrsh7th/nvim-cmp'}
  -- LSP completion source for nvim-cmp
  use {'hrsh7th/cmp-nvim-lsp'}
  -- LSP status for status bar
  use {'nvim-lua/lsp-status.nvim'}
  -- Snippet completion source for nvim-cmp
  use {'hrsh7th/cmp-vsnip'}
  -- Other usefull completion sources
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-buffer'}
  -- Trouble
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        position = "right", -- position of the list can be: bottom, top, left, right
        --height = 12, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "=>", -- icon used for open folds
        fold_closed = "|>", -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
            open_split = { "<c-x>" }, -- open buffer in new split
            open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
            open_tab = { "<c-t>" }, -- open buffer in new tab
            jump_close = {"o"}, -- jump to the diagnostic and close the list
            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "P", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = "p", -- preview the diagnostic location
            close_folds = {"zM", "zm"}, -- close all folds
            open_folds = {"zR", "zr"}, -- open all folds
            toggle_fold = {"zA", "za"}, -- toggle fold of current file
            previous = "k", -- preview item
            next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
        signs = {
            -- icons / text used for a diagnostic
            error = "!",
            warning = "?",
            hint = "",
            information = "",
            other = "﫠"
        },
        use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    }
    end
  }
  -- Snippet engine
  use {'hrsh7th/vim-vsnip'}
  use {'nvim-lua/popup.nvim'}

  -- Rust specific
  use 'simrat39/rust-tools.nvim'

  -- Debugging
  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

  -- Lua
  use {'bfredl/nvim-luadev'}
  use {'rafcamlet/nvim-luapad'}
  use {'euclidianAce/BetterLua.vim'}
  use {'tjdevries/nlua.nvim'}
  use {'nvim-lua/completion-nvim'}
end)
