"========================================
" fzf.vim settings
"========================================

" プロジェクト全体を検索
nnoremap <Leader>fr :Rg!<Space>

" Vimヘルプ本文を検索
command! -nargs=* RgHelp
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '
      \   . shellescape(<q-args>)
      \   . ' '
      \   . shellescape($VIMRUNTIME . '/doc'),
      \   1,
      \   fzf#vim#with_preview(),
      \   0
      \ )

nnoremap <Leader>fhf :RgHelp<Space>
nnoremap <Leader>fhh :Help<CR>

" 開いているバッファから検索
nnoremap :: :Lines<Space>

" カーソル下の単語をプロジェクト全体から検索
nnoremap <CR><CR> :Rg <C-r><C-w><CR>

" プロジェクト内のファイル検索
nnoremap <Leader>ff :Files<CR>

" Git管理されているファイルを検索
nnoremap <Leader>fg :GFiles<CR>

" 開いているバッファを検索
nnoremap <Leader>fb :Buffers<CR>

" 最近開いたファイルを検索
nnoremap <Leader>m :History<CR>

" markを検索
nnoremap <Leader>fm :Marks<CR>

nnoremap <Leader>fc :BCommits<CR>
nnoremap <Leader>fv :Commands<CR>
