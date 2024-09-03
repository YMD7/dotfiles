return {

  -- LSP
  {
    -- Using the Nvim built-in LSP Client
    'neovim/nvim-lspconfig',
    config = function()

      local lspconfig = require("lspconfig")

      -- ESLint
      lspconfig.eslint.setup {
        on_attach = on_attach,
      }

      -- Deno
      lspconfig.denols.setup {
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
      }

      -- TypeScript
      lspconfig.tsserver.setup {
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern('package.json'),
        single_file_support = false,
      }

      -- Disable virtual text
      vim.diagnostic.config({ virtual_text = false })

      -- Keymap
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    end,
  },

  -- LSP Manager
  {
    -- Mason
    'williamboman/mason.nvim',
    build = ":MasonUpdate",
    config = function()
      require('mason').setup()
    end,
  },
  {
    -- Mason LSP Config
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup()
    end,
  },

  -- For showing diagnostics results on the bottom
  {
    -- Trouble
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('trouble').setup()
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
        { silent = true, noremap = true }
      )
    end,
  },
}
