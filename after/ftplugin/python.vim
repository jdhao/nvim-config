if exists(':AsyncRun')
  nnoremap <buffer><silent> <F9> :<C-U>AsyncRun python -u "%"<CR>
endif

" Do not wrap Python source code.
set nowrap
set sidescroll=5
set sidescrolloff=2
set colorcolumn=100

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

nnoremap <buffer><silent> <space>f <cmd>silent !black %<CR>
