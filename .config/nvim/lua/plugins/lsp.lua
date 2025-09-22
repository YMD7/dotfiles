return {

  -- LSP（Neovim 0.11+ の新API）
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 既存の on_attach / capabilities があれば使う。無ければ空で。
      local on_attach = _G.on_attach or function() end
      local capabilities = _G.capabilities

      -- 全サーバ共通設定
      vim.lsp.config("*", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Diagnostic（そのまま流用OK）
      vim.diagnostic.config({ virtual_text = false })

      -- キーマップ（そのまま）
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

      -- 個別設定は after/lsp/*.lua に置く（次のセクション参照）

      -- サーバ起動（tsserver → ts_ls に注意）
      vim.lsp.enable({
        "eslint",
        "denols",
        "ts_ls",
      })
    end,
  },

  -- Flutter（そのままでOK）
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    config = true,
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- tsserver じゃなく ts_ls を入れる
        ensure_installed = { "ts_ls", "denols", "eslint" },
        automatic_installation = true,
        -- v2 以降は “自動有効化” が入ってるけど、
        -- 上で vim.lsp.enable してるので両方でも問題なし（重複起動はしない）。
      })
    end,
  },

  -- Trouble（そのまま）
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
    end,
  },
}
