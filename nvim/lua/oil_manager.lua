-- :fennel:1719609142
require("oil").setup({columns = {"icon"}, default_file_explorer = true, delete_to_trash = true, float = {padding = 10}, view_options = {show_hidden = true}, win_options = {signcolumn = "number"}})
require("oil_vcs")
local oil_manager = {}
oil_manager.toggle_on_root_folder = function()
  local oil = require("oil")
  return oil.toggle_float(_G.Original_folder)
end
oil_manager.toggle_on_current_folder = function()
  local oil = require("oil")
  return oil.toggle_float()
end
return oil_manager