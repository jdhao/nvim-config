" This is my personal Nvim configuration supporting Mac, Linux and Windows, with various plugins configured.
" This configuration evolves as I learn more about Nvim and become more proficient in using Nvim.
" Since it is very long (more than 1000 lines!), you should read it carefully and take only the settings that suit you.
" I would not recommend cloning this repo and replace your own config. Good configurations are personal,
" built over time with a lot of polish.
"
" Author: Jie-dong Hao
" Email: jdhao@hotmail.com
" Blog: https://jdhao.github.io/

" check if we have the lastest stable version of nvim
let s:expect_ver = printf('nvim-%s', '0.7.2')
let s:actual_ver = matchstr(execute('version'), 'NVIM v\zs[^\n]*')

if !has(s:expect_ver)
  echohl Error | echomsg printf("%s required, but got nvim %s!", s:expect_ver, s:actual_ver) | echohl None
  finish
endif

let s:core_conf_files = [
      \ 'globals.vim',
      \ 'options.vim',
      \ 'autocommands.vim',
      \ 'mappings.vim',
      \ 'plugins.vim',
      \ 'themes.vim'
      \ ]

for s:fname in s:core_conf_files
  execute printf('source %s/core/%s', stdpath('config'), s:fname)
endfor
