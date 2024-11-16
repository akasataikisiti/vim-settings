let g:db_ui_execute_on_save = 0

let g:db_ui_table_helpers = {
    \ 'mysql': {
    \   'Count': 'select count(*) from {optional_schema}{table}',
    \   'Explain': 'EXPLAIN ANALYZE {last_query}'
    \ }
\ }

" 自動でフォールディングが閉じるのを防ぐ
augroup AutoOpenFoldsForDbout
    autocmd!
    autocmd FileType dbout setlocal nofoldenable
augroup END
