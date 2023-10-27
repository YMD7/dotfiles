return {
  -- Color schemes

  {
    -- kanagawa
    "rebelot/kanagawa.nvim",
    -- config = function()
    --   require('kanagawa').setup({
    --     colors = {
    --       theme = { all = { ui = { bg_gutter = 'none' } } }
    --     },
    --   })
    --   vim.cmd("colorscheme kanagawa-dragon")
    -- end,
  },

  {
    -- everforest
    "sainnhe/everforest",
    -- config = function()
    --   vim.o.background = 'dark'
    --   vim.g.everforest_background = 'hard'
    --   vim.cmd("colorscheme everforest")
    -- end,
  },

  {
    -- alduin
    "AlessandroYorba/Alduin",
    config = function()
      vim.g.alduin_Shout_Become_Ethereal = 1
      -- vim.g.alduin_Shout_Dragon_Aspect = 1
      -- vim.g.alduin_Shout_Fire_Breath = 1
      vim.cmd("colorscheme alduin")
    end,
  },
}
