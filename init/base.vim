" source $VIMRUNTIME/defaults.vim
"#####表示設定##############
"set title "編集中のファイル名を表示する
set nonu "行番号を設定する
set showmatch "『』入力時の対応する括弧を表示
set shiftwidth=2 "自動シフトの幅"
set expandtab "タブのスペース展開"
set tabstop=2 "インデントをスペース４つ分に設定
set nowrap
set scrolloff=5 "スクロールに余裕をもたせる
set sidescrolloff=7 "スクロールに余裕をもたせる
set cursorline "カーソルライン表示
set incsearch " インクリメンタルサーチ
set hlsearch " 検索ハイライト
set smartindent " 自動でインデントしてくれる

"####### エンコーディング設定
" set fileencodings=utf-8,cp832
set fileencodings=utf-8
"########swpファイル、バックアップファイル、undoファイルを出力させない。
set noswapfile
set nobackup
set noundofile
"##########検索設定############
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set hlsearch  "マッチ箇所をハイライト
"##########環境設定################
set vb t_vb=  "ビープ音ならないようにする"
set mouse=a

"##########wildmenuを有効にする（同じ階層のファイルを開く時tab選択ができるようになる。）
set wildmenu
"### cursol をモードで変化させる
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif

" tigでvimdiffを使うのでその時綺麗に見えるように
" vimdiffの色設定
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

"Yankした時にWindowsのクリップボードに共有。
augroup Yank
    au!
    autocmd TextYankPost * :call system('iconv -t utf16 | clip.exe', @")
augroup END

"ステータスラインにgithubの状態を追加
" set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

"タブ、空白、改行の可視化
set list
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

"全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
   
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

"color scheme
colorscheme lucius
set t_Co=256
set termguicolors
set background=dark

" netrwを見やすく
" ファイルツリーの表示形式、1にするとls -laのような表示になります
let g:netrw_liststyle=1
" ヘッダを非表示にする
let g:netrw_banner=0
" サイズを(K,M,G)で表示する
let g:netrw_sizestyle="H"
" 日付フォーマットを yyyy/mm/dd(曜日) hh:mm:ss で表示する
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
" プレビューウィンドウを垂直分割で表示する
let g:netrw_preview=1
