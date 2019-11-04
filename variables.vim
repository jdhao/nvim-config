"{ Global Variable
"{{ Builtin variables
" Path to Python 3 interpreter (must be an absolute path), make startup
" faster. See https://neovim.io/doc/user/provider.html.
if executable('python')
   if has('win32')
        let g:python3_host_prog=substitute(exepath('python'), '.exe$', '', 'g')
    elseif has('unix')
        let g:python3_host_prog=exepath('python')
    endif
else
    echoerr 'Python executable not found! You must install Python and set its PATH!'
endif

" Disable Python2 support
let g:loaded_python_provider=0

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
"}}
