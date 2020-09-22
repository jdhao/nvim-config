" Fix key mapping issues for GUI
inoremap <silent> <S-Insert>  <C-R>+
cnoremap <S-Insert> <C-R>+
nnoremap <silent> <C-6> <C-^>

" Highlight groups for cursor color
augroup cusor_color
    autocmd!
    autocmd ColorScheme * highlight Cursor cterm=bold gui=bold guibg=cyan guifg=black
    autocmd ColorScheme * highlight Cursor2 guifg=red guibg=red
augroup END

" Set up cursor color and shape in various mode, ref:
" https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-color-in-the-terminal
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20

" To check if neovim-qt is running, use `exists('g:GuiLoaded')`,
" see https://github.com/equalsraf/neovim-qt/issues/219
if exists('g:GuiLoaded')
    " call GuiWindowMaximized(1)
    GuiTabline 0
    GuiPopupmenu 0
    GuiLinespace 2
    GuiFont! Hack:h10:l
endif

if exists('g:fvim_loaded')
    set termguicolors
    colorscheme gruvbox8_hard
    set guifont=Hack:h13
    " Cursor tweaks
    FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true

    " Background composition, can be 'none', 'blur' or 'acrylic'
    FVimBackgroundComposition 'none'
    FVimBackgroundOpacity 0.85
    FVimBackgroundAltOpacity 0.85

    " Title bar tweaks (themed with colorscheme)
    FVimCustomTitleBar v:false

    " Debug UI overlay
    FVimDrawFPS v:false
    " Font debugging -- draw bounds around each glyph
    FVimFontDrawBounds v:false

    " Font tweaks
    FVimFontAntialias v:true
    FVimFontAutohint v:true
    FVimFontHintLevel 'full'
    FVimFontSubpixel v:true
    FVimFontLigature v:true
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
