return {
  -- for editor
  {
    -- visualize indentation
    'Yggdroot/indentLine',
    config = function()
      vim.g['indentLine_char'] = '│'
      vim.g['indentLine_color_term'] = 236
      vim.g.indentLine_conceallevel = 0
    end,
  },
  {
    'elzr/vim-json',
  },
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
  {
    -- highlight the indent line, code chunk according to the current cursor position.
    'shellRaining/hlchunk.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end
  },
  {
    -- Claude Code Neovim IDE Extention
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  {
    -- Auto close parentheses and repeat by dot dot dot...
    'cohama/lexima.vim',
    config = function()
      vim.g.lexima_enable_basic_rules = 1
    end,
  },
  {
    -- Debugger
    'mfussenegger/nvim-dap',
  },
}

