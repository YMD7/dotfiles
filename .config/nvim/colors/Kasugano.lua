-- ~/.config/nvim/colors/kasugano.lua
-- Kasugano (terminal.sexy palette) -> Neovim colorscheme
-- Based on ANSI 16 + foreground/background from terminal.sexy

local M = {}

M.palette = {
  bg  = "#1b1b1b",
  fg  = "#ffffff",

  -- ANSI 0-15
  c0  = "#3D3D3D",
  c1  = "#6673BF",
  c2  = "#3EA290",
  c3  = "#B0EAD9",
  c4  = "#31658C",
  c5  = "#596196",
  c6  = "#8292B2",
  c7  = "#C8CACC",
  c8  = "#4D4D4D",
  c9  = "#899AFF",
  c10 = "#52AD91",
  c11 = "#98C9BB",
  c12 = "#477AB3",
  c13 = "#7882BF",
  c14 = "#95A7CC",
  c15 = "#EDEFF2",
}

local p = M.palette

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

function M.setup()
  vim.opt.termguicolors = true
  vim.g.colors_name = "kasugano"

  -- Terminal colors (for :terminal, plugins, etc.)
  vim.g.terminal_color_0  = p.c0
  vim.g.terminal_color_1  = p.c1
  vim.g.terminal_color_2  = p.c2
  vim.g.terminal_color_3  = p.c3
  vim.g.terminal_color_4  = p.c4
  vim.g.terminal_color_5  = p.c5
  vim.g.terminal_color_6  = p.c6
  vim.g.terminal_color_7  = p.c7
  vim.g.terminal_color_8  = p.c8
  vim.g.terminal_color_9  = p.c9
  vim.g.terminal_color_10 = p.c10
  vim.g.terminal_color_11 = p.c11
  vim.g.terminal_color_12 = p.c12
  vim.g.terminal_color_13 = p.c13
  vim.g.terminal_color_14 = p.c14
  vim.g.terminal_color_15 = p.c15

  -- Base UI
  hi("Normal",       { fg = p.fg, bg = p.bg })
  hi("NormalNC",     { fg = p.fg, bg = p.bg })
  hi("EndOfBuffer",  { fg = p.bg, bg = p.bg })
  hi("CursorLine",   { bg = p.c0 })
  hi("CursorLineNr", { fg = p.c11, bg = p.c0, bold = true })
  hi("LineNr",       { fg = p.c8, bg = p.bg })
  hi("SignColumn",   { fg = p.c8, bg = p.bg })
  hi("VertSplit",    { fg = p.c0, bg = p.bg })
  hi("WinSeparator", { fg = p.c0, bg = p.bg })

  hi("Visual",       { bg = p.c4 })
  hi("Search",       { fg = p.bg, bg = p.c11, bold = true })
  hi("IncSearch",    { fg = p.bg, bg = p.c3,  bold = true })
  hi("MatchParen",   { fg = p.c15, bg = p.c5, bold = true })

  hi("Pmenu",        { fg = p.fg, bg = p.c0 })
  hi("PmenuSel",     { fg = p.bg, bg = p.c11, bold = true })
  hi("PmenuSbar",    { bg = p.c0 })
  hi("PmenuThumb",   { bg = p.c8 })

  hi("StatusLine",   { fg = p.fg, bg = p.c0 })
  hi("StatusLineNC", { fg = p.c7, bg = p.c0 })
  hi("TabLine",      { fg = p.c7, bg = p.c0 })
  hi("TabLineSel",   { fg = p.bg, bg = p.c11, bold = true })
  hi("TabLineFill",  { bg = p.c0 })

  -- Syntax (ざっくり“気持ちいい”割り当て)
  hi("Comment",      { fg = p.c8, italic = true })
  hi("Constant",     { fg = p.c11 })
  hi("String",       { fg = p.c3 })
  hi("Character",    { fg = p.c3 })
  hi("Number",       { fg = p.c11 })
  hi("Boolean",      { fg = p.c11 })
  hi("Float",        { fg = p.c11 })

  hi("Identifier",   { fg = p.c14 })
  hi("Function",     { fg = p.c9, bold = true })

  hi("Statement",    { fg = p.c13 })
  hi("Keyword",      { fg = p.c13 })
  hi("Conditional",  { fg = p.c13 })
  hi("Repeat",       { fg = p.c13 })
  hi("Operator",     { fg = p.c6 })

  hi("Type",         { fg = p.c10 })
  hi("Special",      { fg = p.c12 })
  hi("PreProc",      { fg = p.c5 })

  hi("Underlined",   { underline = true })
  hi("Todo",         { fg = p.bg, bg = p.c11, bold = true })

  -- Diagnostics (LSP)
  hi("DiagnosticError", { fg = p.c1 })
  hi("DiagnosticWarn",  { fg = p.c11 })
  hi("DiagnosticInfo",  { fg = p.c12 })
  hi("DiagnosticHint",  { fg = p.c10 })

  hi("DiagnosticVirtualTextError", { fg = p.c1, bg = p.bg })
  hi("DiagnosticVirtualTextWarn",  { fg = p.c11, bg = p.bg })
  hi("DiagnosticVirtualTextInfo",  { fg = p.c12, bg = p.bg })
  hi("DiagnosticVirtualTextHint",  { fg = p.c10, bg = p.bg })

  -- Git (gitsigns 等)
  hi("DiffAdd",    { fg = p.c10, bg = p.bg })
  hi("DiffChange", { fg = p.c12, bg = p.bg })
  hi("DiffDelete", { fg = p.c1,  bg = p.bg })
end

M.setup()
return M

