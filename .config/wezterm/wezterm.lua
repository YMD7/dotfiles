-- =============================================================================
-- WezTerm Configuration
-- =============================================================================
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- =============================================================================
-- General
-- =============================================================================
config.automatically_reload_config = true

-- Compatibility with tiling window managers (AeroSpace, etc.)
config.adjust_window_size_when_changing_font_size = false
config.use_resize_increments = false

-- =============================================================================
-- Keybinds
-- =============================================================================
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables

-- =============================================================================
-- Color Scheme
-- =============================================================================
local kiro_schemes = require 'colors.kiro'

-- Options: "dark", "light", or nil (auto-detect from OS)
local theme_mode = "dark"

local function get_color_scheme()
  if theme_mode == "dark" then
    return "Kiro Dark"
  elseif theme_mode == "light" then
    return "Kiro Light"
  else
    local appearance = wezterm.gui.get_appearance()
    if appearance and appearance:find("Dark") then
      return "Kiro Dark"
    else
      return "Kiro Light"
    end
  end
end

config.color_schemes = kiro_schemes
config.color_scheme = get_color_scheme()

config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
    background = '#1a1a1a',
  },
  split = "#666666",
}

-- =============================================================================
-- Font
-- =============================================================================
config.font_size = 12.5
config.font = wezterm.font_with_fallback {
  'Hack Nerd Font Mono',
  'Menlo',
  'Monaco',
  'Bizin Gothic NF',
  'NOTONOTO35 HS',
  'Osaka',
  'Apple Color Emoji',
}

-- =============================================================================
-- Window
-- =============================================================================
config.window_decorations = "RESIZE"

config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = '0.5cell',
  bottom = '0.5cell',
}

config.window_frame = {
  -- Font
  font = wezterm.font { family = 'NOTONOTO35 HS', weight = 'Bold' },
  font_size = 13.0,
  -- Border (padding effect)
  border_left_width = '0.5cell',
  border_right_width = '0.5cell',
  border_bottom_height = '0.25cell',
  border_top_height = '0.25cell',
  border_left_color = '#333333',
  border_right_color = '#333333',
  border_bottom_color = '#333333',
  border_top_color = '#333333',
}

-- =============================================================================
-- Tab Bar
-- =============================================================================
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 40

-- Format tab title with keyboard shortcut hint
wezterm.on('format-tab-title', function(tab, tabs, panes, cfg, hover, max_width)
  local title = tab.active_pane.title
  if not title or title == '' then
    title = tab.active_pane.foreground_process_name or 'shell'
  end

  local tab_index = tab.tab_index + 1
  local shortcut = ''
  if tab_index <= 9 then
    shortcut = '(⌘' .. tab_index .. ')'
  end

  -- Truncate long titles
  local title_max = 20
  if #title > title_max then
    title = wezterm.truncate_right(title, title_max) .. '…'
  end

  return {
    { Text = title .. ' ' },
    { Foreground = { Color = '#88c0d0' } },
    { Text = shortcut },
  }
end)

-- =============================================================================
-- Pane
-- =============================================================================
-- Dim inactive panes for better focus
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.5,
}

-- =============================================================================
return config

