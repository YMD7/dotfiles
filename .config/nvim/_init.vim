"============================================
" Dein
"============================================
if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

"### for Intel Mac
"let g:python_host_prog   = $PYENV_ROOT.'/versions/py2nvim/bin/python'
"let g:python3_host_prog  = $PYENV_ROOT.'/versions/py3nvim/bin/python'

"### for Arm Mac
let g:python_host_prog   = '/usr/bin/python'
let g:python3_host_prog  = $PYENV_ROOT.'/versions/3.9.1/bin/python'

"### Auto install itself
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

"### Plugins ###
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  let s:toml_dir = expand('~/.config/nvim')
  call dein#load_toml(s:toml_dir . '/dein.toml', { 'lazy': 0 })
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', { 'lazy': 1 })

  call dein#end()
  call dein#save_state()
endif

"### Install plugins not installed yet
if dein#check_install()
  call dein#install()
endif

"============================================
" Vim
"============================================
"### Initialize ###
lang en_US.UTF-8
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
filetype plugin indent on

"### Display ###
syntax on "コードの色分け
set title "編集中のファイル名を表示
set number "行番号を表示する
set laststatus=2 "ステータスラインを表示
set mouse= "クリックでのカーソル移動を無効化
let g:vim_json_syntax_conceal=0 "JSON のダブルクォーテーションの非表示化を無効にする

"### Buffer ###
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

"### Screen ###
nnoremap tj <C-w>j
nnoremap tk <C-w>k
nnoremap tl <C-w>l
nnoremap th <C-w>h
call submode#enter_with('bufmove', 'n', '', 't>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 't<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 't+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 't-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

"### Editing ###
map <F1> <Esc> "F1キーをヘルプのショートカットから Esc にリマップ
imap <F1> <Esc> "F1キーをヘルプのショートカットから Esc にリマップ
set tabstop=2 "インデントの量
set expandtab "Tabキーを押したときにスペースを挿入
set shiftwidth=2 "自動的に挿入されるスペースの量
set showmatch "閉括弧が入力された時、対応する括弧を強調する
set hidden "保存されてないファイルがあっても別ファイルを開ける
set clipboard+=unnamedplus "ヤンクしたテキストをそのままクリップボードにコピー

"### Searching ###
set nohlsearch
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

"### Color Theme ###
colorscheme Tomorrow-Night-Bright

"### For vimdiff ###
if &diff
  highlight DiffAdd cterm=none ctermfg=green ctermbg=black
  highlight DiffDelete cterm=none ctermfg=darkred ctermbg=black
  highlight DiffChange cterm=none ctermfg=none ctermbg=black
  highlight DiffText cterm=none ctermfg=black ctermbg=darkyellow
endif

"### Auto-complete XML/HTML Close Tag ###
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

"### htmlタグの改行とインデント ###
function! Expander()
  let line   = getline(".")
  let col    = col(".")
  let first  = line[col-2]
  let second = line[col-1]
  let third  = line[col]

  if first ==# ">"
    if second ==# "<" && third ==# "/"
      return "\<CR>\<C-o>==\<C-o>O"
    else
      return "\<CR>"
    endif
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr><CR> Expander()

"### for vim-anzu ###
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
set statusline=%{anzu#search_status()}

"### JSON, Markdown ファイルを開くときは indentLine を OFFにする
"ダブルクオーテーションやアスタリスクの非表示対策
autocmd Filetype json let g:indentLine_enabled = 0
autocmd Filetype markdown let g:indentLine_enabled = 0
au FileType markdown set conceallevel=0

"### filetype によってインデントを切り替える
augroup IndentByFileType
    autocmd!
    autocmd BufRead,BufNewFile *.go setlocal noexpandtab "Go はインデントをハードタブにする
augroup END

"### Tabnine ###
lua <<EOF
require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt"},
  log_file_path = nil, -- absolute path to Tabnine log file
})
EOF
