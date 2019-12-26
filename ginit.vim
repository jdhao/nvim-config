" To check if neovim-qt is running, use `exists('g:GuiLoaded')`,
" see https://github.com/equalsraf/neovim-qt/issues/219
if exists('g:GuiLoaded')
    " call GuiWindowMaximized(1)
    GuiTabline 0
    GuiPopupmenu 0
    GuiLinespace 2
    GuiFont! Hack:h10:l
    " GuiFont! Microsoft\ YaHei\ Mono:h10:l

    " Use shift+insert for paste inside neovim-qt,
    " see https://github.com/equalsraf/neovim-qt/issues/327#issuecomment-325660764
    inoremap <silent> <S-Insert>  <C-R>+
    cnoremap <silent> <S-Insert> <C-R>+

    " For Windows, Ctrl-6 does not work. So we use this mapping instead.
    nnoremap <silent> <C-6> <C-^>
endif

if exists('g:fvim_loaded')
    set termguicolors
    colorscheme gruvbox8_hard
    set guifont=Hack:h12

    inoremap <silent> <S-Insert>  <C-R>+
    cnoremap <silent> <S-Insert> <C-R>+
    nnoremap <silent> <C-6> <C-^>

    " Cursor tweaks
    FVimCursorSmoothMove v:false
    FVimCursorSmoothBlink v:true

    " Background composition, can be 'none', 'blur' or 'acrylic'
    FVimBackgroundComposition 'blur'
    FVimBackgroundOpacity 0.85
    FVimBackgroundAltOpacity 0.85

    " Title bar tweaks (themed with colorscheme)
    FVimCustomTitleBar v:true

    " Debug UI overlay
    FVimDrawFPS v:false
    " Font debugging -- draw bounds around each glyph
    FVimFontDrawBounds v:false

    " Font tweaks
    FVimFontAntialias v:true
    FVimFontAutohint v:true
    FVimFontHintLevel 'full'
    FVimFontSubpixel v:true
    FVimFontLcdRender v:false
    " can be 'default', '14.0', '-1.0' etc.
    FVimFontLineHeight '+2.0'

    " Try to snap the fonts to the pixels, reduces blur
    " in some situations (e.g. 100% DPI).
    FVimFontAutoSnap v:false

    " Font weight tuning, possible valuaes are 100..900
    FVimFontNormalWeight 400
    FVimFontBoldWeight 700

    FVimUIPopupMenu v:false
endif
