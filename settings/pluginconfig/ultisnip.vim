"#######UltiSnipsのスニペットファイル置き場の定義
" let g:UltiSnipsSnippetsDir=expand("$HOME/dotfiles/.vim/UltiSnips")

" 現在のVimのconfigファイルのパスを取得
let config_file_path = $MYVIMRC
let config_dir_path = fnamemodify(config_file_path, ':h')
let g:UltiSnipsSnippetsDir = config_dir_path . '/UltiSnips'

"########UltiSnipsの起動とリスト表示
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-z>"
let g:UltiSnipsEditSplit="vertical"
