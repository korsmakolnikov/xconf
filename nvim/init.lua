local key_opts = { noremap=true, silent=true }
local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
local vimp = vim.api.nvim_set_keymap

-- ensure that packer is installed
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(packer_install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_install_path})
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
vim.wo.wrap = false
set.termguicolors = true
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

-- Neovide
vim.g.neovide_fullscreen=true
set.guifont = 'Fira Code:h14'
vim.g.neovide_cursor_vfx_mode = "railgun"

-- autogroup provides
-- TODO autoformat files doesn't work!
vim.api.nvim_command([[
augroup SetAutoindent
autocmd BufEnter *.go :set autoindent noexpandtab tabstop=8 shiftwidth=8
autocmd BufEnter *.rs :set autoindent noexpandtab tabstop=4 shiftwidth=4
augroup END 
augroup lsp_document_format
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 5000)
augroup END
]])

-- Filetree mapping
vimp('n', '<F2>', ':NeoTreeFocusToggle<CR>', key_opts)
vimp('n', '<C-c>', ':NeoTreeReveal!<CR>', key_opts)
-- Buffers mapping
vimp('n', '<TAB>', ':bn<CR> :redraw<CR>', key_opts)
vimp('n', '<S-TAB>', ':bp<CR> :redraw<CR>', key_opts)
vimp('n', '<Leader>bd', ':lua require(\'close_buffers\').delete({ type = \'this\' })<CR>', key_opts)
vimp('n', '<Leader>bK', ':lua require(\'close_buffers\').wipe({ type = \'all\', force = true })<CR>', key_opts)
vimp('n', '<Leader>bh', ':lua require(\'close_buffers\').wipe({ type = \'other\' })<CR>', key_opts)
-- Tab mapping
vimp('x', '<Tab>', '>gv |', key_opts)
vimp('x', '<S-Tab>', '<gv', key_opts)
-- FZF mapping
-- git is under 'g' except list files that is bound to leader-space
-- rg is under 'r' except grep project that is bound to leader-/
vimp('n', '<Leader>.', ":FzfLua oldfiles<CR>", key_opts)
vimp('n', '<Leader>./', ":FzfLua search_history<CR>", key_opts)
vimp('n', '<Leader>.:', ":FzfLua command_history<CR>", key_opts)
vimp('n', '<Leader>:', ":FzfLua resume<CR>", key_opts)
vimp('n', '<Leader>.?', ":FzfLua resume<CR>", key_opts)
vimp('n', '<Leader><Leader>', ":FzfLua buffers<CR>", key_opts)
vimp('n', '<Leader>m', ":FzfLua marks<CR>", key_opts)
vimp('n', '<Leader>k', ":FzfLua keymaps<CR>", key_opts)
vimp('n', '<Leader>r', ":FzfLua registers<CR>", key_opts)
vimp('n', '<Leader>j', ":FzfLua jump<CR>", key_opts)
vimp('n', '<Leader>ff', ":FzfLua files<CR>", { noremap = true, silent = true })
vimp('n', '<Leader><Space>', ":FzfLua git_files<CR>", key_opts)
-- Git
vimp('n', '<Leader>g', ":FzfLua git_bcommits<CR>", key_opts)
vimp('n', '<Leader>gs', ":FzfLua git_status<CR>", key_opts)
vimp('n', '<Leader>gp', ":FzfLua git_commits<CR>", key_opts)
vimp('n', '<Leader>gb', ":FzfLua git_branches<CR>", key_opts)
vimp('n', '<Leader>gc', ":FzfLua changes<CR>", key_opts)
-- FZF rg
vimp('n', '<Leader>rl', ":FzfLua grep_curbuf<CR>", key_opts)
vimp('n', '<Leader>/', ":FzfLua live_grep<CR>", key_opts)
vimp('n', '<C-f>', ":FzfLua grep_cword<CR>", key_opts)
vimp('v', '<C-f>',":FzfLua grep_visual<CR>", key_opts)
vimp('n', '<C-l>', ":FzfLua grep_last<CR>", key_opts)
-- LSP Mappings
-- All lsp function are under 'a'
-- All lsp diagnostic are under 'd'
-- All trouble function are under 't'
vimp('n', '<Leader>a', ":FzfLua lsp_code_actions<CR>", key_opts)
vimp('n', '<Leader>ad', ":FzfLua lsp_definitions<CR>", key_opts)
vimp('n', '<Leader>aD', ":FzfLua lsp_declarations<CR>", key_opts)
vimp('n', '<Leader>at', ":FzfLua lsp_typedefs<CR>", key_opts)
vimp('n', '<Leader>ai', ":FzfLua lsp_implementations<CR>", key_opts)
vimp('n', '<Leader>ar', ":FzfLua lsp_references<CR>", key_opts)
vimp('n', '<Leader>as', ":FzfLua lsp_document_symbols<CR>", key_opts)
vimp('n', '<Leader>aws', ":FzfLua lsp_workspace_symbols<CR>", key_opts)
vimp('n', '<Leader>d', ":FzfLua lsp_document_diagnostics<CR>", key_opts)
vimp('n', '<Leader>da', ":FzfLua lsp_workspace_diagnostics<CR>", key_opts)
vimp('n', '<Leader>ae', ':lua vim.lsp.diagnostic.goto_next()<CR>', key_opts)
vimp('n', '<Leader>aE', ':lua vim.lsp.diagnostic.goto_prev()<CR>', key_opts)
vimp('n', '<Leader>af', ':lua vim.lsp.buf.formatting_sync(nil, 5000)<CR>', key_opts)
-- Trouble
vimp("n", "<leader>t", "<cmd>TroubleToggle workspace_diagnostics<cr>", key_opts)
vimp("n", "<leader>tqf", "<cmd>TroubleToggle quickfix<cr>", key_opts)
vimp("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", key_opts)
-- General mapping
vimp('n', '<F12>', ':e $MYVIMRC<CR>', key_opts)

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
              },
          }
    },
}

require('rust-tools').setup(opts)

local on_attach = function(client, bufnr)
-- Enable completion triggered by <c-x><c-o>
vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', key_opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', key_opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<S-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', key_opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', key_opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', key_opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', key_opts)
end

local servers = { 'rust_analyzer', 'gopls' }
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

require('nvim_comment').setup()
