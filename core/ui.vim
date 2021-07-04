"{ UI-related settings
"{{ General settings about colors
" Enable true colors support. Do not set this option if your terminal does not
" support true colors! For a comprehensive list of terminals supporting true
" colors, see https://github.com/termstandard/colors and https://gist.github.com/XVilka/8346728.
set termguicolors
"}}

"{{ Colorscheme settings
let s:my_theme_dict = {}

function! s:my_theme_dict.gruvbox8() dict abort
  " Italic options should be put before colorscheme setting,
  " see https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
  let g:gruvbox_italics=1
  let g:gruvbox_italicize_strings=1
  let g:gruvbox_filetype_hi_groups = 1
  let g:gruvbox_plugin_hi_groups = 1
  colorscheme gruvbox8_hard
endfunction

function! s:my_theme_dict.deus() dict abort
  colorscheme deus
endfunction

function! s:my_theme_dict.solarized8() dict abort
  let g:solarized_term_italics=1
  let g:solarized_visibility='high'
  colorscheme solarized8_high
endfunction

function! s:my_theme_dict.onedark() dict abort
  let g:onedark_terminal_italics = 1
  colorscheme onedark
endfunction

function! s:my_theme_dict.neodark() dict abort
  colorscheme neodark
endfunction

function! s:my_theme_dict.edge() dict abort
  let g:edge_enable_italic = 1
  let g:edge_better_performance = 1
  colorscheme edge
endfunction

function! s:my_theme_dict.sonokai() dict abort
  let g:sonokai_enable_italic = 1
  let g:sonokai_better_performance = 1
  colorscheme sonokai
endfunction

function! s:my_theme_dict.gruvbox_material() dict abort
  let g:gruvbox_material_enable_italic = 1
  let g:gruvbox_material_better_performance = 1
  colorscheme gruvbox-material
endfunction

function! s:my_theme_dict.nord() dict abort
  colorscheme nord
endfunction

let s:candidate_theme = ['gruvbox8', 'deus', 'solarized8', 'onedark', 'neodark',
      \ 'edge', 'sonokai', 'gruvbox_material', 'nord']
let s:idx = utils#RandInt(0, len(s:candidate_theme)-1)
let s:theme = s:candidate_theme[s:idx]

let s:colorscheme_func = printf('s:my_theme_dict.%s()', s:theme)
if has_key(s:my_theme_dict, s:theme)
  execute 'call ' . s:colorscheme_func
else
  echohl WarningMsg
  echomsg 'Invalid colorscheme function: ' s:colorscheme_func
  echohl None
endif
"}}
"}
