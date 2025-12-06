augroup GemniGemtextEnter
  autocmd!
  " filetype が gemtext のときだけ、ノーマルモードの Enter で :GemvimGX を実行
  autocmd FileType gemtext,text nnoremap <buffer> <CR> :GemivimGX<CR>
  autocmd FileType gemtext nnoremap <buffer> ga :GemivimAddBookmark<CR>

augroup END

" gemni プラグイン用ブックマークファイルの動的設定
let g:gemini_bookmarks_file = expand('~/.vim/gemnibookmark/bookmarks.txt')


" No Name バッファで ge を押したら :GemivimOpen を実行
nnoremap <silent> ge :call Gemni_Ge_Open()<CR>
nnoremap <silent> go :GemivimOpenBookmark<CR>

function! Gemni_Ge_Open()
  " No Name バッファ判定
  if bufname('%') ==# ''
    " 未保存バッファなら GemivimOpen 実行
    execute 'GemivimOpen'
  else
    " 普通のファイルでは元の ge にフォールバック
    execute 'normal! ge'
  endif
endfunction

