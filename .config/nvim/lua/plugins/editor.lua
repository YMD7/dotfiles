return {
  -- for editor
  {
    -- easily comment in/out
    -- // Key: [gcc] for toggle comment
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },

  {
    -- highlighting whitespace in red
    -- //Key: [\sip] for fixing whitespace
    'ntpeters/vim-better-whitespace',
  },
}
