---@type vim.lsp.Config
return {
  -- Node プロジェクトだけで有効化
  root_markers = { "package.json" },
  workspace_required = true,
  single_file_support = false,
}

