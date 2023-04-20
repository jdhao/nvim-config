" Fix key mapping issues for GUI
inoremap <silent> <S-Insert>  <C-R>+
cnoremap <S-Insert> <C-R>+
nnoremap <silent> <C-6> <C-^>

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
 inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
" nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
" nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
" nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nmap <leader>rn <Plug>(coc-rename)
lcd C:\UnlimitedCodeWorks\

lua require'nvim-tree'.setup {}
set autoindent tabstop=4 shiftwidth=4
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          config for nvim-qt                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To check if neovim-qt is running, use `exists('g:GuiLoaded')`,
" see https://github.com/equalsraf/neovim-qt/issues/219
if exists('g:GuiLoaded')
  " call GuiWindowMaximized(1)
  GuiTabline 0
  GuiPopupmenu 0
  GuiLinespace 2
  GuiFont! Hack\ NF:h16
  colorscheme desert
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           config for fvim                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('g:fvim_loaded')
  set termguicolors
  colorscheme desert
  set guifont=Hack\ NF:h16
  " Cursor tweaks
  FVimCursorSmoothMove v:true
  FVimCursorSmoothBlink v:true

  " Background composition, can be 'none', 'blur' or 'acrylic'
  FVimBackgroundComposition 'acrylic'   " 'none', 'transparent', 'blur' or 'acrylic'
  FVimBackgroundOpacity 0.85            " value between 0 and 1, default bg opacity.
  FVimBackgroundAltOpacity 0.85         " value between 0 and 1, non-default bg opacity.
  FVimBackgroundImage 'C:/foobar.png'   " background image
  FVimBackgroundImageVAlign 'center'    " vertial position, 'top', 'center' or 'bottom'
  FVimBackgroundImageHAlign 'center'    " horizontal position, 'left', 'center' or 'right'
  FVimBackgroundImageStretch 'fill'     " 'none', 'fill', 'uniform', 'uniformfill'
  FVimBackgroundImageOpacity 0.85  

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
  FVimFontLigature v:true
  " can be 'default', '14.0', '-1.0' etc.
  FVimFontLineHeight '+1'

  " Try to snap the fonts to the pixels, reduces blur
  " in some situations (e.g. 100% DPI).
  FVimFontAutoSnap v:true

  " Font weight tuning, possible values are 100..900
  FVimFontNormalWeight 100
  FVimFontBoldWeight 700

  FVimUIPopupMenu v:false
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             config for neovide                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("g:neovide")
  set guifont=Hack\ NF:h10
  let g:neovide_transparency = 1.0
  let g:neovide_cursor_animation_length = 0.1
  let g:neovide_cursor_trail_size=0.3
  let g:neovide_cursor_vfx_mode = ""
  let g:neovide_cursor_vfx_particle_density=10.0
  let g:neovide_cursor_vfx_opacity=150.0
endif
