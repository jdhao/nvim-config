""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" https://www.kammerl.de/ascii/AsciiSignature.php.

"{ Header info
" Description: This is my personal Nvim configuration supporting Mac, Linux
" and Windows, with various plugins configured. This configuration evolves as
" I learn more about Nvim and becomes more proficient in using Nvim. Since it
" is very long (more than 1000 lines!), you should read it carefully and take
" only the settings and options that suits you. I would not recommend cloning
" this repo and replace your own config. Good configurations are personal,
" built over time with a lot of polish.
" Author: Jie-dong Hao
" Email: jdhao@hotmail.com
"}

"{ Main configurations
let g:config_file_list = ['globals.vim',
  \ 'options.vim',
  \ 'autocommands.vim',
  \ 'mappings.vim',
  \ 'plugins.vim',
  \ 'ui.vim'
  \ ]

let g:nvim_config_root = expand('<sfile>:p:h')
for s:fname in g:config_file_list
  execute printf('source %s/core/%s', g:nvim_config_root, s:fname)
endfor
"}
