local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
local vimp = vim.api.nvim_set_keymap

-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

require('plugins')

vim.cmd('colorscheme darcula')
vim.g.mapleader = ","

local set = vim.opt
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

vim.o.cc = '80'
vim.o.virtualedit = 'all'
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.autoindent = true
vim.o.number = true
vim.o.wildmode = 'longest,list'
vim.o.syntax = 'on'
vim.o.mouse = 'a'
vim.o.clipboard='unnamedplus'
vim.o.ttyfast = true
vim.o.backupdir = '~/.config/nvim/backup'
vim.o.cmdheight = 4
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess=vim.o.shortmess..'c'
vim.g.loaded_python_provider = '0'
vim.g.goyo_width = '80'

-- autogroup provides
-- TODO autoformat files!
function _G.quicksearch()
  local cword = vim.fn.expand('<cword>')
  local cmd = [[:Rg ]]..cword
  print(cmd)
  execute(cmd)
end

-- Filetree mapping
vimp('n', '<F2>', ':NeoTreeFocusToggle<CR>', {noremap = true, silent = true})
vimp('n', '<C-c>', ':NeoTreeReveal!<CR>', {noremap = true, silent = true})
-- Buffers mapping
vimp('n', '<TAB>', ':bn<CR> :redraw<CR>', {noremap = true, silent = true})
vimp('n', '<S-TAB>', ':bp<CR> :redraw<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>bd', ':bd<CR> |', {noremap = true, silent = true})
vimp('n', '<Leader>bK', ':bufdo bd<CR> |', {noremap = true, silent = true})
-- Tab mapping
vimp('x', '<Tab>', '>gv |', {noremap = true, silent = true})
vimp('x', '<S-Tab>', '<gv', {noremap = true, silent = true})
-- FZF mapping
vimp('n', '<Leader>.', ':History<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>./', ':History/<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>.:', ':History:<CR>', {noremap = true, silent = true})
vimp('n', '<Leader><Leader>', ':Buffers<CR>', {noremap = true, silent = true})
vimp('n', '<Leader><Space>', ':GFiles<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>m', ':Marks<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>l', ':BLines<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>ff', ':Files<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>L', ':Lines<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>g', ':BCommits<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>G', ':Commits<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>/', ':Rg<CR>', {noremap = true, silent = true})
-- TODO this will be deprecated switching to fzf-lua
vimp('n', '<C-f>', ':lua quicksearch()<CR>', {noremap = true, silent = true})

-- LSP Mappings
-- All lsp function are under 'a'
-- All lsp diagnostic are under 'd'
-- All trouble function are under 't'
vimp('n', '<Leader>a', ':CodeActions<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>ad', ':Definitions<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>aD', ':Declarations<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>at', ':TypeDefinitions<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>ai', ':Implementations<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>ar', ':References<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>as', ':DocumentSymbols<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>aws', ':WorkspaceSymbols<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>aci', ':IncomingCalls<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>aco', ':OutgoingCalls<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>aR', ':RangeCodeActions<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>d', ':Diagnostics<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>da', ':DiagnosticsAll<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>ae', ':lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>aE', ':lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap = true, silent = true})
vimp('n', '<Leader>aF', ':lua vim.lsp.buf.formatting_sync(nil, 5000)<CR>', {noremap = true, silent = true})
vimp("n", "<leader>t", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
vimp("n", "<leader>tqf", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})
vimp("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
-- General mapping
vimp('n', '<F12>', ':e $MYVIMRC<CR>', {noremap = true, silent = true})

-- Config LSP

local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc

              ["rust-analyzer"] = {
                  assist = {
                      importGranularity = "module",
                      importPrefix = "by_self",
                  },
                  cargo = {
                      loadOutDirsFromCheck = true
                  },
                  procMacro = {
                      enable = true
                  },
                    checkOnSave = {
                        command = "check"
                  },
              }
          }
    },
}

require('rust-tools').setup(opts)

local opts = { noremap=true, silent=true }
local on_attach = function(client, bufnr)
-- Enable completion triggered by <c-x><c-o>
vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<S-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

local servers = { 'rust_analyzer' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

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

require('lualine').setup {
  options = {
    theme  = custom_gruvbox
  },
  sections = {
    lualine_c = {'filename', "require'lsp-status'.status()", "require'lsp-status'.register_progress()"},
    lualine_x = {'encoding', 'filetype', "os.date('%H:%M')"},
  }
}
