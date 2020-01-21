if exists(':AsyncRun')
    nnoremap <silent> <F9> :AsyncRun python -u "%"<CR>
endif

" Do not wrap Python source code.
set nowrap
set sidescroll=5
set sidescrolloff=2
