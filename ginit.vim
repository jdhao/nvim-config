" call GuiWindowMaximized(1)
GuiPopupmenu 0
GuiTabline 0
GuiLinespace 1
GuiFont! Hack:h10:l

" to check if gui is running, use `exists('g:GuiLoaded')`,
" see https://github.com/equalsraf/neovim-qt/issues/219
if exists('g:GuiLoaded')
    " use shift+insert for paste in neovim-qt
    " see https://github.com/equalsraf/neovim-qt/issues/327#issuecomment-325660764
    imap <silent>  <S-Insert>  <C-R>+
    cmap <silent> <S-Insert> <C-R>+

    " For Windows, Ctrl-6 does not work. So we use this mapping instead.
    nmap <C-6> <C-^>
endif
