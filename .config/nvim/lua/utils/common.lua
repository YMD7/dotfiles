local M = {}
-- Check if macOS is in dark mode
function M.is_dark_mode()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result:match("Dark") ~= nil
  end
  return false
end
-- Set vim background based on system theme
function M.set_background()
  if M.is_dark_mode() then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end
-- Get current theme mode for other plugins
function M.get_theme_mode()
  return M.is_dark_mode() and "dark" or "light"
end
-- Set cursor colors and appearance based on theme
function M.set_cursor_colors()
  if M.is_dark_mode() then
    -- Dark theme cursor settings
    vim.cmd("highlight Cursor guifg=#000000 guibg=#ffffff")
    vim.cmd("highlight TermCursor guifg=#000000 guibg=#ffffff")
    vim.cmd("highlight lCursor guifg=#000000 guibg=#ffffff")
    vim.opt.guicursor = "a:block-blinkon0-Cursor"
  else
    -- Light theme cursor settings - high contrast
    vim.cmd("highlight Cursor guifg=#ffffff guibg=#000000")
    vim.cmd("highlight TermCursor guifg=#ffffff guibg=#000000")
    vim.cmd("highlight lCursor guifg=#ffffff guibg=#000000")
    vim.opt.guicursor = "a:block-blinkon0-Cursor"
  end
end
return M
