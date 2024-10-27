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

Plug 'ctrlpvim/ctrlp.vim'
" Plug 'ryanoasis/vim-devicons'   " icons (wsl2 not support devicons )
call plug#end()

