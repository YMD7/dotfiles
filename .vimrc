""--------------------
"" 基本的な設定
"--------------------
"### 表示設定 ###
set title "編集中のファイル名を表示
syntax on "コードの色分け
set tabstop=4 "インデントをスペース4つ分に設定
set smartindent "オートインデント
set autoindent "新しい行のインデントを現在行と同じにする
set number "行番号を表示する
set showmatch "閉括弧が入力された時、対応する括弧を強調する
set smarttab "新しい行を作った時に高度な自動インデントを行う

"" Solarized ""
set background=dark
colorscheme solarized

" ### 検索設定 ###
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

"--------------------
"" NeoBundle
""  #Install
""   mkdir -p ~/.vim/bundle
""   git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
""   git clone https://github.com/Shougo/vimproc ~/.vim/bundle/vimproc
"--------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
 
" ------- Plug-ins ------
" ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'
""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""

" Rubyのendキーワードを自動挿入
NeoBundle 'tpope/vim-endwise'

" コメントON/OFFを Ctrl+- で実行
NeoBundle 'tomtom/tcomment_vim'

" 行末の半角スペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'

call neobundle#end()

" Required:
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck

