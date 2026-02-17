-- =============================================================================
-- Kiro color schemes for WezTerm
-- =============================================================================

return {
  ["Kiro Dark"] = {
    foreground = "#ffffff",
    background = "#211d25",

    cursor_bg = "#c0a0ff",
    cursor_fg = "#0d0b10",
    cursor_border = "#b080ff",

    selection_fg = "#ffffff",
    selection_bg = "#5c5368",

    ansi = {
      "#19161d",    -- black
      "#e59898",    -- red (muted)
      "#98e5b8",    -- green (muted)
      "#efe7c1",    -- yellow (muted)
      "#a1c6e5",    -- blue (muted)
      "#956ada",    -- magenta (muted)
      "#98dee5",    -- cyan (muted)
      "#dcdadf",    -- white
    },
    brights = {
      "#938f9b",    -- bright black (gray)
      "#e59898",    -- bright red
      "#98e5b8",    -- bright green
      "#efe7c1",    -- bright yellow
      "#a1c6e5",    -- bright blue
      "#956ada",    -- bright magenta
      "#98dee5",    -- bright cyan
      "#ffffff",    -- bright white
    },

    split = "#4a464f",
  },

  ["Kiro Light"] = {
    foreground = "#352f3d",
    background = "#f2f1f4",

    cursor_bg = "#7138cc",
    cursor_fg = "#f2f1f4",
    cursor_border = "#7138cc",

    selection_fg = "#352f3d",
    selection_bg = "#eae8ed",

    ansi = {
      "#352f3d",
      "#e21067",
      "#367c53",
      "#dbb90f",
      "#2d6a9f",
      "#c80e5c",
      "#0c9aa7",
      "#dcdadf",
    },
    brights = {
      "#938f9b",
      "#e21067",
      "#367c53",
      "#dbb90f",
      "#2d6a9f",
      "#8e47ff",
      "#0c9aa7",
      "#ffffff",
    },

    split = "#c1bec6",
  },
}
