"#########ack.vimを動かさせるために以下の記述が必要だった。
" let g:ackprg = "/home/kosuke/bin/ack -s -H --nocolor --nogroup --column"
let g:ackprg = substitute(system('which ack'), '\n', '', '') . ' -s -H --nocolor --nogroup --column'

nnoremap <Leader>fr :Ack!<space>

