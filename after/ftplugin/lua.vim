" Disable inserting comment leader after hitting o or O or <Enter>
set formatoptions-=o
set formatoptions-=r

nnoremap <buffer><silent> <F9> :luafile %<CR>

nnoremap <buffer><silent> <space>f <cmd>silent !stylua %<CR>
