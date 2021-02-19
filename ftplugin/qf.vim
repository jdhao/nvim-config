" Set quickfix window height, see also https://github.com/lervag/vimtex/issues/1127
function! AdjustWindowHeight(minheight, maxheight)
  execute max([a:minheight, min([line('$'), a:maxheight])]) . 'wincmd _'
endfunction

call AdjustWindowHeight(5, 15)
