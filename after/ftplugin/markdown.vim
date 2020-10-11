set concealcursor=c
set synmaxcol=3000  " For long Chinese paragraphs

" Fix minor issue with footnote, see https://github.com/vim-pandoc/vim-markdownfootnotes/issues/22
if exists(':FootnoteNumber')
  nnoremap <buffer> <Plug>AddVimFootnote :<C-U>call markdownfootnotes#VimFootnotes('i')<CR>
  inoremap <buffer> <Plug>AddVimFootnote <C-O>:<C-U>call markdownfootnotes#VimFootnotes('i')<CR>
endif
