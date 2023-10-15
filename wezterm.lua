local wezterm = require 'wezterm'

local config = {}

config.audible_bell = "Disabled"

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_background_opacity = 0.8
config.font = wezterm.font_with_fallback {
  'Fira Code',
  'JetBrains Mono',
}
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
