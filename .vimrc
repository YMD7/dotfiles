""--------------------
"" 基本的な設定
"--------------------
"### 表示設定 ###
set title "編集中のファイル名を表示
syntax on "コードの色分け
set tabstop=2 "インデントをスペース4つ分に設定
set smartindent "オートインデント
set autoindent "新しい行のインデントを現在行と同じにする
set number "行番号を表示する
set showmatch "閉括弧が入力された時、対応する括弧を強調する
set smarttab "新しい行を作った時に高度な自動インデントを行う

"### テーマ ###
set background=dark
colorscheme itg_flat

"### 検索設定 ###
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

"### プラグイン管理ツール ###

"【インストール手順】
"  $ mkdir -p ~/.vim/dein
"  $ git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/dein.vim
" あとは以下の"dein Scripts"部分が.vimrcに書かれていれば
" vimを起動すると自動的にインストールしてくれる。

"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

" Required:
set runtimepath^=~/.vim/dein/dein.vim

" Required:
call dein#begin(expand('~/.vim/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

"-- itg_flatのカラーテーマ
call dein#add('cdmedia/itg_flat_vim')
"-- コメントON/OFFを Ctrl+- で実行
call dein#add('tomtom/tcomment_vim')
"-- 行末の半角スペースを可視化
call dein#add('bronson/vim-trailing-whitespace')

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

