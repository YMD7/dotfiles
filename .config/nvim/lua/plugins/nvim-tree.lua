return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<C-f>", function()
          local api = require("nvim-tree.api")
          if api.tree.is_visible() then api.tree.toggle()
          else api.tree.open({ current_window = false, find_file = true, focus = true }) end
        end,
        desc = "Toggle NvimTree (drawer)"
      },
    },
    config = function()
      -- netrw 無効（init.lua に既にあってもOK）
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = { side = "left", width = 30, preserve_window_proportions = true },
        filters = { dotfiles = false, git_ignored = false },
        -- ← cwd 追従させる
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = { enable = true, update_root = true },
        git = { enable = true, ignore = false },
        renderer = {
          highlight_git = true,
          indent_markers = { enable = true },
          icons = { show = { file = true, folder = true, folder_arrow = true, git = true } },
        },
        actions = { open_file = { quit_on_open = false } },
        hijack_netrw = true,
      })
    end,
  },
}

