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

  {
    -- multi cursor
    -- //Key: [Ctrl-N] for multi selection
    'mg979/vim-visual-multi',
  },
  {
    -- visualize indentation
    'Yggdroot/indentLine',
    config = function()
      vim.g['indentLine_char'] = '│'
      vim.g['indentLine_color_term'] = 236
    end,
  },
  {
    -- switch filetype depends on cursor position
    'osyo-manga/vim-precious',
    dependencies = {
      'Shougo/context_filetype.vim'
    },
  },
  {
    -- syntax highlight
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
          sync_install = false,
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
  },
}
