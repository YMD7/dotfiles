""###  表示 ###
syntax on "コードの色分け
set title "編集中のファイル名を表示
set expandtab "TABキーでスペースを挿入する"
set tabstop=2 "インデントをスペース4つ分に設定
set shiftwidth=2
set smartindent "オートインデント
set autoindent "新しい行のインデントを現在行と同じにする
set number "行番号を表示する
set showmatch "閉括弧が入力された時、対応する括弧を強調する
set smarttab "新しい行を作った時に高度な自動インデントを行う

""### 編集 ###
set backspace=indent,eol,start "バックスペースで削除の有効化

""### 検索 ###
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/kyo/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/kyo/.vim/dein')
  call dein#begin('/Users/kyo/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/kyo/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  "-- コメントのON/OFFを Ctrl & - で実行
  call dein#add('tomtom/tcomment_vim')
	"-- 行末の半角スペースを可視化
	call dein#add('bronson/vim-trailing-whitespace')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
