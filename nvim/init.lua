local vim = vim
local fn = vim.fn
local cmd = vim.cmd
local api = vim.api

-- ensure that packer is installed
local packer_install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(packer_install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    packer_install_path })
end

cmd('packadd packer.nvim')
local packer = require 'packer'
local util = require 'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

require 'plugins'
require 'impatient'
require "visual.theme"

vim.g.mapleader = ","
vim.opt.matchpairs = vim.bo.matchpairs .. ",<:>"

local set = vim.opt
set.splitright = true
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
vim.o.clipboard = vim.o.clipboard .. 'unnamedplus'
vim.o.ttyfast = true
vim.o.backupdir = '~/.config/nvim/backup'
vim.o.cmdheight = 3
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.opt.termguicolors = true
vim.g.loaded_python_provider = '0'
vim.g.goyo_width = '80'
vim.g.neovide_fullscreen = true
set.guifont = 'Fira Code Font:h14'
vim.g.neovide_cursor_vfx_mode = "railgun"

require 'lualine.themes.gruvbox-material'
-- autogroup provides
api.nvim_command([[
augroup SetAutoindent
autocmd BufEnter *.go :set autoindent noexpandtab tabstop=8 shiftwidth=8
autocmd BufEnter *.rs :set autoindent noexpandtab tabstop=4 shiftwidth=4
augroup END
]])

require "neovide"
require "bindings"
require "lib"
require "visual.lualine"
require "nvim_comment".setup()
require "bufferline".setup()
require "zen-mode".setup()
require "twilight".setup()

require "mason_setup"
require "coding.autocompletition"
require "coding.treesitter"
require "coding.snippets"
require "coding.lsp"
require "coding.rust"
require "coding.dap"

require "markdown"
require "presentation"
