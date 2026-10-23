local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.audible_bell = "Disabled"

-- Antracite: RAL 7016 greys with a vaporwave fuchsia accent, same palette as the eww bar
local antracite = {
  bg0 = '#1b1f21', bg1 = '#23292b', bg3 = '#383e42',
  fg = '#d6dadb', fg_dim = '#8a9498', fuchsia = '#e05bbf',
}

config.colors = {
  foreground = antracite.fg,
  background = antracite.bg0,
  cursor_bg = antracite.fuchsia,
  cursor_border = antracite.fuchsia,
  cursor_fg = antracite.bg0,
  selection_bg = antracite.bg3,
  selection_fg = antracite.fg,
  split = antracite.bg3,
  ansi = { '#23292b', '#e0566e', '#9bb07f', '#d8b568', '#8ea5b2', '#e05bbf', '#7fb5b0', '#d6dadb' },
  brights = { '#4a5257', '#f07088', '#b0c597', '#e8c98a', '#a9bfcc', '#f07fd2', '#9cccc6', '#f0f3f4' },
  tab_bar = {
    background = antracite.bg0,
    active_tab = { bg_color = antracite.fuchsia, fg_color = antracite.bg0, intensity = 'Bold' },
    inactive_tab = { bg_color = antracite.bg1, fg_color = antracite.fg_dim },
    inactive_tab_hover = { bg_color = antracite.bg3, fg_color = antracite.fg },
    new_tab = { bg_color = antracite.bg0, fg_color = antracite.fg_dim },
    new_tab_hover = { bg_color = antracite.bg3, fg_color = antracite.fg },
  },
}
config.use_fancy_tab_bar = false

config.window_background_opacity = 0.8
config.font = wezterm.font_with_fallback {
  'Fira Code Nerd Font',
  'JetBrains Mono',
}
config.font_size = 16.0
config.warn_about_missing_glyphs = false

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.7,
}

config.keys = {
  {
    key = 'n',
    mods = 'SHIFT|ALT',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = true }
  },
  { key = 'LeftArrow',  mods = 'SHIFT|CTRL', action = wezterm.action.MoveTabRelative(-1) },
  { key = 'RightArrow', mods = 'SHIFT|CTRL', action = wezterm.action.MoveTabRelative(1) },
  { key = 'LeftArrow',  mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(1) },
  {
    key = 'v',
    mods = 'SHIFT|ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 's',
    mods = 'SHIFT|ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '^',
    mods = 'CTRL',
    action = wezterm.action.Nop
  },
  {
    key = '6',
    mods = 'CTRL',
    action = wezterm.action.Nop
  }
}

-- wezterm.on('gui-startup', function(cmd)
--   local _, _, window = wezterm.mux.spawn_window(cmd or {})
--   window:gui_window():toggle_fullscreen()
-- end)


return config
