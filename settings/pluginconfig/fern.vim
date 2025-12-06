nnoremap sf :Fern . -drawer -toggle<CR>

" アイコン付きレンダラーを使う
let g:fern#renderer = 'nerdfont'
" Git ステータスのハイライトなどの設定例
let g:fern#renderer#nerdfont#options = {
      \ 'glyph_palette': 'nerd',
      \ 'highlight_git': 1,
      \ }

" netrw を殺して fern をメインファイラーに
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" - で現在のファイル位置を中心に fern を開く
nnoremap <silent> - :<C-u>Fern . -reveal=% -drawer -toggle<CR>

function! s:fern_my_mappings() abort
  " fern バッファ内で q でウィンドウを閉じる
  nnoremap <silent> <buffer> q :<C-u>quit<CR>
endfunction

augroup my_fern_mappings
  autocmd!
  autocmd FileType fern call s:fern_my_mappings()
augroup END


