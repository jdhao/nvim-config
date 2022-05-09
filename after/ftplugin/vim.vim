" Disable inserting comment leader after hitting o or O or <Enter>
set formatoptions-=o
set formatoptions-=r

" Set the folding related options for vim script. Setting folding option in
" modeline is annoying in that the modeline get executed each time the window
" focus is lost (see
" https://github.com/tmux-plugins/vim-tmux-focus-events/issues/14)
set foldmethod=expr foldexpr=utils#VimFolds(v:lnum) foldtext=utils#MyFoldText()

" Use :help command for keyword when pressing `K` in vim file,
" see `:h K` and https://stackoverflow.com/q/15867323/6064933
set keywordprg=:help

set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

nnoremap <silent> <F9> :source %<CR>
