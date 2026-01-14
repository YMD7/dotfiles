local wezterm = require 'wezterm'
local act = wezterm.action

return {
  keys = {
    ------------------------------------------------------------------------
    -- Pane splitting
    ------------------------------------------------------------------------

    -- Cmd + d : Split pane vertically (left/right)
    { key = 'd', mods = 'CMD', action = act.SplitHorizontal {
        domain = 'CurrentPaneDomain'
      }
    },

    -- Cmd + Shift + d : Split pane horizontally (top/bottom)
    { key = 'D', mods = 'CMD|SHIFT', action = act.SplitVertical {
        domain = 'CurrentPaneDomain'
      }
    },

    ------------------------------------------------------------------------
    -- Pane navigation
    ------------------------------------------------------------------------

    -- Cmd + Option + Arrow : Move focus between panes
    { key = 'LeftArrow',  mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Left'  },
    { key = 'RightArrow', mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'UpArrow',    mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Up'    },
    { key = 'DownArrow',  mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Down'  },

    ------------------------------------------------------------------------
    -- Pane resizing
    ------------------------------------------------------------------------

    -- Cmd + Option + Shift + Arrow : Resize pane
    { key = 'LeftArrow',  mods = 'CMD|ALT|SHIFT', action = act.AdjustPaneSize { 'Left',  5 } },
    { key = 'RightArrow', mods = 'CMD|ALT|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'UpArrow',    mods = 'CMD|ALT|SHIFT', action = act.AdjustPaneSize { 'Up',    3 } },
    { key = 'DownArrow',  mods = 'CMD|ALT|SHIFT', action = act.AdjustPaneSize { 'Down',  3 } },

    ------------------------------------------------------------------------
    -- Closing panes
    ------------------------------------------------------------------------

    -- Cmd + w : Close current pane (with confirmation)
    { key = 'w', mods = 'CMD', action = act.CloseCurrentPane {
        confirm = true
      }
    },

    ------------------------------------------------------------------------
    -- Tabs
    ------------------------------------------------------------------------

    -- Cmd + t : Open new tab
    { key = 't', mods = 'CMD', action = act.SpawnTab 'CurrentPaneDomain' },

    -- Cmd + Shift + { / } : Switch tabs
    { key = '{', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = '}', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1)  },

    ------------------------------------------------------------------------
    -- Screen / scrollback control
    ------------------------------------------------------------------------

    -- Cmd + k : Clear screen and scrollback
    { key = 'k', mods = 'CMD', action = act.ClearScrollback 'ScrollbackAndViewport' },

    -- Cmd + Shift + k : Scroll to top (keep output)
    { key = 'K', mods = 'CMD|SHIFT', action = act.ScrollToTop },

    -- Cmd + Shift + j : Scroll to bottom
    { key = 'J', mods = 'CMD|SHIFT', action = act.ScrollToBottom },

    ------------------------------------------------------------------------
    -- Utility
    ------------------------------------------------------------------------

    -- Cmd + Shift + p : Command palette
    { key = 'P', mods = 'CMD|SHIFT', action = act.ActivateCommandPalette },
  },
}
