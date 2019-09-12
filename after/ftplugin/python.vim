" Automatically save current file and execute it when pressing the <F9> key
" it is useful for small script
nnoremap <buffer> <F9> :execute 'w !python' shellescape(@%, 1)<CR>
