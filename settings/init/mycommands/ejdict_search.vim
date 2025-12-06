" 例: ~/.vim/plugin/ejdict_search_cursor.vim などに保存

" config ディレクトリを取得
function! s:GetConfigDir() abort
  if exists('*stdpath')
    " Neovim
    return stdpath('config')
  else
    " Vim
    return fnamemodify($MYVIMRC, ':h')
  endif
endfunction

" 実際の検索処理（単語＋モードを受け取る）
function! s:EjdictSearch(word, mode) abort
  if empty(a:word)
    echo 'カーソル下に単語がありません'
    return
  endif

  let l:config_dir = s:GetConfigDir()
  let l:db = l:config_dir . '/ejdict.sqlite3'

  if !filereadable(l:db)
    echohl ErrorMsg
    echom 'ejdict.sqlite3 が見つかりません: ' . l:db
    echohl None
    return
  endif

  " SQL 用にクォートをエスケープ
  let l:sql_word = substitute(a:word, "'", "''", "g")

  " LIKE 用: %, _ をエスケープしつつ ' もエスケープ
  let l:like_word = escape(a:word, '%_')
  let l:like_word = substitute(l:like_word, "'", "''", "g")

  " モードごとに SQL を組み立て
  if a:mode ==# 'contains'
    " 部分一致: %word%
    let l:pattern = printf('%%%%%s%%%%', l:like_word)
    let l:sql = printf(
          \ "select word, mean from items where word like '%s';",
          \ l:pattern
          \ )
  elseif a:mode ==# 'prefix'
    " 前方一致: word%
    let l:pattern = printf('%s%%%%', l:like_word)
    let l:sql = printf(
          \ "select word, mean from items where word like '%s';",
          \ l:pattern
          \ )
  elseif a:mode ==# 'suffix'
    " 後方一致: %word
    let l:pattern = printf('%%%%%s', l:like_word)
    let l:sql = printf(
          \ "select word, mean from items where word like '%s';",
          \ l:pattern
          \ )
  elseif a:mode ==# 'exact'
    " 完全一致: =
    let l:sql = printf(
          \ "select word, mean from items where word = '%s';",
          \ l:sql_word
          \ )
  else
    echohl ErrorMsg
    echom '未知の検索モード: ' . a:mode
    echohl None
    return
  endif

  " sqlite3 実行（word  :  mean 形式で出力）
  let l:cmd = printf(
        \ 'sqlite3 -separator "  :  " %s %s',
        \ shellescape(l:db),
        \ shellescape(l:sql)
        \ )

  let l:result = systemlist(l:cmd)

  if v:shell_error
    echohl ErrorMsg
    echom 'sqlite3 実行時にエラーが発生しました'
    echohl None
    return
  endif

  " vsplit して結果表示用バッファを作る
  vsplit
  enew
  setlocal buftype=nofile bufhidden=wipe noswapfile
  setlocal nobuflisted
  " このバッファ内では q で閉じられるようにする
  nnoremap <silent> <buffer> q :bd<CR>

  if empty(l:result)
    call setline(1, ['(no result)'])
  else
    call setline(1, l:result)
  endif

  normal! gg
endfunction

" カーソル下の単語で検索するラッパー
function! s:EjdictSearchCursor(mode) abort
  let l:word = expand('<cword>')
  call s:EjdictSearch(l:word, a:mode)
endfunction

" 🔗 マッピング一覧
" 部分一致: %word%
nnoremap <silent> <leader>ej :call <SID>EjdictSearchCursor('contains')<CR>
" 前方一致: word%
nnoremap <silent> <leader>ef :call <SID>EjdictSearchCursor('prefix')<CR>
" 後方一致: %word
nnoremap <silent> <leader>eb :call <SID>EjdictSearchCursor('suffix')<CR>
" 完全一致: =
nnoremap <silent> <leader>ee :call <SID>EjdictSearchCursor('exact')<CR>

" 🔧 コマンドも用意しておくと便利
command! EjdictCursorContains call <SID>EjdictSearchCursor('contains')
command! EjdictCursorPrefix   call <SID>EjdictSearchCursor('prefix')
command! EjdictCursorSuffix   call <SID>EjdictSearchCursor('suffix')
command! EjdictCursorExact    call <SID>EjdictSearchCursor('exact')

