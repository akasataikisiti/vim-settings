nnoremap <leader>gs :Git<CR>

" コミットIDを手入力して、カレントファイルとそのコミット時点の内容を縦分割diffする。
function! s:git_diff_current_file_commit(...) abort
  if !exists(':Gvdiffsplit')
    echohl ErrorMsg
    echomsg 'vim-fugitive is not available.'
    echohl None
    return
  endif

  let l:commit = a:0 ? a:1 : input('Commit ID to diff current file: ', 'HEAD~1')
  if empty(l:commit)
    return
  endif

  execute 'Gvdiffsplit ' . fnameescape(l:commit)
endfunction

" QuickUIの候補に出すため、HEADとカレントファイルの変更履歴を取得する。
function! s:current_file_git_log(limit) abort
  let l:file = expand('%:p')
  if empty(l:file)
    echohl WarningMsg
    echomsg 'Git diff: current buffer has no file.'
    echohl None
    return []
  endif

  let l:file_dir = fnamemodify(l:file, ':h')
  let l:head_line = systemlist('git -C ' . shellescape(l:file_dir) . ' log -1 --format=%h\ %s HEAD')
  if v:shell_error || empty(l:head_line)
    echohl ErrorMsg
    echomsg 'Git diff: failed to read HEAD commit.'
    echohl None
    return []
  endif

  let l:cmd = 'git -C ' . shellescape(l:file_dir)
        \ . ' log --follow --oneline -n ' . a:limit
        \ . ' -- ' . shellescape(l:file)
  let l:logs = systemlist(l:cmd)

  if v:shell_error
    echohl ErrorMsg
    echomsg 'Git diff: failed to read current file history.'
    echohl None
    return []
  endif

  let l:head_hash = matchstr(l:head_line[0], '^\x\+')
  let l:logs = filter(l:logs, '!empty(v:val) && !empty(matchstr(v:val, ''^\x\+'')) && matchstr(v:val, ''^\x\+'') !=# l:head_hash')

  return l:head_line + l:logs
endfunction

" QuickUIでコミットを選び、カレントファイルとの差分を縦分割で表示する。
function! s:git_diff_current_file_commit_select() abort
  if !exists(':Gvdiffsplit')
    echohl ErrorMsg
    echomsg 'vim-fugitive is not available.'
    echohl None
    return
  endif

  let l:logs = s:current_file_git_log(30)
  if empty(l:logs)
    echohl WarningMsg
    echomsg 'Git diff: no commits found for current file.'
    echohl None
    return
  endif

  let l:items = [
        \ {'type': 'label', 'text': 'Diff current file with commit:'},
        \ {'type': 'dropdown', 'name': 'commit', 'prompt': 'Commit:', 'items': l:logs, 'value': 0},
        \ {'type': 'button', 'name': 'confirm_button', 'items': [' &Diff ', ' &Cancel ']},
        \ ]

  try
    let l:result = quickui#dialog#open(l:items, {'title': 'Git Diff', 'w': 80, 'focus': 'commit'})
  catch /^Vim\%((\a\+)\)\=:E117/
    echohl ErrorMsg
    echomsg 'vim-quickui is not installed. Run :PlugInstall first.'
    echohl None
    return
  endtry

  if l:result.button_index != 0 || l:result.button ==# ''
    return
  endif

  let l:selected = l:logs[l:result.commit]
  let l:commit = matchstr(l:selected, '^\x\+')
  if empty(l:commit)
    return
  endif

  call s:git_diff_current_file_commit(l:commit)
endfunction

" :GitDiffCurrentFileCommit {commit} でカレントファイルを指定コミットとdiffする。
command! -nargs=? GitDiffCurrentFileCommit call s:git_diff_current_file_commit(<f-args>)
" :GitDiffCurrentFileCommitSelect でコミット選択ダイアログからdiff対象を選ぶ。
command! -nargs=0 GitDiffCurrentFileCommitSelect call s:git_diff_current_file_commit_select()
" <leader>sd はコミットIDを手入力してdiffする。
nnoremap <leader>sd :GitDiffCurrentFileCommit<CR>
" <leader>sc はQuickUIでコミットを選んでdiffする。
nnoremap <leader>sc :GitDiffCurrentFileCommitSelect<CR>
