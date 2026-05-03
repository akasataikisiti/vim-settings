let g:quickui_border_style = 2

function! s:substitute_delim_escape(value) abort
  return escape(a:value, '/')
endfunction

function! s:substitute_replacement_escape(value) abort
  return escape(a:value, '/\&')
endfunction

function! s:build_substitute_pattern(search, mode, whole_word, case_mode) abort
  let l:pattern = s:substitute_delim_escape(a:search)

  if a:whole_word
    let l:pattern = '\<' . l:pattern . '\>'
  endif

  if a:mode ==# 1
    let l:pattern = '\v' . l:pattern
  elseif a:mode ==# 2
    let l:pattern = '\V' . l:pattern
  endif

  if a:case_mode ==# 1
    let l:pattern = '\c' . l:pattern
  elseif a:case_mode ==# 2
    let l:pattern = '\C' . l:pattern
  endif

  return l:pattern
endfunction

function! s:build_substitute_range(scope, range_start, range_end) abort
  if a:scope ==# 0
    return a:range_start . ',' . a:range_end
  elseif a:scope ==# 1
    return '%'
  endif

  return '.'
endfunction

function! s:quick_substitute(range_start, range_end) abort
  let l:scope_items = ['Current range', 'Whole file', 'Current line']
  let l:mode_items = ['Normal', 'Very magic', 'Literal']
  let l:case_items = ['Default', 'Ignore case', 'Match case']
  let l:default_scope = a:range_start == a:range_end ? 2 : 0

  let l:items = [
        \ {'type': 'label', 'text': 'Substitute:'},
        \ {'type': 'input', 'name': 'search', 'prompt': 'Search:', 'history': 'quick_substitute_search'},
        \ {'type': 'input', 'name': 'replace', 'prompt': 'Replace:', 'history': 'quick_substitute_replace'},
        \ {'type': 'dropdown', 'name': 'mode', 'prompt': 'Mode:', 'items': l:mode_items, 'value': 0},
        \ {'type': 'dropdown', 'name': 'scope', 'prompt': 'Scope:', 'items': l:scope_items, 'value': l:default_scope},
        \ {'type': 'dropdown', 'name': 'case_mode', 'prompt': 'Case:', 'items': l:case_items, 'value': 0},
        \ {'type': 'check', 'name': 'global', 'text': 'Replace all matches in each line', 'value': 1},
        \ {'type': 'check', 'name': 'confirm', 'text': 'Confirm each replacement'},
        \ {'type': 'check', 'name': 'whole_word', 'text': 'Match whole words only'},
        \ {'type': 'button', 'name': 'confirm_button', 'items': [' &OK ', ' &Cancel ']},
        \ ]

  try
    let l:result = quickui#dialog#open(l:items, {'title': 'Substitute', 'w': 58, 'focus': 'search'})
  catch /^Vim\%((\a\+)\)\=:E117/
    echohl ErrorMsg
    echomsg 'vim-quickui is not installed. Run :PlugInstall first.'
    echohl None
    return
  endtry

  if l:result.button_index < 0 || (l:result.button !=# '' && l:result.button_index != 0)
    return
  endif

  if empty(get(l:result, 'search', ''))
    echohl WarningMsg
    echomsg 'QuickSubstitute: search text is empty.'
    echohl None
    return
  endif

  let l:range = s:build_substitute_range(l:result.scope, a:range_start, a:range_end)
  let l:pattern = s:build_substitute_pattern(l:result.search, l:result.mode, l:result.whole_word, l:result.case_mode)
  let l:replacement = s:substitute_replacement_escape(l:result.replace)
  let l:flags = (l:result.global ? 'g' : '') . (l:result.confirm ? 'c' : '')

  execute l:range . 's/' . l:pattern . '/' . l:replacement . '/' . l:flags
endfunction

command! -range QuickSubstitute call s:quick_substitute(<line1>, <line2>)

nnoremap <leader>sr :QuickSubstitute<CR>
vnoremap <leader>sr :QuickSubstitute<CR>
