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
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.php",
  command = ":set autoindent noexpandtab tabstop=4 shiftwidth=4",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.go",
  command = ":set autoindent noexpandtab tabstop=8 shiftwidth=8",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.rs",
  command = ":set autoindent noexpandtab tabstop=4 shiftwidth=4",
})

require "neovide"
require "bindings"
require "lib"
require "visual.lualine"
require "nvim_comment".setup()
require "bufferline".setup()
require "zen-mode".setup()
require "twilight".setup()

require "mason_setup"
require "coding.snippets"
require "coding.lsp"
require "coding.dap"
require "coding.treesitter"
require "coding.autocompletition"
require "coding.on_attach"

require "markdown"
require "presentation"
