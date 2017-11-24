""--------------------
"" 基本的な設定
"--------------------
"### エンコード設定 ###
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

"### 表示設定 ###
set title "編集中のファイル名を表示
syntax on "コードの色分け
set expandtab "Tabキーを押したときにスペースを挿入
set tabstop=2 "インデントの量
set shiftwidth=2 "自動的に挿入されるスペースの量
set smartindent "オートインデント
set autoindent "新しい行のインデントを現在行と同じにする
set number "行番号を表示する
set showmatch "閉括弧が入力された時、対応する括弧を強調する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する
set smarttab "新しい行を作った時に高度な自動インデントを行う
set hidden "保存されてないファイルがあっても別ファイルを開ける
set backspace=indent,eol,start "バックスペースで削除を有効化
set laststatus=2 "ステータスラインを表示
set noshowmode "モードを非表示

"### テーマ ###
set background=dark
colorscheme itg_flat

"### 検索設定 ###
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る



"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim')
  call dein#begin('~/.vim')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  "-- itg_flatのカラーテーマ
  call dein#add('cdmedia/itg_flat_vim')
  "-- コメントON/OFFを Ctrl+- で実行
  call dein#add('tomtom/tcomment_vim')
  "-- 行末の半角スペースを可視化
  call dein#add('bronson/vim-trailing-whitespace')
  "-- Rubyのend閉じを自動で挿入
  call dein#add('tpope/vim-endwise')
  "-- 自動補完
  call dein#add('Shougo/neocomplete.vim')
  "-- Javascriptのシンタックスカラー
  call dein#add('jelera/vim-javascript-syntax')
  "-- css3のシンタックスカラー
  call dein#add('hail2u/vim-css3-syntax')
  "-- html5のシンタックスカラー
  call dein#add('othree/html5.vim')
  "-- Emmet
  call dein#add('mattn/emmet-vim')
  "-- 括弧の自動挿入
  call dein#add('cohama/lexima.vim')
  "-- JSONのダブルクォートが表示されない問題の回避
  call dein#add('elzr/vim-json')
  let g:vim_json_syntax_conceal = 0
  "-- Slimのシンタックス
  call dein#add('slim-template/vim-slim')
  autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
  "-- インデントの可視化
  call dein#add('Yggdroot/indentLine')
  let g:indentLine_char = '│'
  let g:indentLine_color_term = 236
  "-- ステータスラインのカスタマイズ
  call dein#add('itchyny/lightline.vim')
  let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()

endif

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"========= neocomplete setting =========
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"========= neosnippet setting ========
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Custom Snippets Directory
let g:neosnippet#snippets_directory='~/.vim/dein/repos/github.com/Shougo/neosnippet-snippets/MySnippet'
