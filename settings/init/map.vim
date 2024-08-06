" read mycmdファイル
source ~/.vim/settings/init/mycommands/mycmd.vim

" nnoremap <Leader>cv :e ~/cheatsheets/vim.txt
nnoremap <Leader>ev :e ~/.vim/vimrc<CR>

nnoremap <Leader>m  :MRU<CR>

"####レジスタ使用しない削除機能
nnoremap <leader>d "_d
nnoremap x "_x

"### Yank
nnoremap Y y$

"########ウィンドウ操作マッピング
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
map sr <C-w>r
map sR <C-w>R
map st <C-w>T
"水平分割を垂直分割に直す
map sH <c-w>t<c-w>H
"垂直分割を水平分割に直す
map sK <c-w>t<c-w>K
map <Space> <C-w>w
nmap s<left> <C-w><
nmap s<right> <C-w>>
nmap s<up> <C-w>+
nmap s<down> <C-w>-
"カーソル下のファイルを開く
"縦割り
nmap ss :split<CR>
nmap sv :vsplit<CR>
nmap so <C-w>o

" switch horizontal scroll
nnoremap zH zh
nnoremap zh zH
nnoremap zL zl
nnoremap zl zL
"新規タブ
nmap sF <c-w>gf
"Moving text
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

"vim-airlineタブの移動
nnoremap :bp :bprevious<CR>
nnoremap :bn :bnext<CR>
"tabが一つだけだったら新しいタブを開く
nnoremap te :tabedit<CR>
nnoremap gt :call TabnewOrGoNext()<CR>
nnoremap gT :call TabnewOrGoPrev()<CR>

nnoremap <leader>c :tabc<CR>
"set current directory to current file
nnoremap <Leader>ll  :lcd %:h<CR>
nnoremap <Leader>lr  :call SetCurrentDirToGitRoot()<CR>

nnoremap <s-h>  :bnext<CR>
nnoremap <s-l>  :bprev<CR>



"imap"
inoremap jk <Esc>:w<CR>
tnoremap jk <C-\><C-n>
inoremap <silent> <C-d> <BS>
inoremap <silent> <C-c> <Del>
inoremap <c-l> <Right>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-e> <Esc>A
inoremap <silent> <C-a> <Esc>I
inoremap <silent> <C-f> <Esc>ea
inoremap <silent> <C-s> <Esc>bi
inoremap <silent> <C-g>h <c-u>
inoremap <silent> <C-g>l <Esc><Right>d$a
inoremap <silent> <C-g>i <Esc>ciw

"terminal mode
:tnoremap jk <C-\><C-n>
command! -nargs=* Ut split | wincmd j | resize 20 | terminal <args>
command! -nargs=* T rightbelow vert terminal <args>
" nmap T :rightbelow vert term<CR>

"######カレントウィンドウを新規タブで開きなおす
if v:version >=700
  nnoremap :tt :call OpenNewTab()<CR>
  function! OpenNewTab()
    let f = expand("%:p")
    execute ":q"
    execute ":tabnew ".f
  endfunction
endif



