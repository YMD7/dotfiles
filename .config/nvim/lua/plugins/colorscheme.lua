local common = require('utils.common')

local function get_theme_blue()
  local groups = {'Function', 'Keyword', 'Type', 'Special', 'Identifier'}
  for _, group in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group })
    if hl.fg then
      return string.format('#%06x', hl.fg)
    end
  end
  return '#333333' -- fallback
end

local function setup_cursor_colors()
  if not common.is_dark_mode() then
    local theme_blue = get_theme_blue()
    local cursor_config = { fg = '#ffffff', bg = theme_blue, blend = 15 }

    vim.api.nvim_set_hl(0, 'Cursor', cursor_config)
    vim.api.nvim_set_hl(0, 'TermCursor', cursor_config)
    vim.api.nvim_set_hl(0, 'lCursor', cursor_config)
    vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
  end
end

local function setup_theme()
  common.set_background()

  if common.is_dark_mode() then
    vim.cmd("colorscheme kiro_dark")
  else
    vim.cmd("colorscheme kiro_light")
  end

  setup_cursor_colors()
end

return {
  {
    "rebelot/kanagawa.nvim",
  },
  {
    "sainnhe/everforest",
  },
  {
    "AlessandroYorba/Alduin",
    config = function()
      vim.g.alduin_Shout_Become_Ethereal = 1
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({ style = "day" })
      setup_theme()
    end,
  },
}
