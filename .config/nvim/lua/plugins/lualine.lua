return {
  -- Custmizing status line
  {
    -- Lualine
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('lualine').setup({
        options = {

          -- Theme
          theme = 'gruvbox-material'
        },
      })
    end,
  },
}
