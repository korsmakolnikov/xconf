return require('packer').startup(function()
  use {'savq/paq-nvim', opt = true}

  -- Comment
  use "terrortylor/nvim-comment"
  -- Buffer utilities
  use 'kazhala/close-buffers.nvim'
  -- Filetree
  use {'kyazdani42/nvim-web-devicons'}
  use {'MunifTanjim/nui.nvim'} 
  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v1.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim"
    },
    config = function ()
      -- See ":help neo-tree-highlights" for a list of available highlight groups
      vim.cmd([[
        hi link NeoTreeDirectoryName Directory
        hi link NeoTreeDirectoryIcon NeoTreeDirectoryName
      ]])

      require("neo-tree").setup({
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
          },
          icon = {
            folder_closed = "|>",
            folder_open = "=>",
            folder_empty = "_",
            default = "*",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
          },
          git_status = {
            highlight = "NeoTreeDimText", -- if you remove this the status will be colorful
          },
        },
        filesystem = {
          filters = { --These filters are applied to both browsing and searching
            show_hidden = true,
            respect_gitignore = true,
          },
          follow_current_file = false, -- This will find and focus the file in the active buffer every
                                       -- time the current file is changed while the tree is open.
          use_libuv_file_watcher = false, -- This will use the OS level file watchers
                                          -- to detect changes instead of relying on nvim autocmd events.
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                -- "open_split",  -- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          window = {
            position = "float",
            -- width = 60,
            mappings = {
              ["<2-LeftMouse>"] = "open",
              ["<cr>"] = "open",
              ["S"] = "open_split",
              ["s"] = "open_vsplit",
              ["C"] = "close_node",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["I"] = "toggle_gitignore",
              ["R"] = "refresh",
              ["/"] = "fuzzy_finder",
              --["/"] = "filter_as_you_type", -- this was the default until v1.28
              --["/"] = "none" -- Assigning a key to "none" will remove the default mapping
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["a"] = "add",
              ["d"] = "delete",
              ["r"] = "rename",
              ["c"] = "copy_to_clipboard",
              ["x"] = "cut_to_clipboard",
              ["p"] = "paste_from_clipboard",
              ["m"] = "move", -- takes text input for destination
              ["q"] = "close_window",
            }
          }
        },
        buffers = {
          show_unloaded = true,
          window = {
            position = "left",
            mappings = {
              ["<2-LeftMouse>"] = "open",
              ["<cr>"] = "open",
              ["S"] = "open_split",
              ["s"] = "open_vsplit",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["R"] = "refresh",
              ["a"] = "add",
              ["d"] = "delete",
              ["r"] = "rename",
              ["c"] = "copy_to_clipboard",
              ["x"] = "cut_to_clipboard",
              ["p"] = "paste_from_clipboard",
              ["bd"] = "buffer_delete",
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["<2-LeftMouse>"] = "open",
              ["<cr>"] = "open",
              ["S"] = "open_split",
              ["s"] = "open_vsplit",
              ["C"] = "close_node",
              ["R"] = "refresh",
              ["d"] = "delete",
              ["r"] = "rename",
              ["c"] = "copy_to_clipboard",
              ["x"] = "cut_to_clipboard",
              ["p"] = "paste_from_clipboard",
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
      vim.cmd([[nnoremap \ :NeoTreeReveal<cr>]])
    end
  }

  -- Color schemes
  use {'rktjmp/lush.nvim'}
  use {'blueshirts/darcula'}
  use {'rakr/vim-one'}

  -- FZF
  use {'junegunn/fzf', run = './install --bin'}
  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  use {'numToStr/Comment.nvim'} -- "gc" to comment visual regions/lines

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
        height = 10, -- height of the trouble list when position is top or bottom
        width = 40, -- width of the list when position is left or right
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
  use {'simrat39/rust-tools.nvim'}

  -- Debugging
  use {'nvim-lua/plenary.nvim'}
  use {'mfussenegger/nvim-dap'}

  -- Lua
  use {'bfredl/nvim-luadev'}
  use {'rafcamlet/nvim-luapad'}
  use {'euclidianAce/BetterLua.vim'}
  use {'tjdevries/nlua.nvim'}
  use {'nvim-lua/completion-nvim'}

end)
