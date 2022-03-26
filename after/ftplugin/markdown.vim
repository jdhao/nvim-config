set concealcursor=c
set synmaxcol=3000  " For long Chinese paragraphs

set wrap

" Fix minor issue with footnote, see https://github.com/vim-pandoc/vim-markdownfootnotes/issues/22
if exists(':FootnoteNumber')
  nnoremap <buffer><silent> ^^ :<C-U>call markdownfootnotes#VimFootnotes('i')<CR>
  inoremap <buffer><silent> ^^ <C-O>:<C-U>call markdownfootnotes#VimFootnotes('i')<CR>
  imap <buffer> <silent> @@ <Plug>ReturnFromFootnote
  nmap <buffer> <silent> @@ <Plug>ReturnFromFootnote
endif

" Text objects for Markdown code blocks.
xnoremap <buffer><silent> ic :<C-U>call text_obj#MdCodeBlock('i')<CR>
xnoremap <buffer><silent> ac :<C-U>call text_obj#MdCodeBlock('a')<CR>
onoremap <buffer><silent> ic :<C-U>call text_obj#MdCodeBlock('i')<CR>
onoremap <buffer><silent> ac :<C-U>call text_obj#MdCodeBlock('a')<CR>

" Use + to turn several lines to an unordered list.
" Ref: https://vi.stackexchange.com/q/5495/15292 and https://stackoverflow.com/q/42438795/6064933.
nnoremap <buffer><silent> + :set operatorfunc=AddListSymbol<CR>g@
xnoremap <buffer><silent> + :<C-U> call AddListSymbol(visualmode(), 1)<CR>

function! AddListSymbol(type, ...) abort
  if a:0
    let line_start = line("'<")
    let line_end = line("'>")
  else
    let line_start = line("'[")
    let line_end = line("']")
  endif

  " add list symbol to each line
  for line in range(line_start, line_end)
    let text = getline(line)

    let l:end = matchend(text, '^\s*')
    if l:end == 0
      let new_text = '+ ' . text
    else
      let new_text = text[0 : l:end-1] . ' + ' . text[l:end :]
    endif

    call setline(line, new_text)
  endfor
endfunction

" Add hard line breaks for Markdown
nnoremap <buffer><silent> \ :set operatorfunc=AddLineBreak<CR>g@
xnoremap <buffer><silent> \ :<C-U> call AddLineBreak(visualmode(), 1)<CR>

function! AddLineBreak(type, ...) abort
  if a:0
    let line_start = line("'<")
    let line_end = line("'>")
  else
    let line_start = line("'[")
    let line_end = line("']")
  endif

  for line in range(line_start, line_end)
    let text = getline(line)
    " add backslash to each line
    let new_text = text . "\\"

    call setline(line, new_text)
  endfor
endfunction
