set commentstring=//\ %s

set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" Disable inserting comment leader after hitting o or O or <Enter>
set formatoptions-=o
set formatoptions-=r

nnoremap <silent> <buffer> <F9> :call <SID>compile_run_cpp()<CR>

function! s:compile_run_cpp() abort
  let src_path = expand('%:p:~')
  let src_noext = expand('%:p:~:r')
  " The building flags
  let _flag = '-Wall -Wextra -std=c11 -O2'

  if executable('clang')
    let prog = 'clang'
  elseif executable('gcc')
    let prog = 'gcc'
  else
    echoerr 'No C compiler found on the system!'
  endif
  call s:create_term_buf('h', 20)
  execute printf('term %s %s %s -o %s && %s', prog, _flag, src_path, src_noext, src_noext)
  startinsert
endfunction

function s:create_term_buf(_type, size) abort
  set splitbelow
  set splitright
  if a:_type ==# 'v'
    vnew
  else
    new
  endif
  execute 'resize ' . a:size
endfunction

" For delimitMate
let b:delimitMate_matchpairs = "(:),[:],{:}"
