set concealcursor=c
set synmaxcol=3000  " For long Chinese paragraphs

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
