function! TabnewOrGoNext()
  " 現在のタブの数を取得
  let tab_count = tabpagenr('$')
  if tab_count == 1
    " タブが1つしかない場合、新しいタブを作成
    tabnew
  else
    " タブが2つ以上ある場合、次のタブに移動
    tabnext
  endif
endfunction

function! TabnewOrGoPrev()
  " 現在のタブの数を取得
  let tab_count = tabpagenr('$')
  if tab_count < 3
    " タブが1つしかない場合、新しいタブを作成
    tabnew
  else
    " タブが2つ以上ある場合、次のタブに移動
    tabp
  endif
endfunction

command! -nargs=0 TabnewOrGoNext call TabnewOrGoNext()
command! -nargs=0 TabnewOrGoPrev call TabnewOrGoPrev()

" delete no name buffers
function! CloseUnnamedBuffers()
  " 全タブをループ
  let tabs = tabpagenr('$')
  for tab in range(1, tabs)
    " タブ内の全ウィンドウをループ
    let win_ids = tabpagebuflist(tab)
    for win_id in win_ids
      let buf_id = winbufnr(win_id)
      let buf_name = bufname(buf_id)
      " バッファが無名の場合、ウィンドウを閉じる
      if buf_name == ''
        " call win_close(win_id)
        call win_execute(win_id, 'close')
      endif
    endfor
    execute tab . 'tabnext'
  endfor
  " バッファリストを通して無名バッファを削除
  let buffers = filter(range(1, bufnr('$')), 'bufname(v:val) == ""')
  for buf in buffers
    execute 'bwipeout ' . buf
  endfor
endfunction

command! -nargs=0 CloseUnnamedBuffers call CloseUnnamedBuffers()


function! SetCurrentDirToGitRoot()
  let l:git_root_marker = '.git'
  let l:current_file = expand('%:p')
  let l:git_root = finddir(l:git_root_marker, l:current_file . ';')

  if l:git_root != ''
    let l:git_root_path = substitute(l:git_root, l:git_root_marker . '$', '', '')
    echo l:git_root_path
    execute 'cd ' . l:git_root_path
  else
    echo "No repo found."
  endif
endfunction
