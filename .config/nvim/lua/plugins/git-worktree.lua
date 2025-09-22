return {
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- Worktree 一覧（Telescope があればピッカー、なければ簡易表示）
      { "<leader>gw", function()
          local ok, telescope = pcall(require, "telescope")
          if ok then telescope.extensions.git_worktree.git_worktrees()
          else require("git-worktree").list_worktrees() end
        end, desc = "Git Worktrees" },
      -- Worktree 追加（Telescope があると対話追加）
      { "<leader>ga", function()
          local ok, telescope = pcall(require, "telescope")
          if ok then telescope.extensions.git_worktree.create_git_worktree()
          else
            vim.notify("Telescope 未導入：対話追加は Telescope 連携が便利やで", vim.log.levels.WARN)
          end
        end, desc = "Add Git Worktree" },
    },
    config = function()
      local Worktree = require("git-worktree")
      Worktree.setup({
        change_directory_command = "cd",     -- 切替時に cwd を移動
        update_on_change = true,
        clearjumps_on_change = true,
      })

      -- 切替/作成/削除イベントで nvim-tree を追従
      Worktree.on_tree_change(function(op, meta)
        -- meta.path に新しいワークツリーのパス
        if meta and meta.path then
          pcall(vim.cmd, "cd " .. meta.path)
          -- nvim-tree が入っていればルート更新
          pcall(function()
            local api = require("nvim-tree.api")
            -- cwd を変えたので sync_root_with_cwd により自動追従、念のためリロード
            if api.tree.is_visible() then api.tree.reload() end
          end)
          vim.notify(("Switched worktree → %s"):format(meta.path), vim.log.levels.INFO)
        end
      end)
    end,
  },

  -- （任意）Telescope を入れてるなら拡張をロードするだけ
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    config = function()
      pcall(function() require("telescope").load_extension("git_worktree") end)
    end,
  },
}

