" Kiro Theme for Neovim
" Inspired by Kiro IDE's default color theme
" Based on implementations for Zed and VSCode

highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "kiro"

" Terminal color palette
if has('nvim')
  let g:terminal_color_0  = '#19161d'
  let g:terminal_color_1  = '#ff8080'
  let g:terminal_color_2  = '#80ffb5'
  let g:terminal_color_3  = '#fff2b3'
  let g:terminal_color_4  = '#8dc8fb'
  let g:terminal_color_5  = '#8e47ff'
  let g:terminal_color_6  = '#80f4ff'
  let g:terminal_color_7  = '#ffffff'
  let g:terminal_color_8  = '#938f9b'
  let g:terminal_color_9  = '#ff8080'
  let g:terminal_color_10 = '#80ffb5'
  let g:terminal_color_11 = '#fff2b3'
  let g:terminal_color_12 = '#8dc8fb'
  let g:terminal_color_13 = '#8e47ff'
  let g:terminal_color_14 = '#80f4ff'
  let g:terminal_color_15 = '#ffffff'
endif

" Define color variables
if &background == 'dark'
  " Dark theme colors
  let s:bg = '#211d25'
  let s:bg_dark = '#19161d'
  let s:bg_light = '#28242e'
  let s:bg_highlight = '#352f3d'
  let s:fg = '#ffffff'
  let s:fg_light = '#dcdadf'
  let s:fg_dark = '#938f9b'
  let s:accent = '#b080ff'
  let s:accent_dark = '#9e61ff'
  let s:accent_secondary = '#8e47ff'
  let s:border = '#4a464f'
  
  " Dark syntax colors
  let s:red = '#ff8080'
  let s:green = '#80ffb5'
  let s:yellow = '#fff2b3'
  let s:blue = '#8dc8fb'
  let s:magenta = '#8e47ff'
  let s:cyan = '#80f4ff'
  let s:orange = '#ffcf99'
  let s:pink = '#ffafd1'
  let s:purple = '#c3a0fd'
  let s:comment = '#a6a5a7'
else
  " Light theme colors
  let s:bg = '#f2f1f4'
  let s:bg_dark = '#dcdadf'
  let s:bg_light = '#eae8ed'
  let s:bg_highlight = '#ffffff'
  let s:fg = '#352f3d'
  let s:fg_light = '#5e5966'
  let s:fg_dark = '#938f9b'
  let s:accent = '#7138cc'
  let s:accent_dark = '#6432b3'
  let s:accent_secondary = '#8e47ff'
  let s:border = '#c1bec6'
  
  " Light syntax colors (VSCode Neokiro theme colors)
  let s:red = '#e21067'
  let s:green = '#367c53'
  let s:yellow = '#dbb90f'
  let s:blue = '#2d6a9f'
  let s:magenta = '#c80e5c'
  let s:cyan = '#0c9aa7'
  let s:orange = '#d08025'
  let s:pink = '#e21067'
  let s:purple = '#7559a6'
  let s:comment = '#352f3d99'
endif

" Helper function to set highlights
function! s:hi(group, fg, bg, attr)
  if a:fg != ""
    exec "hi " . a:group . " guifg=" . a:fg
  endif
  if a:bg != ""
    exec "hi " . a:group . " guibg=" . a:bg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr
  endif
endfunction

" Basic UI elements
call s:hi('Normal', s:fg, s:bg, '')
call s:hi('NormalFloat', s:fg, s:bg_highlight, '')
call s:hi('FloatBorder', s:border, s:bg_highlight, '')
call s:hi('Cursor', s:bg, s:fg, '')
call s:hi('CursorLine', '', s:bg_light, '')
call s:hi('CursorColumn', '', s:bg_light, '')
call s:hi('ColorColumn', '', s:bg_light, '')
call s:hi('LineNr', s:fg_dark, '', '')
call s:hi('CursorLineNr', s:fg, '', 'bold')
call s:hi('SignColumn', '', s:bg, '')
call s:hi('Folded', s:fg_dark, s:bg_light, '')
call s:hi('FoldColumn', s:fg_dark, '', '')

" Status line
call s:hi('StatusLine', s:fg, s:bg_highlight, '')
call s:hi('StatusLineNC', s:fg_dark, s:bg_light, '')
call s:hi('WinSeparator', s:border, '', '')

" Tab line
call s:hi('TabLine', s:fg_dark, s:bg_light, '')
call s:hi('TabLineFill', '', s:bg_light, '')
call s:hi('TabLineSel', s:fg, s:bg_highlight, 'bold')

" Search
call s:hi('Search', s:bg, s:yellow, '')
call s:hi('IncSearch', s:bg, s:orange, '')
call s:hi('CurSearch', s:bg, s:orange, '')

" Visual selection
if &background == 'dark'
  call s:hi('Visual', s:fg, '#4a3d66', '')
  call s:hi('VisualNOS', s:fg, '#4a3d66', '')
else
  call s:hi('Visual', '', '#e4d9f2', '')
  call s:hi('VisualNOS', '', '#e4d9f2', '')
endif

" Messages
call s:hi('ErrorMsg', s:red, '', 'bold')
call s:hi('WarningMsg', s:orange, '', 'bold')
call s:hi('MoreMsg', s:green, '', 'bold')
call s:hi('ModeMsg', s:fg, '', 'bold')

" Popup menu
call s:hi('Pmenu', s:fg, s:bg_highlight, '')
call s:hi('PmenuSel', s:fg, s:accent_secondary, 'bold')
call s:hi('PmenuSbar', '', s:bg_light, '')
call s:hi('PmenuThumb', '', s:accent, '')

" Wild menu
call s:hi('WildMenu', s:fg, s:accent_secondary, 'bold')

" Command line
call s:hi('CmdlineNormalMode', s:fg, s:bg, '')
call s:hi('CmdlineInsertMode', s:fg, s:bg, '')
call s:hi('CmdlineReplaceMode', s:fg, s:bg, '')
call s:hi('CmdlineVisualMode', s:fg, s:bg, '')
call s:hi('CmdlineCommandMode', s:fg, s:bg, '')

" Quickfix
call s:hi('qfLineNr', s:yellow, '', '')
call s:hi('qfFileName', s:blue, '', '')

" Location list
call s:hi('qfError', s:red, '', '')
call s:hi('qfWarning', s:orange, '', '')

" Help
call s:hi('helpNote', s:green, '', '')
call s:hi('helpHeadline', s:orange, '', 'bold')
call s:hi('helpHeader', s:blue, '', 'bold')
call s:hi('helpURL', s:cyan, '', 'underline')
call s:hi('helpHyperTextJump', s:blue, '', 'underline')
call s:hi('helpHyperTextEntry', s:cyan, '', '')
call s:hi('helpCommand', s:purple, '', '')
call s:hi('helpExample', s:green, '', '')
call s:hi('helpSpecial', s:orange, '', '')
call s:hi('helpSectionDelim', s:comment, '', '')

" Spelling
call s:hi('SpellBad', s:red, '', 'undercurl')
call s:hi('SpellCap', s:blue, '', 'undercurl')
call s:hi('SpellLocal', s:cyan, '', 'undercurl')
call s:hi('SpellRare', s:magenta, '', 'undercurl')

" Diff
call s:hi('DiffAdd', '', s:green . '20', '')
call s:hi('DiffChange', '', s:orange . '20', '')
call s:hi('DiffDelete', '', s:red . '20', '')
call s:hi('DiffText', '', s:orange . '40', 'bold')

" Git diff (additional)
call s:hi('diffAdded', s:green, '', '')
call s:hi('diffRemoved', s:red, '', '')
call s:hi('diffChanged', s:orange, '', '')
call s:hi('diffFile', s:blue, '', 'bold')
call s:hi('diffNewFile', s:green, '', 'bold')
call s:hi('diffLine', s:cyan, '', 'bold')

" Syntax highlighting
call s:hi('Comment', s:comment, '', 'italic')
call s:hi('Constant', s:pink, '', '')
call s:hi('String', s:green, '', '')
call s:hi('Character', s:green, '', '')
call s:hi('Number', s:pink, '', '')
call s:hi('Boolean', s:red, '', '')
call s:hi('Float', s:pink, '', '')

call s:hi('Identifier', s:cyan, '', '')
call s:hi('Function', s:blue, '', '')

call s:hi('Statement', s:purple, '', '')
call s:hi('Conditional', s:purple, '', '')
call s:hi('Repeat', s:purple, '', '')
call s:hi('Label', s:purple, '', '')
call s:hi('Operator', s:fg, '', '')
call s:hi('Keyword', s:purple, '', '')
call s:hi('Exception', s:purple, '', '')

call s:hi('PreProc', s:orange, '', '')
call s:hi('Include', s:purple, '', '')
call s:hi('Define', s:purple, '', '')
call s:hi('Macro', s:purple, '', '')
call s:hi('PreCondit', s:purple, '', '')

call s:hi('Type', s:cyan, '', '')
call s:hi('StorageClass', s:purple, '', '')
call s:hi('Structure', s:cyan, '', '')
call s:hi('Typedef', s:cyan, '', '')

call s:hi('Special', s:orange, '', '')
call s:hi('SpecialChar', s:orange, '', '')
call s:hi('Tag', s:blue, '', '')
call s:hi('Delimiter', s:fg, '', '')
call s:hi('SpecialComment', s:comment, '', 'italic')
call s:hi('Debug', s:orange, '', '')

call s:hi('Underlined', s:blue, '', 'underline')
call s:hi('Ignore', s:fg_dark, '', '')
call s:hi('Error', s:red, '', 'bold')
call s:hi('Todo', s:yellow, s:bg, 'bold')

" Additional UI elements
call s:hi('NonText', s:fg_dark, '', '')
call s:hi('SpecialKey', s:fg_dark, '', '')
call s:hi('MatchParen', s:fg, s:bg_highlight, 'bold')
call s:hi('Question', s:green, '', 'bold')
call s:hi('Directory', s:blue, '', 'bold')
call s:hi('Title', s:orange, '', 'bold')
call s:hi('Conceal', s:comment, '', '')
call s:hi('EndOfBuffer', s:bg, '', '')

" Language-specific highlighting

" HTML
call s:hi('htmlTag', s:blue, '', '')
call s:hi('htmlEndTag', s:blue, '', '')
call s:hi('htmlTagName', s:blue, '', '')
call s:hi('htmlArg', s:orange, '', '')
call s:hi('htmlSpecialChar', s:orange, '', '')

" CSS
call s:hi('cssBraces', s:fg, '', '')
call s:hi('cssClassName', s:yellow, '', '')
call s:hi('cssColor', s:pink, '', '')

" JavaScript
call s:hi('javaScriptFunction', s:purple, '', '')
call s:hi('javaScriptRailsFunction', s:blue, '', '')
call s:hi('javaScriptBraces', s:fg, '', '')

" Python
call s:hi('pythonOperator', s:purple, '', '')
call s:hi('pythonBuiltin', s:cyan, '', '')
call s:hi('pythonBuiltinObj', s:cyan, '', '')
call s:hi('pythonBuiltinFunc', s:blue, '', '')

" Markdown
call s:hi('markdownHeadingDelimiter', s:orange, '', 'bold')
call s:hi('markdownCode', s:green, '', '')
call s:hi('markdownCodeBlock', s:green, '', '')
call s:hi('markdownH1', s:fg, '', 'bold')
call s:hi('markdownH2', s:fg, '', 'bold')
call s:hi('markdownLinkText', s:blue, '', 'underline')
call s:hi('markdownBold', s:purple, '', 'bold')
call s:hi('markdownItalic', s:blue, '', 'italic')
call s:hi('markdownBoldDelimiter', s:purple, '', '')
call s:hi('markdownItalicDelimiter', s:blue, '', '')

" Git
call s:hi('gitcommitOverflow', s:red, '', '')
call s:hi('gitcommitSummary', s:green, '', '')
call s:hi('gitcommitComment', s:comment, '', 'italic')
call s:hi('gitcommitUntracked', s:comment, '', '')
call s:hi('gitcommitDiscarded', s:comment, '', '')
call s:hi('gitcommitSelected', s:comment, '', '')
call s:hi('gitcommitHeader', s:purple, '', '')
call s:hi('gitcommitSelectedType', s:blue, '', '')
call s:hi('gitcommitUnmergedType', s:blue, '', '')
call s:hi('gitcommitDiscardedType', s:blue, '', '')
call s:hi('gitcommitBranch', s:orange, '', 'bold')
call s:hi('gitcommitUntrackedFile', s:yellow, '', '')
call s:hi('gitcommitUnmergedFile', s:red, '', 'bold')
call s:hi('gitcommitDiscardedFile', s:red, '', 'bold')
call s:hi('gitcommitSelectedFile', s:green, '', 'bold')

" Tree-sitter highlights (for modern Neovim)
if has('nvim-0.8')
  call s:hi('@comment', s:comment, '', 'italic')
  call s:hi('@constant', s:pink, '', '')
  call s:hi('@constant.builtin', s:pink, '', '')
  call s:hi('@constant.macro', s:pink, '', '')
  call s:hi('@string', s:green, '', '')
  call s:hi('@string.escape', s:orange, '', '')
  call s:hi('@string.special', s:orange, '', '')
  call s:hi('@character', s:green, '', '')
  call s:hi('@number', s:pink, '', '')
  call s:hi('@boolean', s:red, '', '')
  call s:hi('@float', s:pink, '', '')
  call s:hi('@function', s:blue, '', '')
  call s:hi('@function.builtin', s:blue, '', '')
  call s:hi('@function.macro', s:blue, '', '')
  call s:hi('@method', s:blue, '', '')
  call s:hi('@constructor', s:orange, '', '')
  call s:hi('@parameter', s:cyan, '', '')
  call s:hi('@keyword', s:purple, '', '')
  call s:hi('@keyword.function', s:purple, '', '')
  call s:hi('@keyword.operator', s:purple, '', '')
  call s:hi('@keyword.return', s:purple, '', '')
  call s:hi('@conditional', s:purple, '', '')
  call s:hi('@repeat', s:purple, '', '')
  call s:hi('@label', s:purple, '', '')
  call s:hi('@operator', s:fg, '', '')
  call s:hi('@exception', s:purple, '', '')
  call s:hi('@variable', s:cyan, '', '')
  call s:hi('@variable.builtin', s:cyan, '', 'italic')
  call s:hi('@type', s:cyan, '', '')
  call s:hi('@type.builtin', s:cyan, '', '')
  call s:hi('@type.definition', s:cyan, '', '')
  call s:hi('@storageclass', s:purple, '', '')
  call s:hi('@structure', s:cyan, '', '')
  call s:hi('@namespace', s:cyan, '', '')
  call s:hi('@include', s:purple, '', '')
  call s:hi('@preproc', s:orange, '', '')
  call s:hi('@debug', s:orange, '', '')
  call s:hi('@tag', s:blue, '', '')
  call s:hi('@tag.attribute', s:orange, '', '')
  call s:hi('@tag.delimiter', s:fg, '', '')
  call s:hi('@text', s:fg, '', '')
  call s:hi('@text.strong', s:purple, '', 'bold')
  call s:hi('@text.emphasis', s:blue, '', 'italic')
  call s:hi('@text.underline', s:fg, '', 'underline')
  call s:hi('@text.strike', s:fg, '', 'strikethrough')
  call s:hi('@text.title', s:orange, '', 'bold')
  call s:hi('@text.literal', s:green, '', '')
  call s:hi('@text.uri', s:blue, '', 'underline')
  call s:hi('@text.math', s:pink, '', '')
  call s:hi('@text.reference', s:blue, '', '')
  call s:hi('@markup.strong', s:purple, '', 'bold')
  call s:hi('@markup.italic', s:blue, '', 'italic')
  call s:hi('@markup.strong.markdown_inline', s:purple, '', 'bold')
  call s:hi('@markup.italic.markdown_inline', s:blue, '', 'italic')
  call s:hi('@text.environment', s:cyan, '', '')
  call s:hi('@text.environment.name', s:cyan, '', '')
  call s:hi('@note', s:blue, '', '')
  call s:hi('@warning', s:orange, '', '')
  call s:hi('@danger', s:red, '', '')
endif

" Plugin support

" NERDTree
call s:hi('NERDTreeDir', s:blue, '', '')
call s:hi('NERDTreeDirSlash', s:blue, '', '')
call s:hi('NERDTreeOpenable', s:orange, '', '')
call s:hi('NERDTreeClosable', s:orange, '', '')
call s:hi('NERDTreeFile', s:fg, '', '')
call s:hi('NERDTreeExecFile', s:green, '', '')
call s:hi('NERDTreeUp', s:fg_dark, '', '')
call s:hi('NERDTreeCWD', s:purple, '', '')
call s:hi('NERDTreeHelp', s:comment, '', '')

" Telescope
call s:hi('TelescopeNormal', s:fg, s:bg_highlight, '')
call s:hi('TelescopeBorder', s:border, s:bg_highlight, '')
call s:hi('TelescopePromptNormal', s:fg, s:bg_highlight, '')
call s:hi('TelescopePromptBorder', s:border, s:bg_highlight, '')
call s:hi('TelescopePromptTitle', s:accent, s:bg_highlight, 'bold')
call s:hi('TelescopePreviewTitle', s:green, s:bg_highlight, 'bold')
call s:hi('TelescopeResultsTitle', s:blue, s:bg_highlight, 'bold')
call s:hi('TelescopeSelection', s:fg, s:accent_secondary, 'bold')
call s:hi('TelescopeSelectionCaret', s:accent, '', 'bold')
call s:hi('TelescopeMatching', s:orange, '', 'bold')

" LSP
call s:hi('LspDiagnosticsDefaultError', s:red, '', '')
call s:hi('LspDiagnosticsDefaultWarning', s:orange, '', '')
call s:hi('LspDiagnosticsDefaultInformation', s:blue, '', '')
call s:hi('LspDiagnosticsDefaultHint', s:cyan, '', '')
call s:hi('LspDiagnosticsVirtualTextError', s:red, '', '')
call s:hi('LspDiagnosticsVirtualTextWarning', s:orange, '', '')
call s:hi('LspDiagnosticsVirtualTextInformation', s:blue, '', '')
call s:hi('LspDiagnosticsVirtualTextHint', s:cyan, '', '')
call s:hi('LspDiagnosticsSignError', s:red, '', '')
call s:hi('LspDiagnosticsSignWarning', s:orange, '', '')
call s:hi('LspDiagnosticsSignInformation', s:blue, '', '')
call s:hi('LspDiagnosticsSignHint', s:cyan, '', '')

" Diagnostic (for Neovim 0.6+)
call s:hi('DiagnosticError', s:red, '', '')
call s:hi('DiagnosticWarn', s:orange, '', '')
call s:hi('DiagnosticInfo', s:blue, '', '')
call s:hi('DiagnosticHint', s:cyan, '', '')
call s:hi('DiagnosticVirtualTextError', s:red, '', '')
call s:hi('DiagnosticVirtualTextWarn', s:orange, '', '')
call s:hi('DiagnosticVirtualTextInfo', s:blue, '', '')
call s:hi('DiagnosticVirtualTextHint', s:cyan, '', '')
call s:hi('DiagnosticSignError', s:red, '', '')
call s:hi('DiagnosticSignWarn', s:orange, '', '')
call s:hi('DiagnosticSignInfo', s:blue, '', '')
call s:hi('DiagnosticSignHint', s:cyan, '', '')

" GitSigns
call s:hi('GitSignsAdd', s:green, '', '')
call s:hi('GitSignsChange', s:orange, '', '')
call s:hi('GitSignsDelete', s:red, '', '')

" Gitsigns (new version)
call s:hi('GitSignsAddLn', '', s:green . '20', '')
call s:hi('GitSignsChangeLn', '', s:orange . '20', '')
call s:hi('GitSignsDeleteLn', '', s:red . '20', '')

" WhichKey
call s:hi('WhichKey', s:purple, '', '')
call s:hi('WhichKeyGroup', s:blue, '', '')
call s:hi('WhichKeyDesc', s:fg, '', '')
call s:hi('WhichKeySeperator', s:comment, '', '')
call s:hi('WhichKeySeparator', s:comment, '', '')
call s:hi('WhichKeyFloat', s:fg, s:bg_highlight, '')
call s:hi('WhichKeyValue', s:comment, '', '')

" Indent Blankline
call s:hi('IndentBlanklineChar', s:border, '', '')
call s:hi('IndentBlanklineContextChar', s:accent, '', '')

" nvim-cmp
call s:hi('CmpItemAbbrDeprecated', s:fg_dark, '', 'strikethrough')
call s:hi('CmpItemAbbrMatch', s:orange, '', 'bold')
call s:hi('CmpItemAbbrMatchFuzzy', s:orange, '', 'bold')
call s:hi('CmpItemKind', s:purple, '', '')
call s:hi('CmpItemMenu', s:comment, '', '')

" Dashboard
call s:hi('DashboardShortCut', s:blue, '', '')
call s:hi('DashboardHeader', s:purple, '', '')
call s:hi('DashboardCenter', s:green, '', '')
call s:hi('DashboardFooter', s:comment, '', 'italic')

" BufferLine
call s:hi('BufferLineTab', s:fg_dark, s:bg_light, '')
call s:hi('BufferLineTabSelected', s:fg, s:bg_highlight, 'bold')
call s:hi('BufferLineTabClose', s:red, s:bg_light, '')
call s:hi('BufferLineFill', '', s:bg_dark, '')
call s:hi('BufferLineBackground', s:fg_dark, s:bg_light, '')
call s:hi('BufferLineCloseButton', s:fg_dark, s:bg_light, '')
call s:hi('BufferLineCloseButtonSelected', s:fg, s:bg_highlight, '')
call s:hi('BufferLineBuffer', s:fg_dark, s:bg_light, '')
call s:hi('BufferLineBufferSelected', s:fg, s:bg_highlight, 'bold')
call s:hi('BufferLineBufferVisible', s:fg, s:bg_light, '')
call s:hi('BufferLineModified', s:orange, s:bg_light, '')
call s:hi('BufferLineModifiedSelected', s:orange, s:bg_highlight, '')

" nvim-tree
call s:hi('NvimTreeNormal', s:fg, s:bg, '')
call s:hi('NvimTreeFolderIcon', s:blue, '', '')
call s:hi('NvimTreeRootFolder', s:purple, '', 'bold')
call s:hi('NvimTreeSymlink', s:cyan, '', 'italic')
call s:hi('NvimTreeExecFile', s:green, '', '')
call s:hi('NvimTreeImageFile', s:magenta, '', '')
call s:hi('NvimTreeSpecialFile', s:orange, '', '')
call s:hi('NvimTreeGitDirty', s:orange, '', '')
call s:hi('NvimTreeGitNew', s:green, '', '')
call s:hi('NvimTreeGitDeleted', s:red, '', '')
call s:hi('NvimTreeOpenedFolderName', s:blue, '', 'italic')

" Alpha (dashboard)
call s:hi('AlphaShortcut', s:blue, '', '')
call s:hi('AlphaHeader', s:purple, '', '')
call s:hi('AlphaHeaderLabel', s:orange, '', '')
call s:hi('AlphaFooter', s:comment, '', 'italic')
call s:hi('AlphaButtons', s:green, '', '')

" Additional language-specific highlighting

" Vim script
call s:hi('vimCommand', s:purple, '', '')
call s:hi('vimUserFunc', s:blue, '', '')
call s:hi('vimFunction', s:blue, '', '')
call s:hi('vimVar', s:cyan, '', '')
call s:hi('vimFuncName', s:blue, '', '')
call s:hi('vimIsCommand', s:purple, '', '')
call s:hi('vimHiGroup', s:orange, '', '')

" C/C++
call s:hi('cType', s:cyan, '', '')
call s:hi('cStorageClass', s:purple, '', '')
call s:hi('cConditional', s:purple, '', '')
call s:hi('cRepeat', s:purple, '', '')
call s:hi('cppType', s:cyan, '', '')
call s:hi('cppStorageClass', s:purple, '', '')

" PHP
call s:hi('phpVarSelector', s:cyan, '', '')
call s:hi('phpKeyword', s:purple, '', '')
call s:hi('phpRepeat', s:purple, '', '')
call s:hi('phpConditional', s:purple, '', '')
call s:hi('phpStatement', s:purple, '', '')
call s:hi('phpMemberSelector', s:fg, '', '')

" Ruby
call s:hi('rubySymbol', s:pink, '', '')
call s:hi('rubyConstant', s:orange, '', '')
call s:hi('rubyAccess', s:orange, '', '')
call s:hi('rubyAttribute', s:blue, '', '')
call s:hi('rubyInclude', s:purple, '', '')
call s:hi('rubyLocalVariableOrMethod', s:cyan, '', '')
call s:hi('rubyCurlyBlock', s:fg, '', '')
call s:hi('rubyStringDelimiter', s:green, '', '')
call s:hi('rubyInterpolationDelimiter', s:orange, '', '')
call s:hi('rubyConditional', s:purple, '', '')
call s:hi('rubyRepeat', s:purple, '', '')
call s:hi('rubyControl', s:purple, '', '')
call s:hi('rubyException', s:purple, '', '')

" Python (additional)
call s:hi('pythonInclude', s:purple, '', '')
call s:hi('pythonStatement', s:purple, '', '')
call s:hi('pythonConditional', s:purple, '', '')
call s:hi('pythonRepeat', s:purple, '', '')
call s:hi('pythonException', s:purple, '', '')
call s:hi('pythonFunction', s:blue, '', '')
call s:hi('pythonPreCondit', s:purple, '', '')
call s:hi('pythonExClass', s:orange, '', '')

" JavaScript (additional)
call s:hi('javaScriptConditional', s:purple, '', '')
call s:hi('javaScriptRepeat', s:purple, '', '')
call s:hi('javaScriptNumber', s:pink, '', '')
call s:hi('javaScriptMember', s:cyan, '', '')
call s:hi('javascriptNull', s:red, '', '')
call s:hi('javascriptGlobal', s:blue, '', '')
call s:hi('javascriptStatement', s:purple, '', '')

" Go
call s:hi('goDirective', s:purple, '', '')
call s:hi('goDeclaration', s:purple, '', '')
call s:hi('goStatement', s:purple, '', '')
call s:hi('goConditional', s:purple, '', '')
call s:hi('goConstants', s:pink, '', '')
call s:hi('goTodo', s:yellow, '', '')
call s:hi('goDeclType', s:cyan, '', '')
call s:hi('goBuiltins', s:blue, '', '')
call s:hi('goRepeat', s:purple, '', '')
call s:hi('goLabel', s:purple, '', '')

" Rust
call s:hi('rustKeyword', s:purple, '', '')
call s:hi('rustModPath', s:cyan, '', '')
call s:hi('rustModPathSep', s:fg, '', '')
call s:hi('rustSelf', s:cyan, '', 'italic')
call s:hi('rustSuper', s:cyan, '', 'italic')
call s:hi('rustDeriveTrait', s:orange, '', '')
call s:hi('rustAttribute', s:orange, '', '')
call s:hi('rustLifetime', s:orange, '', '')
call s:hi('rustMacro', s:blue, '', '')
call s:hi('rustQuestion', s:orange, '', 'bold')

" TypeScript
call s:hi('typescriptReserved', s:purple, '', '')
call s:hi('typescriptLabel', s:purple, '', '')
call s:hi('typescriptFuncKeyword', s:purple, '', '')
call s:hi('typescriptVariable', s:purple, '', '')
call s:hi('typescriptBraces', s:fg, '', '')
call s:hi('typescriptEndColons', s:fg, '', '')
call s:hi('typescriptDOMObjects', s:cyan, '', '')
call s:hi('typescriptAjaxMethods', s:blue, '', '')
call s:hi('typescriptLogicSymbols', s:fg, '', '')

" JSON
call s:hi('jsonKeyword', s:blue, '', '')
call s:hi('jsonQuote', s:green, '', '')
call s:hi('jsonBraces', s:fg, '', '')
call s:hi('jsonString', s:green, '', '')

" YAML
call s:hi('yamlKey', s:blue, '', '')
call s:hi('yamlAnchor', s:cyan, '', '')
call s:hi('yamlAlias', s:cyan, '', '')
call s:hi('yamlDocumentHeader', s:purple, '', '')

" XML
call s:hi('xmlTag', s:blue, '', '')
call s:hi('xmlTagName', s:blue, '', '')
call s:hi('xmlEndTag', s:blue, '', '')
call s:hi('xmlNamespace', s:orange, '', '')

" SQL
call s:hi('sqlKeyword', s:purple, '', '')
call s:hi('sqlFunction', s:blue, '', '')
call s:hi('sqlOperator', s:fg, '', '')

" Lua (additional)
call s:hi('luaStatement', s:purple, '', '')
call s:hi('luaRepeat', s:purple, '', '')
call s:hi('luaCondStart', s:purple, '', '')
call s:hi('luaCondElseif', s:purple, '', '')
call s:hi('luaCond', s:purple, '', '')
call s:hi('luaCondEnd', s:purple, '', '')

" Shell script
call s:hi('shFunction', s:blue, '', '')
call s:hi('shStatement', s:purple, '', '')
call s:hi('shConditional', s:purple, '', '')
call s:hi('shRepeat', s:purple, '', '')
call s:hi('shKeyword', s:purple, '', '')
call s:hi('shQuote', s:green, '', '')
call s:hi('shVariable', s:cyan, '', '')

" ShowMarks
call s:hi('ShowMarksHLl', s:orange, s:bg, '')
call s:hi('ShowMarksHLo', s:purple, s:bg, '')
call s:hi('ShowMarksHLu', s:yellow, s:bg, '')
call s:hi('ShowMarksHLm', s:cyan, s:bg, '')

" Cleanup
unlet s:bg s:bg_dark s:bg_light s:bg_highlight s:fg s:fg_light s:fg_dark
unlet s:accent s:accent_dark s:accent_secondary s:border
unlet s:red s:green s:yellow s:blue s:magenta s:cyan s:orange s:pink s:purple s:comment