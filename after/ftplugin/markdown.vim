set concealcursor=c
set synmaxcol=3000  " For long Chinese paragraphs

if exists(":FootnoteNumber")
    nnoremap <buffer> <Plug>AddVimFootnote :<c-u>call markdownfootnotes#VimFootnotes('i')<CR>
    inoremap <buffer> <Plug>AddVimFootnote <C-O>:<c-u>call markdownfootnotes#VimFootnotes('i')<CR>
endif
