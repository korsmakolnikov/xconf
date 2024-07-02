-- Bootstrap lazy.nvim and tangerine transpiler
local init_layer = require 'init_layer'
init_layer
    .bootstrap("https://github.com/udayvir-singh/tangerine.nvim")
    .init_transpiler()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require 'packages'

require 'impatient'

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
vim.o.clipboard = vim.o.clipboard .. 'unnamed,unnamedplus'
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
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
vim.opt.encoding = "utf-8"
vim.fn.mkdir(vim.fn.stdpath("data") .. "site/spell", "p")
vim.opt.spell = true
vim.opt.spelllang = { "en_us", "it" }
_G.Original_folder = vim.loop.cwd()

require "visual.theme"
require 'lualine.themes.gruvbox-material'
require "nvim_comment".setup()
require "bufferline".setup()
-- require "zen-mode".setup()
-- require "twilight".setup()

require "neovide"
require "oil_manager"
require "bindings"
require "lib"
require "visual.lualine"
require "mason_setup"
require "coding.snippets"
require "coding.lsp"
require "coding.dap"
require "coding.autocompletition"
require "coding.on_attach"
require "coding.treesitter"
require "coding.elixir-tools"
require "markdown"
require "presentation"
require "autogroups"
require "gitlinker".setup()
