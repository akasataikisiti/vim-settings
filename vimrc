
"###UndoTree呼び出し、閉じる
nnoremap <F5>  :UndotreeToggle<cr>
"###相対行表示の切り替え

"HTMLタグの上のカーソル移動を効率化させる拡張スクリプトを有効化
source $VIMRUNTIME/macros/matchit.vim

nnoremap :f :Fern . -drawer
let g:EasyMotion_do_mapping=0
map <C-f> <Plug>(easymotion-bd-f)
nmap <C-f> <Plug>(easymotion-overwin-f)
map <C-l> <Plug>(easymotion-bd-jk)
nmap <C-l> <Plug>(easymotion-overwin-line)

"translatevim用の設定
let g:translate_source = "en"
let g:translate_target = "ja"
let g:translate_winsize = 10
vnoremap <F3> :Translate
vnoremap <F4> :Translate!
"##############vim-plugでプラグインを管理#############
call plug#begin()
Plug 'easymotion/vim-easymotion' " cursor move
Plug 'yegappan/mru'
Plug 'tpope/vim-commentary'
Plug 'mileszs/ack.vim'
Plug 'preservim/tagbar'
Plug 'mbbill/undotree'
Plug 'lambdalisue/fern.vim'
Plug 'alvan/vim-closetag'
Plug 'sirver/ultisnips'
Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'skanehira/vsession'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'skanehira/translate.vim'
Plug 'tpope/vim-surround'
Plug 'jonathanfilip/vim-lucius' " color scheme
call plug#end()

"#########ack.vimを動かさせるために以下の記述が必要だった。
let g:ackprg = "/home/kosuke/bin/ack -s -H --nocolor --nogroup --column"

"#######UltiSnipsのスニペットファイル置き場の定義
let g:UltiSnipsSnippetsDir=expand("$HOME/dotfiles/.vim/UltiSnips")
"########UltiSnipsの起動とリスト表示
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsEditSplit="vertical"

"######vim-airlineの設定
let g:airline#extensions#tabline#enabled = 1 " タブラインを表示


"#####vimwikiを正常動作させるのに必要らしい
set nocompatible
filetype plugin on  " netrw もこれでonになる
syntax on

let g:vimwiki_list = [{'path':'~/workobsi/', 'syntax': 'markdown', 'ext': 'md'}]

" 基本設定の読み込み
runtime! /init/*.vim
