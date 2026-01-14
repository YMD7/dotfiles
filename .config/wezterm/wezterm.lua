-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Import Color Theme
local kiro_schemes = require 'colors.kiro'

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true

-- Load Keybinds
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables

-- Theme mode: "dark", "light", or nil (auto, follows OS)
local theme_mode = "dark"

-- Pick scheme by OS appearance or fixed mode
local function get_color_scheme()
  if theme_mode == "dark" then
    return "Kiro Dark"
  elseif theme_mode == "light" then
    return "Kiro Light"
  else
    -- Auto: follow OS appearance
    local appearance = wezterm.gui.get_appearance()
    if appearance and appearance:find("Dark") then
      return "Kiro Dark"
    else
      return "Kiro Light"
    end
  end
end

-- Apply schemes
config.color_schemes = kiro_schemes
config.color_scheme = get_color_scheme()

-- Other config
config.font_size = 13.0

config.font = wezterm.font_with_fallback {
  'Menlo',
  'Monaco',
  'Bizin Gothic NF',
  'NOTONOTO35 HS',
  'Osaka',
  'Apple Color Emoji',
}

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}
config.show_new_tab_button_in_tab_bar = false
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  }
}

-- and finally, return the configuration to wezterm
return config

