"#####vimwikiを正常動作させるのに必要らしい
set nocompatible
filetype plugin on  " netrw もこれでonになる
syntax on

let g:vimwiki_list = [{'path':'~/workobsi/', 'syntax': 'markdown', 'ext': 'md'}]
" autocmd FileType vimwiki hi VimwikiHeader1 guibg=#99b3b3
autocmd FileType vimwiki hi VimwikiHeader1 guibg=#596ca3
" autocmd FileType vimwiki hi VimwikiHeader1 guibg=#3b586a
" autocmd FileType vimwiki hi VimwikiHeader1 guibg=#485d6d
