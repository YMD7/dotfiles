local common = require('utils.common')

return {
  -- Customizing status line
  {
    -- Lualine
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      -- Select theme based on system appearance
      local lualine_theme
      if common.is_dark_mode() then
        lualine_theme = 'gruvbox_dark'  -- or another dark theme you prefer
      else
        lualine_theme = 'iceberg_light'  -- light theme
      end

      require('lualine').setup({
        options = {
          -- Dynamic theme selection
          theme = lualine_theme
        },
        sections = {
          lualine_c = {{'filename', path = 2}}
        },
      })
    end,
  },
}
