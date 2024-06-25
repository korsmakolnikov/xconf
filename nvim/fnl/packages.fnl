(print "loading packages")
(local lazy (require :lazy))

(fn s [] 
	(lazy.setup [
		      :udayvir-singh/tangerine.nvim
		      :udayvir-singh/hibiscus.nvim


    ;; CODING
          :nvim-lua/plenary.nvim

		{1    :neovim/nvim-lspconfig
          :dependencies [ :folke/neodev.nvim
                          :lvimuser/lsp-inlayhints.nvim
                          :hrsh7th/nvim-cmp
                          :hrsh7th/cmp-nvim-lsp
                          :hrsh7th/cmp-path
                          :hrsh7th/cmp-buffer
                          :hrsh7th/cmp-vsnip
                          :hrsh7th/cmp-cmdline
                          :f3fora/cmp-spell
                          :ray-x/cmp-treesitter
                          :onsails/lspkind.nvim
                          :amarakon/nvim-cmp-buffer-lines
                          :nvim-lua/lsp-status.nvim ]}

    ;; TODO
          :nvim-treesitter/nvim-treesitter

    {1    :elixir-tools/elixir-tools.nvim
          :dependencies [:nvim-lua/plenary.nvim]
          :tag :stable }

		{1 		:folke/which-key.nvim
		      :lazy 		false}

		{1		:williamboman/mason.nvim
          :dependencies 	[ :williamboman/mason-lspconfig.nvim :WhoIsSethDaniel/mason-tool-installer.nvim ]
          :config 	(fn [] 
                (local d (require :deps))
                (d.setup)
                (d.lsp))}

          :terrortylor/nvim-comment

    {1    :nvim-neotest/neotest
          :dependencies [:nvim-neotest/nvim-nio :nvim-lua/plenary.nvim :antoinemadec/FixCursorHold.nvim :nvim-treesitter/nvim-treesitter]}

    ;; GOLANG
          :ray-x/go.nvim
          :ray-x/guihua.lua ;;recommended if need floating window support 

    ;; LUA
          :bfredl/nvim-luadev

    ;; ?
	:akinsho/bufferline.nvim
        :lewis6991/impatient.nvim

    ;; OIL
          :stevearc/oil.nvim  
    {1    :SirZenith/oil-vcs-status
          :dependencies [ :stevearc/oil.nvim ]
    }

    ;; GIT
    {1    :ruifm/gitlinker.nvim
          :dependencies [ :stevearc/oil.nvim ]
          }
          :tpope/vim-fugitive

    ;; VISUAL
          :kyazdani42/nvim-web-devicons
          :ryanoasis/vim-devicons
          :MunifTanjim/nui.nvim
          :rktjmp/lush.nvim
          :blueshirts/darcula
          :rakr/vim-one
          :navarasu/onedark.nvim

    {1    :nvim-lualine/lualine.nvim
          :dependencies [:kyazdani42/nvim-web-devicons]}

    ;; FZF
    {1    :junegunn/fzf 
          :build "./install --bin"
          }
          :ibhagwan/fzf-lua

    ;; ZEN MODE
          :junegunn/goyo.vim

    ;; BINDINGS
    {1    :folke/which-key.nvim
          :config (fn []
          (set vim.o.timeout true)
          (set vim.o.timeoutlen 300)
          ((. (require :which-key) :setup) {:spelling {:enabled true
                                                       :suggestions 20}}))}
    ;; DEBUGGING
    {1    :mfussenegger/nvim-dap
          :dependencies [:rcarriga/nvim-dap-ui :mxsdev/nvim-dap-vscode-js]}

    ;; SNIPPET
    {1    :dcampos/nvim-snippy
          :dependencies [:honza/vim-snippets :dcampos/cmp-snippy]}


		]))

{:setup s}
