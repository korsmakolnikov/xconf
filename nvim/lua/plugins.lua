return require('packer').startup(function()
  use { 'savq/paq-nvim', opt = true }

  -- impatient optimize vim startup
  use 'lewis6991/impatient.nvim'

  -- Comment
  use "terrortylor/nvim-comment"

  -- Buffer utilities
  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }

  -- Filetree
  use {
    "stevearc/oil.nvim",
  }
  use {
    'SirZenith/oil-vcs-status',

    after = {
      "oil.nvim",
    },
  }
  use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  use { 'kyazdani42/nvim-web-devicons' }
  use { 'MunifTanjim/nui.nvim' }

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          position = "right",
          width = 50,
        },
        filesystem = {
          follow_current_file = {
            enable = false,
          },
        },
        buffers = {
          follow_current_file = {
            enable = true,
          },
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function(_)
              require("neo-tree.command").execute({ action = "close" })
            end
          },
        }
      })

      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end
  }

  -- Color schemes
  use { 'rktjmp/lush.nvim' }
  use { 'blueshirts/darcula' }
  use { 'rakr/vim-one' }
  -- use { 'projekt0n/github-nvim-theme' }
  use 'navarasu/onedark.nvim'

  -- FZF
  use { 'junegunn/fzf', run = './install --bin' }
  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    ensure_dependencies = true,
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- Goyo distraction free mode
  -- turn on with command :Goyo, turn off by :Goyo!
  use { 'junegunn/goyo.vim' }
  use { 'folke/zen-mode.nvim' }
  use { 'folke/twilight.nvim' }

  -- Git
  use { 'tpope/vim-fugitive' }

  -- which key
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Docker file syntax
  use { 'ekalinin/Dockerfile.vim' }

  -- Graphql syntax
  use { 'jparise/vim-graphql' }

  -- Toml
  use { 'cespare/vim-toml' }

  -- Status bar
  use {
    'nvim-lualine/lualine.nvim',
    ensure_dependencies = true,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    ensure_dependencies = true,
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "folke/neodev.nvim",
      "lvimuser/lsp-inlayhints.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-cmdline',
      'nvim-lua/lsp-status.nvim'
    }
  }
  -- Elixir syntax highlight :(
  use { 'nvim-treesitter/nvim-treesitter' }


  use({
    "Maan2003/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({
        virtual_text = false,
        only_current_line = true
      })
    end,
  })

  -- Debugging
  use 'nvim-lua/plenary.nvim'
  use { 'mfussenegger/nvim-dap',
    ensure_dependencies = true,
    requires = {
      "rcarriga/nvim-dap-ui",
      "mxsdev/nvim-dap-vscode-js",
    }
  }

  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    }
  }

  -- golang
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua' -- recommended if need floating window support

  -- Lua
  use { 'bfredl/nvim-luadev' }

  -- Snippet
  use {
    'dcampos/nvim-snippy',
    ensure_dependencies = true,
    requires = { 'honza/vim-snippets', 'dcampos/cmp-snippy' }
  }
end)
