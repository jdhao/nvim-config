" Capture output from a command to register @m, to paste, press "mp
command! -nargs=1 -complete=command Redir call utils#CaptureCommandOutput(<q-args>)

command! -bar -bang -nargs=+ -complete=file Edit call utils#MultiEdit([<f-args>])
call utils#Cabbrev('edit', 'Edit')

call utils#Cabbrev('man', 'Man')

" show current date and time in human readable format
command! -nargs=? Datetime echo utils#iso_time(<q-args>)

" Convert Markdown file to PDF
command! ToPDF call s:md_to_pdf()

function! s:md_to_pdf() abort
  " check if pandoc is installed
  if executable('pandoc') != 1
    echoerr "pandoc not found"
    return
  endif

  let l:md_path = expand("%:p")
  let l:pdf_path = fnamemodify(l:md_path, ":r") .. ".pdf"

  let l:header_path = stdpath('config') . '/resources/head.tex'

  let l:cmd = "pandoc --pdf-engine=xelatex --highlight-style=zenburn --table-of-content " .
        \ "--include-in-header=" . l:header_path . " -V fontsize=10pt -V colorlinks -V toccolor=NavyBlue " .
        \ "-V linkcolor=red -V urlcolor=teal -V filecolor=magenta -s " .
        \ l:md_path . " -o " . l:pdf_path

  if g:is_mac
    let l:cmd = l:cmd . '&& open ' . l:pdf_path
  endif

  if g:is_win
    let l:cmd = l:cmd . '&& start ' . l:pdf_path
  endif

  " echomsg l:cmd

  let l:id = jobstart(l:cmd)

  if l:id == 0 || l:id == -1
    echoerr "Error running command"
  endif
endfunction

" json format
command! -range JSONFormat <line1>,<line2>!python -m json.tool
