"###UndoTree呼び出し、閉じる
nnoremap <F5>  :UndotreeToggle<cr>
"###相対行表示の切り替え

"HTMLタグの上のカーソル移動を効率化させる拡張スクリプトを有効化
source $VIMRUNTIME/macros/matchit.vim

nnoremap sf :Fern . -drawer -toggle<CR>
let g:EasyMotion_do_mapping=0
map <C-f> <Plug>(easymotion-bd-f)
nmap <C-f> <Plug>(easymotion-overwin-f)
map <C-l> <Plug>(easymotion-bd-jk)
nmap <C-l> <Plug>(easymotion-overwin-line)

"translatevim用の設定
let g:translate_source = "en"
let g:translate_target = "ja"
let g:translate_winsize = 10
vnoremap <F3> :Translate<CR>
vnoremap <F4> :Translate!<CR>
"##############vim-plugでプラグインを管理#############
call plug#begin()
Plug 'easymotion/vim-easymotion' " cursor move
Plug 'yegappan/mru'
Plug 'tpope/vim-commentary'
Plug 'mileszs/ack.vim'
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
" Plug 'skanehira/translate.vim'
Plug 'skanehira/denops-translate.vim'
Plug 'vim-denops/denops.vim'
Plug 'tpope/vim-surround'
Plug 'jonathanfilip/vim-lucius' " color scheme
Plug 'yuucu/vimq.vim' " これはqにオプションを正しく渡せてないから自分でnvimように作りたい。あとこれに訂正出してもいいかも
Plug 'yuratomo/w3m.vim'

Plug 'tpope/vim-dadbod'  " database manipulate on vim
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'kristijanhusak/vim-dadbod-ui'
" Plug 'ryanoasis/vim-devicons'   " icons (wsl2 not support devicons )
call plug#end()

"#### denops
let g:denops#deno = '/home/linuxbrew/.linuxbrew/bin/deno'

"#########ack.vimを動かさせるために以下の記述が必要だった。
" let g:ackprg = "/home/kosuke/bin/ack -s -H --nocolor --nogroup --column"
let g:ackprg = substitute(system('which ack'), '\n', '', '') . ' -s -H --nocolor --nogroup --column'

"#######UltiSnipsのスニペットファイル置き場の定義
let g:UltiSnipsSnippetsDir=expand("$HOME/dotfiles/.vim/UltiSnips")
"########UltiSnipsの起動とリスト表示
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-z>"
let g:UltiSnipsEditSplit="vertical"
"######vim-airlineの設定
let g:airline#extensions#tabline#enabled = 1 " タブラインを表示

"### auto-pairs
let g:AutoPairsMapCh = 0

"#####vimwikiを正常動作させるのに必要らしい
set nocompatible
filetype plugin on  " netrw もこれでonになる
syntax on

let g:vimwiki_list = [{'path':'~/workobsi/', 'syntax': 'markdown', 'ext': 'md'}]
" autocmd FileType vimwiki hi VimwikiHeader1 guibg=#99b3b3
autocmd FileType vimwiki hi VimwikiHeader1 guibg=#596ca3
" autocmd FileType vimwiki hi VimwikiHeader1 guibg=#3b586a
" autocmd FileType vimwiki hi VimwikiHeader1 guibg=#485d6d


" 基本設定の読み込み
runtime! /init/*.vim
