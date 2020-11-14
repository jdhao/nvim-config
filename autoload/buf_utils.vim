function! buf_utils#GoToBuffer(count, direction) abort
  if a:count == 0
    if a:direction ==# 'forward'
      bnext
    elseif a:direction ==# 'backward'
      bprevious
    else
      echoerr 'Bad argument ' a:direction
    endif
    return
  endif
  " Check the validity of buffer number.
  if index(s:GetBufNums(), a:count) == -1
    echohl WarningMsg | echomsg 'Invalid bufnr: ' a:count | echohl None
    return
  endif

  " Do not use {count} for gB (it is less useful)
  if a:direction ==# 'forward'
    silent execute('buffer' . a:count)
  endif
endfunction

function! s:GetBufNums() abort
  return map(copy(getbufinfo({'buflisted':1})), 'v:val.bufnr')
endfunction
