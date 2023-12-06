local oil = require 'oil'
oil.setup({
  default_file_explorer = true,
  delete_to_trash = true,
  columns = {
    "icon",
  },
  win_options = {
    signcolumn = "yes:3",
  },
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
  }
})

local oil_manager = {}

function oil_manager.toggle_on_root_folder()
  local oil = require 'oil'
  oil.toggle_float(Original_folder)
end

function oil_manager.toggle_on_current_folder()
  local oil = require 'oil'
  oil.toggle_float()
end

return oil_manager
