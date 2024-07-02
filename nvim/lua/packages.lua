local lazy = require("lazy")
local function _1_()
  local d = require("external_dependencies")
  d.setup()
  return d.lsp()
end
local function _2_()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
  return (require("which-key")).setup({ spelling = { enabled = true, suggestions = 20 } })
end

print("installing packages")
return lazy.setup(
  {
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
    spec = {
      "acro5piano/nvim-format-buffer",
      "udayvir-singh/tangerine.nvim",
      "udayvir-singh/hibiscus.nvim",
      "nvim-lua/plenary.nvim",
      { "neovim/nvim-lspconfig",          dependencies = { "folke/neodev.nvim", "lvimuser/lsp-inlayhints.nvim", "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "hrsh7th/cmp-buffer", "hrsh7th/cmp-vsnip", "hrsh7th/cmp-cmdline", "f3fora/cmp-spell", "ray-x/cmp-treesitter", "onsails/lspkind.nvim", "amarakon/nvim-cmp-buffer-lines", "nvim-lua/lsp-status.nvim" } },
      "nvim-treesitter/nvim-treesitter",
      { "elixir-tools/elixir-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" },                                                                                                                                                                                                                                                                                                tag = "stable" },
      { "folke/which-key.nvim",           lazy = false },
      { "williamboman/mason.nvim",        dependencies = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },                                                                                                                                                                                                                                       config = _1_ },
      "terrortylor/nvim-comment",
      { "nvim-neotest/neotest",     dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter" } },
      "ray-x/go.nvim",
      "ray-x/guihua.lua",
      "bfredl/nvim-luadev",
      "akinsho/bufferline.nvim",
      "lewis6991/impatient.nvim",
      "stevearc/oil.nvim",
      { "SirZenith/oil-vcs-status", dependencies = { "stevearc/oil.nvim" } },
      { "ruifm/gitlinker.nvim",     dependencies = { "stevearc/oil.nvim" } },
      "tpope/vim-fugitive",
      "kyazdani42/nvim-web-devicons",
      "ryanoasis/vim-devicons",
      "MunifTanjim/nui.nvim",
      "rktjmp/lush.nvim",
      "blueshirts/darcula",
      "rakr/vim-one",
      "navarasu/onedark.nvim",
      { "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
      { "junegunn/fzf",              build = "./install --bin" },
      "ibhagwan/fzf-lua",
      "junegunn/goyo.vim",
      { "folke/which-key.nvim",  config = _2_ },
      { "mfussenegger/nvim-dap", dependencies = { "rcarriga/nvim-dap-ui", "mxsdev/nvim-dap-vscode-js" } },
      { "dcampos/nvim-snippy",   dependencies = { "honza/vim-snippets", "dcampos/cmp-snippy" } }
    }
  })
