if exists('g:loaded_gpt_query')
  finish
endif
let g:loaded_gpt_query = 1

" 使用するモデル名を変数で保持（好きに上書きしてOK）
if !exists('g:gpt_model')
  let g:gpt_model = 'gpt-5-nano-2025-08-07'
endif

" ========= 内部用ヘルパ =========

" 現在のバッファ全体を 1つの文字列として取得
function! s:GetBufferText() abort
  return join(getline(1, '$'), "\n")
endfunction

" range 付き: 選択範囲などを 1つの文字列として取得
function! s:GetRangeText(first, last) abort
  return join(getline(a:first, a:last), "\n")
endfunction

" テンプレートから質問文を選択
function! s:SelectTemplate() abort
  " 好きなテンプレを追加してOK
  let l:templates = [
        \ 'この内容の要約を日本語のマークダウン形式で出力してください。',
        \ 'この内容を日本語で翻訳してください。',
        \ 'このコードのバグを見つけてください。',
        \ 'このコードの改善点を具体的に教えてください。',
        \ 'このコードが何をしているか初心者向けに説明してください。',
        \ 'このコードにコメントを付けてください。',
        \ 'このコードのテストケースの例を提案してください。',
        \ ]

  let l:menu = ['テンプレートを選択してください:']
  let l:menu += l:templates

  let l:idx = inputlist(l:menu)
  if l:idx <= 0 || l:idx > len(l:templates)
    echo 'キャンセルしました'
    return ''
  endif

  return l:templates[l:idx - 1]
endfunction

" 実際に OpenAI API を叩いて結果を新しいバッファに表示
function! s:SendToGPT(question, text) abort
  if empty(a:question)
    echo '質問文が空です'
    return
  endif

  let l:api_key = getenv('OPENAI_API_KEY')
  if empty(l:api_key)
    echoerr 'OPENAI_API_KEY が設定されていません'
    return
  endif

  " メッセージを組み立て（Vim の json_encode で JSON にする）
  let l:messages = [
        \ {'role': 'system', 'content': 'You are a helpful assistant.'},
        \ {'role': 'user',   'content': a:question . "\n\n----- buffer -----\n\n" . a:text},
        \ ]

  let l:body = {
        \ 'model': g:gpt_model,
        \ 'messages': l:messages,
        \ }

  let l:json = json_encode(l:body)

  " curl コマンドを組み立て（標準入力で JSON を渡す）
  let l:cmd = 'curl -sS https://api.openai.com/v1/chat/completions ' .
        \ '-H "Content-Type: application/json" ' .
        \ '-H "Authorization: Bearer ' . l:api_key . '" ' .
        \ '--data-binary @-'

  let l:resp = system(l:cmd, l:json)

  if v:shell_error != 0
    echoerr 'curl エラー: ' . l:resp
    return
  endif

  " レスポンスJSONをパース
  try
    let l:data = json_decode(l:resp)
  catch
    echoerr 'JSON パースエラー: ' . v:exception
    return
  endtry

  if has_key(l:data, 'error')
    echoerr 'API エラー: ' . l:data.error.message
    return
  endif

  if !has_key(l:data, 'choices') || empty(l:data.choices)
    echoerr 'レスポンスに choices がありません'
    return
  endif

  let l:content = l:data.choices[0].message.content

  " 結果を vsplit した新しい nofile バッファに表示
  vert new
  setlocal buftype=nofile bufhidden=wipe noswapfile
  file [GPT-Response]
  call setline(1, split(l:content, "\n"))
  normal! gg
endfunction

" ========= 公開関数 =========

" バッファ全体 + 自由入力の質問
function! GPT_BufferAskPrompt() abort
  let l:q = input('GPT 質問: ')
  if empty(l:q)
    echo 'キャンセルしました'
    return
  endif
  let l:text = s:GetBufferText()
  call s:SendToGPT(l:q, l:text)
endfunction

" バッファ全体 + テンプレ質問
function! GPT_BufferAskTemplate() abort
  let l:q = s:SelectTemplate()
  if empty(l:q)
    return
  endif
  let l:text = s:GetBufferText()
  call s:SendToGPT(l:q, l:text)
endfunction

" 選択範囲 + 自由入力の質問（Visual モード用）
function! GPT_RangeAskPrompt(first, last) range abort
  let l:q = input('GPT 質問 (選択範囲): ')
  if empty(l:q)
    echo 'キャンセルしました'
    return
  endif
  let l:text = s:GetRangeText(a:firstline, a:lastline)
  call s:SendToGPT(l:q, l:text)
endfunction

" 選択範囲 + テンプレ質問（Visual モード用）
function! GPT_RangeAskTemplate(first, last) range abort
  let l:q = s:SelectTemplate()
  if empty(l:q)
    return
  endif
  let l:text = s:GetRangeText(a:firstline, a:lastline)
  call s:SendToGPT(l:q, l:text)
endfunction

" ========= キーマッピング =========
" お好みで変更してOK

" ノーマルモード: バッファ全体
nnoremap <silent> <leader>bgq :call GPT_BufferAskPrompt()<CR>
nnoremap <silent> <leader>bgt :call GPT_BufferAskTemplate()<CR>

" ビジュアルモード: 選択範囲
xnoremap <silent> <leader>bgq :<C-u>call GPT_RangeAskPrompt('<', '>')<CR>
xnoremap <silent> <leader>bgt :<C-u>call GPT_RangeAskTemplate('<', '>')<CR>

