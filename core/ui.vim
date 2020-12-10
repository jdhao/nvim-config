"{ UI-related settings
"{{ General settings about colors
" Enable true colors support. Do not set this option if your terminal does not
" support true colors! For a comprehensive list of terminals supporting true
" colors, see https://github.com/termstandard/colors and
" https://gist.github.com/XVilka/8346728.
if match($TERM, '^xterm.*') != -1 || exists('g:started_by_firenvim')
  set termguicolors
endif
"}}

"{{ Colorscheme settings
let s:my_theme_dict = {}

function! s:my_theme_dict.gruvbox8() dict abort
  " We should check if theme exists before using it, otherwise you will get
  " error message when starting Nvim
  if !utils#HasColorscheme('gruvbox8') | return | endif

  " Italic options should be put before colorscheme setting,
  " see https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
  let g:gruvbox_italics=1
  let g:gruvbox_italicize_strings=1
  let g:gruvbox_filetype_hi_groups = 0
  let g:gruvbox_plugin_hi_groups = 0
  colorscheme gruvbox8_hard
endfunction

function! s:my_theme_dict.srcery() dict abort
  if !utils#HasColorscheme('srcery') | return | endif

  colorscheme srcery
endfunction

function! s:my_theme_dict.deus() dict abort
  if !utils#HasColorscheme('deus') | return | endif

  colorscheme deus
endfunction

function! s:my_theme_dict.solarized8() dict abort
  if !utils#HasColorscheme('solarized8') | return | endif

  let g:solarized_term_italics=1
  let g:solarized_visibility='high'
  colorscheme solarized8_high
endfunction

function! s:my_theme_dict.onedark() dict abort
  if !utils#HasColorscheme('onedark') | return | endif

  let g:onedark_terminal_italics = 1
  colorscheme onedark
endfunction

function! s:my_theme_dict.neodark() dict abort
  if !utils#HasColorscheme('neodark') | return | endif

  colorscheme neodark
endfunction

function! s:my_theme_dict.toast() dict abort
  if !utils#HasColorscheme('toast') | return | endif

  colorscheme toast
endfunction

function! s:my_theme_dict.humanoid() dict abort
  if !utils#HasColorscheme('humanoid') | return | endif

  colorscheme humanoid
endfunction

let s:candidate_theme = ['gruvbox8', 'srcery', 'deus', 'solarized8',
      \ 'onedark',  'neodark', 'toast', 'humanoid']
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
