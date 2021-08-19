"{ UI-related settings
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
  colorscheme onedark
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

function! s:my_theme_dict.doom_one() dict abort
  let g:doom_one_terminal_color = v:true
  let g:doom_one_italic_comments = v:true
  let g:doom_one_cursor_coloring = v:true
  colorscheme doom-one
endfunction

function! s:my_theme_dict.everforest() dict abort
  let g:everforest_enable_italic = 1
  let g:everforest_better_performance = 1
  colorscheme everforest
endfunction

let s:candidate_theme = ['gruvbox8', 'deus', 'solarized8', 'onedark',
      \ 'edge', 'sonokai', 'gruvbox_material', 'nord', 'doom_one', 'everforest']
let s:idx = utils#RandInt(0, len(s:candidate_theme)-1)
let s:theme = s:candidate_theme[s:idx]

let s:colorscheme_func = printf('s:my_theme_dict.%s()', s:theme)
if has_key(s:my_theme_dict, s:theme)
  execute 'call ' . s:colorscheme_func
else
  let s:msg = "Invalid colorscheme function: " . s:colorscheme_func
  call v:lua.vim.notify(s:msg, 'error', {'title': 'nvim-config', 'timeout': 2500})
endif
"}}
"}
