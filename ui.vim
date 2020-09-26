"{ UI-related settings
"{{ General settings about colors
" Enable true colors support. Do not set this option if your terminal does not
" support true colors! For a comprehensive list of terminals supporting true
" colors, see https://github.com/termstandard/colors and
" https://gist.github.com/XVilka/8346728.
if $TERM ==# 'xterm-256color' || exists('g:started_by_firenvim')
  set termguicolors
endif
" Use dark background
set background=dark
"}}

"{{ Colorscheme settings
""""""""""""""""""""""""""""gruvbox settings"""""""""""""""""""""""""""
" We should check if theme exists before using it, otherwise you will get
" error message when starting Nvim
if utils#HasColorscheme('gruvbox8')
  " Italic options should be put before colorscheme setting,
  " see https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
  let g:gruvbox_italics=1
  let g:gruvbox_italicize_strings=1
  let g:gruvbox_filetype_hi_groups = 0
  let g:gruvbox_plugin_hi_groups = 0
  colorscheme gruvbox8_hard
else
  colorscheme desert
endif

""""""""""""""""""""""""""" deus settings"""""""""""""""""""""""""""""""""
" colorscheme deus

""""""""""""""""""""""""""" solarized8 settings"""""""""""""""""""""""""
" Solarized colorscheme without bullshit
" let g:solarized_term_italics=1
" let g:solarized_visibility="high"
" colorscheme solarized8_high

""""""""""""""""""""""""""" vim-one settings"""""""""""""""""""""""""""""
" let g:one_allow_italics = 1
" colorscheme one

"""""""""""""""""""""""""""material.vim settings""""""""""""""""""""""""""
" let g:material_terminal_italics = 1
" " theme_style can be 'default', 'dark' or 'palenight'
" let g:material_theme_style = 'dark'
" colorscheme material

""""""""""""""""""""""""""" badwolf settings """""""""""""""""""""""""""""
" let g:badwolf_darkgutter = 0
" " Make the tab line lighter than the background.
" let g:badwolf_tabline = 2
" colorscheme badwolf
"}}
"}
