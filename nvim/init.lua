-- TODO:
-- [X] Fix warnings
-- [ ] Global options module
-- [ ] Packer setup module
-- [ ] Refactor bindings to be semantically aligned with vim's feature ("b" for "buffers" "w" for "window"[...])
-- [ ] Refactor coding lsp module to include one file for supported language
-- [ ] Fix binding module TODOs
-- [ ] Fix comment (TODO) highlighting. It is highlighted for a moment then it turns gray
-- [ ] Fix dap breakpoint icons
-- [ ] Improve dap supported
-- [ ] Refactor autogroups
local fn = vim.fn
local cmd = vim.cmd

-- ensure that packer is installed
local packer_install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(packer_install_path)) > 0 then
  _G.packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
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

require 'lualine.themes.gruvbox-material'
-- autogroup provides
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.rs", "*.s", "*.asm" },
  command = ":set autoindent noexpandtab tabstop=4 shiftwidth=4",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.go",
  command = ":set autoindent noexpandtab tabstop=8 shiftwidth=8",
})

require "nvim_comment".setup()
require "bufferline".setup()
require "zen-mode".setup()
require "twilight".setup()

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
require "markdown"
require "coding.treesitter"
require "presentation"
require "coding.elixir-tools"

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})

require "gitlinker".setup()

vim.o.cursorline = true
vim.o.culopt = 'line'

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.fnl",
--   callback = function()
--     vim.cmd([[w !fnlfmt %]])
--     vim.cmd([[e!]])
--   end,
--   group = format_sync_grp,
-- })
