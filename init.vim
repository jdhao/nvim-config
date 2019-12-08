"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"        _   _       _                  _____             __ _               "
"       | \ | |     (_)                / ____|           / _(_)              "
"       |  \| |_   ___ _ __ ___       | |     ___  _ __ | |_ _  __ _         "
"       | . ` \ \ / / | '_ ` _ \      | |    / _ \| '_ \|  _| |/ _` |        "
"       | |\  |\ V /| | | | | | |     | |___| (_) | | | | | | | (_| |        "
"       |_| \_| \_/ |_|_| |_| |_|      \_____\___/|_| |_|_| |_|\__, |        "
"                                                               __/ |        "
"                                                              |___/         "
"                                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The above ASCII art is generated using service provided in this webpage:
" http://tinyurl.com/y6szckgd.

"{ Header and Licence
"{{ header info
" Description: This is my Neovim configuration which supports Mac, Linux and
" Windows, with various plugins configured. This configuration evolves as I
" learn more about Nvim and becomes more proficient in using Nvim. Since it is
" very long (more than 1000 lines!), you should read it carefully and
" take only the settings and options which suits you. I would not recommend
" downloading this file and replace your own init.vim. Good configurations are
" built over time and take your time to polish.
" Author: Jie-dong Hao
" Email: jdhao@hotmail.com
"}}

"{{ License: MIT License
"
" Copyright (c) 2018 Jie-dong Hao
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to
" deal in the Software without restriction, including without limitation the
" rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
" sell copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
" FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
" IN THE SOFTWARE.
"}}
"}

"{ Main configurations
" If you are using Neovim on Linux system and want to set it up system wide
" for users, set g:nvim_system_wide to 1. If you only want to use it for
" personal need, set this variable to 0.
let g:nvim_system_wide=0

" Do not set this varialbe if the system is not *nix
if g:nvim_system_wide
    if !has('unix')
        let g:nvim_system_wide = 0
    endif
endif

let g:nvim_config_root = expand('<sfile>:p:h')

let g:config_file_list = ['variables.vim',
    \ 'options.vim',
    \ 'autocommands.vim',
    \ 'mappings.vim',
    \ 'plugins.vim',
    \ 'ui.vim'
    \ ]

for s:fname in g:config_file_list
    execute 'source ' . g:nvim_config_root . '/' . s:fname
endfor
"}

"{ A list of resources which inspire me
" This list is non-exhaustive as I can not remember the source of many
" settings.

" - http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" - https://github.com/tamlok/tvim/blob/master/.vimrc
" - https://nvie.com/posts/how-i-boosted-my-vim/
" - https://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/
" - https://sanctum.geek.nz/arabesque/vim-anti-patterns/
" - https://github.com/gkapfham/dotfiles/blob/master/.vimrc
"}
