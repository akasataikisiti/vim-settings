"##############vim-plugでプラグインを管理#############
call plug#begin()
Plug 'easymotion/vim-easymotion' " cursor move
Plug 'yegappan/mru'
Plug 'tpope/vim-commentary'
Plug 'mileszs/ack.vim'
Plug 'mbbill/undotree'
Plug 'lambdalisue/fern.vim'
Plug 'alvan/vim-closetag'
" Plug 'sirver/ultisnips'
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

Plug 'tpope/vim-dadbod'  " database manipulate on vim いつか実験してみる
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'kristijanhusak/vim-dadbod-ui'

Plug 'vim-scripts/rfc-syntax'
Plug 'luisjure/csound-vim'

Plug 'ctrlpvim/ctrlp.vim'
" Plug 'ryanoasis/vim-devicons'   " icons (wsl2 not support devicons )
Plug 'christoomey/vim-system-copy'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'Shougo/ddc.vim' "ddc.vim本体
Plug 'vim-denops/denops.vim' " DenoでVimプラグインを開発するためのプラグイン
Plug 'Shougo/pum.vim' " ポップアップウィンドウを表示するプラグイン
Plug 'Shougo/ddc-ui-pum' 
Plug 'Shougo/ddc-around' " カーソル周辺の既出単語を補完するsource
Plug 'shun/ddc-source-vim-lsp' " ddcとlspをつなぐ
Plug 'LumaKernel/ddc-file' " ファイル名を補完するsource
Plug 'Shougo/ddc-matcher_head' " 入力中の単語を補完の対象にするfilter
Plug 'Shougo/ddc-sorter_rank' " 補完候補を適切にソートするfilter
Plug 'Shougo/ddc-converter_remove_overlap' " 補完候補の重複を防ぐためのfilter
call plug#end()

