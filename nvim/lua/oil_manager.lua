require('oil').setup({
  default_file_explorer = true,
  delete_to_trash = true,
  columns = {
    "icon",
  },
  win_options = {
    cursorcolumn = true,
    signcolumn = "number",
  },
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
  },
  float = {
    padding = 10,
  }
})

require "oil_vcs"

local oil_manager = {}

function oil_manager.toggle_on_root_folder()
  local oil = require 'oil'
  oil.toggle_float(_G.Original_folder)
end

function oil_manager.toggle_on_current_folder()
  local oil = require 'oil'
  oil.toggle_float()
end

return oil_manager
