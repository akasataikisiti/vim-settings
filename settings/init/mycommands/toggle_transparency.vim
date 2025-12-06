" 背景透過の ON/OFF フラグ
if !exists('g:transparent_enabled')
  let g:transparent_enabled = 0
endif

" 「不透明モードのときの背景色」をここで決める
" 好きな色に変えてOK
if !exists('g:toggle_bg_cterm')
  " let g:toggle_bg_cterm = '0'   " 黒
  " let g:toggle_bg_cterm = '240' " 濃いグレー
  " let g:toggle_bg_cterm = '235' " 256色ターミナル用：暗めのグレー (cterm=235)
  let g:toggle_bg_cterm = '234'      " かなり暗い濃紺グレー
endif
if !exists('g:toggle_bg_gui')
  " let g:toggle_bg_gui   = 'Black'  " 黒
  " let g:toggle_bg_gui   = '#444444'  " GUI 用：濃いグレー
  " let g:toggle_bg_gui = '#262626' GUI / truecolor 用：#262626（暗いグレー）
  let g:toggle_bg_gui   = '#002b36'  " solarized の base03
endif

function! ToggleTransparent() abort
  if g:transparent_enabled
    " ---- 透過 → 「元の色（ここで決めた色）」に戻す ----
    execute 'highlight Normal ctermbg=' . g:toggle_bg_cterm . ' guibg=' . g:toggle_bg_gui
    let g:transparent_enabled = 0
    echo 'Vim background: normal'
  else
    " ---- 通常 → 透過にする ----
    highlight Normal ctermbg=NONE guibg=NONE
    let g:transparent_enabled = 1
    echo 'Vim background: transparent'
  endif
endfunction

" ノーマルモードで <C-p> でトグル
nnoremap <C-p> :call ToggleTransparent()<CR>

