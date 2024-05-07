" Disable inserting comment leader after hitting o or O or <Enter>
set formatoptions-=o
set formatoptions-=r

nnoremap <buffer><silent> <F9> :luafile %<CR>

" For delimitMate
let b:delimitMate_matchpairs = "(:),[:],{:}"

" Use nvim-treesitter for folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
