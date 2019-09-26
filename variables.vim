"{ Global Variable
"{{ Builtin variables
" Path to Python 3 interpreter (must be an absolute path), make startup
" faster. See https://neovim.io/doc/user/provider.html. Change this variable
" in accordance with your system.
if executable('python')
    " The output of `system()` function contains a newline character which
    " should be removed, see https://vi.stackexchange.com/a/2868/15292
    if has('win32')
        let g:python3_host_prog=substitute(system('where python'), '.exe\n\+$', '', 'g')
    elseif has('unix')
        let g:python3_host_prog=substitute(system('which python'), '\n\+$', '', 'g')
    endif
else
    echoerr 'Python executable not found! You must install Python and set its PATH!'
endif

" Custom mapping <leader> (see `:h mapleader` for more info)
let mapleader = ','
"}}

"{{ Disable loading certain plugins
" Do not load netrw by default since I do not use it, see
" https://github.com/bling/dotvim/issues/4
let g:loaded_netrwPlugin = 1

" Do not load tohtml.vim
let g:loaded_2html_plugin = 1

" Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
" related to checking files inside compressed files)
let g:loaded_zipPlugin = 1
let loaded_gzip = 1
let g:loaded_tarPlugin = 1

" Do not use builtin matchit.vim and matchparen.vim
let loaded_matchit = 1
let g:loaded_matchparen = 1
"}}
"}
