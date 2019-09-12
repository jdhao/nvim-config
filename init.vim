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
" The ascii art above is generated using service provided on this webpage:
" http://tinyurl.com/y6szckgd

"{ Header and Licence
"{{ header info
" Description: This is my Nvim configuration which supports Mac, Linux and
" Windows, with various plugins configured. This configuration evolves as I
" learn more about Nvim and becomes more proficient in using Nvim. Since this
" configuration file is very long (more than 1000 lines!), you should read it
" carefully and only take the settings and options which suits you.  I would
" not recommend downloading this file and replace your own init.vim. Good
" configurations are built over time and take your time to polish.
" Author: jdhao (jdhao@hotmail.com).
" Update: 2019-09-12 19:54:07+0800
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

"{ Variable
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

"{ Builtin options and settings
" Changing fillchars for folding, so there is no garbage charactes
set fillchars=fold:\ ,vert:\|

" Paste mode toggle, it seems that Neovim's bracketed paste mode
" does not work very well for nvim-qt, so we use good-old paste mode
set pastetoggle=<F12>

" Split window below/right when creating horizontal/vertical windows
set splitbelow splitright

" Time in milliseconds to wait for a mapped sequence to complete,
" see https://goo.gl/vHvyu8 for more info
set timeoutlen=500

" For CursorHold events
set updatetime=2000

" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://goo.gl/YAHBbJ
set clipboard+=unnamedplus

" Disable creating swapfiles, see https://goo.gl/FA6m6h
set noswapfile

" General tab settings
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" Set matching pairs of characters and highlight matching brackets
set matchpairs+=<:>,「:」

" Show line number and relative line number
set number relativenumber

" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase

" File and script encoding settings for vim
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
scriptencoding utf-8

" Break line at predefined characters
set linebreak
" Character to show before the lines that have been soft-wrapped
set showbreak=↪

" List all items and start selecting matches in cmd completion
set wildmode=list:full

" Show current line where the cursor is
set cursorline
" Set a ruler at column 80, see https://goo.gl/vEkF5i
set colorcolumn=80

" Minimum lines to keep above and below cursor when scrolling
set scrolloff=3

" Use mouse to select and resize windows, etc.
if has('mouse')
    set mouse=nv  " Enable mouse in several mode
    set mousemodel=popup  " Set the behaviour of mouse
endif

" Do not show mode on command line since vim-airline can show it
set noshowmode

" Fileformats to use for new files
set fileformats=unix,dos

" The mode in which cursorline text can be concealed
set concealcursor=nc

" The way to show the result of substitution in real time for preview
set inccommand=nosplit

" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.gif,*.bmp,*.tiff
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf

" Ask for confirmation when handling unsaved or read-only files
set confirm

" Use visual bells to indicate errors, do not use errorbells
set visualbell noerrorbells

" The level we start to fold
set foldlevel=0

" The number of command and search history to keep
set history=500

" Use list mode and customized listchars
set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:+

" Auto-write the file based on some condition
set autowrite

" Show hostname, full path of file and last-mod time on the window title.
" The meaning of the format str for strftime can be found in
" http://tinyurl.com/l9nuj4a. The function to get lastmod time is drawn from
" http://tinyurl.com/yxd23vo8
set title
set titlestring=%{hostname()}\ \ %{expand('%:p')}\ \ %{strftime('%Y-%m-%d\ %H:%M',getftime(expand('%')))}

" Persistent undo even after you close a file and re-open it
set undofile

" Do not show "match xx of xx" and other messages during auto-completion
set shortmess+=c

" Completion behaviour
set completeopt+=noinsert  " Auto select the first completion entry
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt-=preview  " Disable the preview window

" Settings for popup menu
set pumheight=15  " Maximum number of items to show in popup menu
set pumblend=5  " Pesudo blend effect for popup menu

" Scan files given by `dictionary` option
set complete+=k,kspell complete-=w complete-=b complete-=u complete-=t

" Dictionary files for different systems
let g:MY_DICT = stdpath('config') . '/dict/words'
let &dictionary = &dictionary . ',' . g:MY_DICT

set spelllang=en,cjk  " Spell languages

" Align indent to next multiple value of shiftwidth. For its meaning,
" see http://tinyurl.com/y5n87a6m
set shiftround

" Virtual edit is useful for visual block edit
set virtualedit=block

" Correctly break multi-byte characters such as CJK,
" see http://tinyurl.com/y4sq6vf3
set formatoptions+=mM

" Tilde (~) is an operator, thus must be followed by motions like `e` or `w`.
set tildeop

" Do not add two space after a period when joining lines or formatting texts,
" see https://tinyurl.com/y3yy9kov
set nojoinspaces

set ambiwidth=double
"}

"{ Custom key mappings
" Save key strokes (now we do not need to press shift to enter command mode).
" Vim-sneak has also mapped `;`, so using the below mapping will break the map
" used by vim-sneak
nnoremap ; :
xnoremap ; :

" Quicker way to open command window
nnoremap q; q:

" Quicker <Esc> in insert mode
inoremap <silent> jk <Esc>

" Turn the word under cursor to upper case
inoremap <silent> <c-u> <Esc>viwUea

" Turn the current word into title case
inoremap <silent> <c-t> <Esc>b~lea

" Paste non-linewise text above or below current cursor,
" see https://stackoverflow.com/a/1346777/6064933
nnoremap <leader>p m`o<ESC>p``
nnoremap <leader>P m`O<ESC>p``

" Shortcut for faster save and quit
nnoremap <silent> <leader>w :update<CR>
" Saves the file if modified and quit
nnoremap <silent> <leader>q :x<CR>
" Quit all opened buffers
nnoremap <silent> <leader>Q :qa<CR>

" Navigation in the location and quickfix list
nnoremap [l :lprevious<CR>zv
nnoremap ]l :lnext<CR>zv
nnoremap [L :lfirst<CR>zv
nnoremap ]L :llast<CR>zv
nnoremap [q :cprevious<CR>zv
nnoremap ]q :cnext<CR>zv
nnoremap [Q :cfirst<CR>zv
nnoremap ]Q :clast<CR>zv

" Close location list or quickfix list if they are present,
" see https://goo.gl/uXncnS
nnoremap<silent> \x :windo lclose <bar> cclose<CR>

" Close a buffer and switching to another buffer, do not close the
" window, see https://goo.gl/Wd8yZJ
nnoremap <silent> \d :bprevious <bar> bdelete #<CR>

" Toggle search highlight, see https://goo.gl/3H85hh
nnoremap <silent><expr> <Leader>hl (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" Disable arrow key in vim, see https://goo.gl/s1yfh4.
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" Insert a blank line below or above current line (do not move the cursor),
" see https://stackoverflow.com/a/16136133/6064933
nnoremap <expr> oo 'm`' . v:count1 . 'o<Esc>``'
nnoremap <expr> OO 'm`' . v:count1 . 'O<Esc>``'

" nnoremap oo @='m`o<c-v><Esc>``'<cr>
" nnoremap OO @='m`O<c-v><Esc>``'<cr>

" the following two mappings work, but if you change double quote to single, it
" will not work
" nnoremap oo @="m`o\<lt>Esc>``"<cr>
" nnoremap oo @="m`o\e``"<cr>

" Insert a space after current character
nnoremap <silent> <Space><Space> a<Space><ESC>h

" Yank from current cursor position to the end of the line (make it
" consistent with the behavior of D, C)
nnoremap Y y$

" Move the cursor based on physical lines, not the actual lines.
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent> ^ g^
nnoremap <silent> 0 g0

" Do not include white space characters when using $ in visual mode,
" see https://goo.gl/PkuZox
xnoremap $ g_

" Jump to matching pairs easily in normal mode
nnoremap <Tab> %

" Go to start or end of line easier
nnoremap H ^
xnoremap H ^
nnoremap L g_
xnoremap L g_

" Resize windows using <Alt> and h,j,k,l, inspiration from
" https://goo.gl/vVQebo (bottom page).
" If you enable mouse support, shorcuts below may not be necessary.
nnoremap <silent> <M-h> <C-w><
nnoremap <silent> <M-l> <C-w>>
nnoremap <silent> <M-j> <C-W>-
nnoremap <silent> <M-k> <C-W>+

" Fast window switching, inspiration from
" https://stackoverflow.com/a/4373470/6064933
nnoremap <silent> <M-left> <C-w>h
nnoremap <silent> <M-right> <C-w>l
nnoremap <silent> <M-down> <C-w>j
nnoremap <silent> <M-up> <C-w>k

" Continuous visual shifting (does not exit Visual mode), `gv` means
" to reselect previous visual area, see https://goo.gl/m1UeiT
xnoremap < <gv
xnoremap > >gv

" When completion menu is shown, use <cr> to select an item
" and do not add an annoying newline. Otherwise, <enter> is what it is.
" For more info , see https://goo.gl/KTHtrr and https://goo.gl/MH7w3b
inoremap <expr> <cr> ((pumvisible())?("\<C-Y>"):("\<cr>"))
" Use <esc> to close auto-completion menu
inoremap <expr> <esc> ((pumvisible())?("\<C-e>"):("\<esc>"))

" Edit and reload init.vim quickly
nnoremap <silent> <leader>ev :edit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :silent update $MYVIMRC <bar> source $MYVIMRC <bar>
    \ echomsg "Nvim config successfully reloaded!"<cr>

" Reselect the text that has just been pasted
nnoremap <leader>v `[V`]

" Use sane regex expression (see `:h magic` for more info)
nnoremap / /\v

" Find and replace (like Sublime Text 3)
nnoremap <C-H> :%s/
xnoremap <C-H> :s/

" Change current working directory locally and print cwd after that,
" see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
nnoremap <silent> <leader>cd :lcd %:p:h<CR>:pwd<CR>

" Use Esc to quit builtin terminal
tnoremap <ESC>   <C-\><C-n>

" Toggle spell checking (autosave does not play well with z=, so we disable it
" when we are doing spell checking)
nnoremap <silent> <F11> :set spell! <bar> :AutoSaveToggle<cr>
inoremap <silent> <F11> <C-O>:set spell! <bar> :AutoSaveToggle<cr>

" Decrease indent level in insert mode with shift+tab
inoremap <S-Tab> <ESC><<i

" Change text without putting the text into register,
" see http://tinyurl.com/y2ap4h69
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc

" Remove trailing whitespace characters
nnoremap <silent> <leader><Space> :call utils#StripTrailingWhitespaces()<CR>

" check the syntax group of current cursor position
nnoremap <silent> <leader>st :call utils#SynGroup()<CR>
"}

"{ Auto commands
" Do not use smart case in command line mode,
" extracted from https://goo.gl/vCTYdK
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

" Set textwidth for text file types
augroup text_file_width
    autocmd!
    " Sometimes, automatic filetype detection is not right, so we need to
    " detect the filetype based on the file extensions
    autocmd BufNewFile,BufRead *.md,*.MD,*.markdown setlocal textwidth=79
augroup END

augroup term_settings
    autocmd!
    " Do not use number and relative number for terminal inside nvim
    autocmd TermOpen * setlocal norelativenumber nonumber
    " Go to insert mode by default to start typing command
    autocmd TermOpen * startinsert
augroup END

" More accurate syntax highlighting? (see `:h syn-sync`)
augroup accurate_syn_highlight
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END

" Return to last edit position when opening a file
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END

" Display a message when the current file is not in utf-8 format.
" Note that we need to use `unsilent` command here because of this issue:
" https://github.com/vim/vim/issues/4379
augroup non_utf8_file_warn
    autocmd!
    autocmd BufRead * if &fileencoding != 'utf-8'
                \ | unsilent echomsg 'File not in UTF-8 format!' | endif
augroup END

" Automatically reload the file if it is changed outside of Nvim, see
" https://unix.stackexchange.com/a/383044/221410. It seems that `checktime`
" command does not work in command line. We need to check if we are in command
" line before executing this command. See also http://tinyurl.com/y6av4sy9.
augroup auto_read
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
                \ if mode() == 'n' && getcmdwintype() == '' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg
                \ | echo "File changed on disk. Buffer reloaded!" | echohl None
augroup END
"}

"{ Plugin installation part
"{{ Vim-plug Install and related settings

" Auto-install vim-plug on different systems if it does not exist.
" For Windows, only Windows 10 with curl installed are supported (after
" Windows 10 build 17063, source: http://tinyurl.com/y23972tt).
" The following script to install vim-plug is adapted from vim-plug
" wiki: https://github.com/junegunn/vim-plug/wiki/tips#tips
if !executable('curl')
    echomsg 'You have to install curl to install vim-plug. Or install '
            \ . 'vim-plug yourself following the guide on vim-plug git repo'
else
    let g:VIM_PLUG_PATH = expand(stdpath('config') . '/autoload/plug.vim')
    if empty(glob(g:VIM_PLUG_PATH))
        echomsg 'Installing Vim-plug on your system'
        silent execute '!curl -fLo ' . g:VIM_PLUG_PATH . ' --create-dirs '
            \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

        augroup plug_init
            autocmd!
            autocmd VimEnter * PlugInstall --sync | quit |source $MYVIMRC
        augroup END
    endif
endif

" Set up directory to install the plugins based on the platform
if has('win32')
    let g:PLUGIN_HOME=expand('~/AppData/Local/nvim/plugged')
else
    let g:PLUGIN_HOME=expand('~/.local/share/nvim/plugged')
endif

"}}

"{{ Autocompletion related plugins
call plug#begin(g:PLUGIN_HOME)
" Auto-completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Python source for deoplete
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

" Vim source for deoplete
Plug 'Shougo/neco-vim', { 'for': 'vim' }

" Insert mode completion
Plug 'ervandew/supertab'
"}}

"{{ Python-related plugins
" Python completion, goto definition etc.
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Python syntax highlighting and more
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }

" Python indent (follows the PEP8 style)
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}

" Python code folding
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
"}}

"{{ Search related plugins
" Super fast movement with vim-sneak
Plug 'justinmk/vim-sneak'

" Improve vim incsearch
Plug 'haya14busa/is.vim'

" Show match number for incsearch
Plug 'osyo-manga/vim-anzu'

" Stay after pressing * and search selected text
Plug 'haya14busa/vim-asterisk'

" File search, tag search and more
if has('win32')
    Plug 'Yggdroot/LeaderF'
else
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
endif

" Only use fzf for Linux and Mac since fzf does not work well for Windows
if has('unix')
    " fuzzy file search and more
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
endif

" Another similar plugin is command-t
" Plug 'wincent/command-t'

" Another grep tool (similar to Sublime Text Ctrl+Shift+F)
" Plug 'dyng/ctrlsf.vim'

" A greping tool
" Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
"}}

"{{ UI: Color, theme etc.
" A list of colorscheme plugin you may want to try. Find what suits you.
Plug 'lifepillar/vim-gruvbox8'
Plug 'sjl/badwolf'
Plug 'ajmwagar/vim-deus'
" Plug 'sainnhe/vim-color-desert-night'
" Plug 'YorickPeterse/happy_hacking.vim'
" Plug 'lifepillar/vim-solarized8'
" Plug 'sickill/vim-monokai'
" Plug 'whatyouhide/vim-gotham'
" Plug 'rakr/vim-one'
" Plug 'kaicataldo/material.vim'

" colorful status line and theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"}}

"{{ Plugin to deal with URL
" Highlight URLs inside vim
Plug 'itchyny/vim-highlighturl'

" For Windows and Mac, we can open an URL in the browser. For Linux, it may
" not be possible since we maybe in a server which disables GUI.
if has('win32') || has('macunix')
    " open URL in browser
    Plug 'tyru/open-browser.vim'
endif
"}}

"{{ Navigation and tags plugin
" File explorer for vim
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }

" Only install these plugins if ctags are installed on the system
if executable('ctags')
    " plugin to manage your tags
    Plug 'ludovicchabant/vim-gutentags'
    " show file tags in vim window
    Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen'] }
endif
"}}

"{{ File editting plugin
" Snippet engine and snippet template
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Automatic insertion and deletion of a pair of characters
Plug 'jiangmiao/auto-pairs'

" Comment plugin
Plug 'scrooloose/nerdcommenter'

" Multiple cursor plugin like Sublime Text?
" Plug 'mg979/vim-visual-multi'

" Title character case
Plug 'christoomey/vim-titlecase'

" Autosave files on certain events
Plug '907th/vim-auto-save'

" graphcial undo history, see https://github.com/mbbill/undotree
Plug 'mbbill/undotree'

" another plugin to show undo history is: http://tinyurl.com/jlsgjy5
" Plug 'simnalamburt/vim-mundo'

" Manage your yank history
if has('win32') || has('macunix')
    Plug 'svermeulen/vim-yoink'
endif

" Show marks in sign column for quicker navigation
Plug 'kshenoy/vim-signature'

" Another good plugin to show signature
" Plug 'jeetsukumaran/vim-markology'

" Handy unix command inside Vim (Rename, Move etc.)
Plug 'tpope/vim-eunuch'

" Repeat vim motions
Plug 'tpope/vim-repeat'

" Show the content of register in preview window
" Plug 'junegunn/vim-peekaboo'

" IME toggle for Mac
if has('macunix')
    Plug 'rlue/vim-barbaric'
endif
"}}

"{{ Linting, formating
" Syntax check and make
Plug 'neomake/neomake'

" Another linting plugin
" Plug 'w0rp/ale'

" Auto format tools
" Plug 'sbdchd/neoformat'
" Plug 'Chiel92/vim-autoformat'
"}}

"{{ Git related plugins
" Show git change (change, delete, add) signs in vim sign column
Plug 'mhinz/vim-signify'
" Another similar plugin
" Plug 'airblade/vim-gitgutter'

" Git command inside vim
Plug 'tpope/vim-fugitive'

" Git commit browser
Plug 'junegunn/gv.vim', { 'on': 'GV' }
"}}

"{{ Plugins for markdown writing
" Distraction free writing
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }

" Only light on your cursor line to help you focus
Plug 'junegunn/limelight.vim', {'for': 'markdown'}

" Markdown syntax highlighting
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }

" Another markdown plugin
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Faster footnote generation
Plug 'vim-pandoc/vim-markdownfootnotes', { 'for': 'markdown' }

" Vim tabular plugin for manipulate tabular, required by markdown plugins
Plug 'godlygeek/tabular'

" Markdown JSON header highlight plugin
Plug 'elzr/vim-json', { 'for': ['json', 'markdown'] }

" Markdown previewing (only for Mac and Windows)
if has('win32') || has('macunix')
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
endif
"}}

"{{ Text object plugins
" Additional powerful text object for vim, this plugin should be studied
" carefully to use its full power
Plug 'wellle/targets.vim'

" Plugin to manipulate characer pairs quickly
Plug 'tpope/vim-surround'

" Add indent object for vim (useful for languages like Python)
Plug 'michaeljsmith/vim-indent-object'
"}}

"{{ LaTeX editting and previewing plugin
" Only use these plugin on Windows and Mac and when LaTeX is installed
if ( has('macunix') || has('win32') ) && executable('latex')
    " vimtex use autoload feature of Vim, so it is not necessary to use `for`
    " keyword of vim-plug to try to lazy-load it,
    " see http://tinyurl.com/y3ymc4qd
    Plug 'lervag/vimtex'

    " Plug 'matze/vim-tex-fold', {'for': 'tex'}
    " Plug 'Konfekt/FastFold'
endif
"}}

"{{ Tmux related plugins
" Since tmux is only available on Linux and Mac, we only enable these plugins
" for Linux and Mac
if has('unix') && executable('tmux')
    " Let vim detect tmux focus event correctly, see
    " http://tinyurl.com/y4xd2w3r and http://tinyurl.com/y4878wwm
    Plug 'tmux-plugins/vim-tmux-focus-events'

    " .tmux.conf syntax highlighting and setting check
    Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
endif
"}}

"{{ Misc plugins
" Automatically toggle line number based on several conditions
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Highlight yanked region
Plug 'machakann/vim-highlightedyank'

" Quickly run a code script
Plug 'thinca/vim-quickrun'

" Modern matchit implementation
Plug 'andymass/vim-matchup'

" Simulating smooth scroll motions with physcis
Plug 'yuttie/comfortable-motion.vim'

Plug 'tpope/vim-scriptease'
call plug#end()
"}}
"}

"{ Plugin settings
"{{ Vim-plug settings
" Use shortnames for common vim-plug command to reduce typing.
" To use these shortcut: first activate command line with `:`, then input the
" short alias, e.g., `pi`, then press <space>, the alias will be expanded
" to the full command automatically
call utils#Cabbrev('pi', 'PlugInstall')
call utils#Cabbrev('pud', 'PlugUpdate')
call utils#Cabbrev('pug', 'PlugUpgrade')
call utils#Cabbrev('ps', 'PlugStatus')
call utils#Cabbrev('pc', 'PlugClean')
"}}

"{{ Auto-completion related
"""""""""""""""""""""""""""" deoplete settings""""""""""""""""""""""""""
" Wheter to enable deoplete automatically after start nvim
let g:deoplete#enable_at_startup = 1

" Maximum candidate window width
call deoplete#custom#source('_', 'max_menu_width', 80)

" Minimum character length needed to activate auto-completion,
" see https://goo.gl/QP9am2
call deoplete#custom#source('_', 'min_pattern_length', 1)

" Whether to disable completion for certain syntax
" call deoplete#custom#source('_', {
"     \ 'filetype': ['vim'],
"     \ 'disabled_syntaxes': ['String']
"     \ })
call deoplete#custom#source('_', {
    \ 'filetype': ['python'],
    \ 'disabled_syntaxes': ['Comment']
    \ })

" Ignore certain sources, because they only cause nosie most of the time
call deoplete#custom#option('ignore_sources', {
   \ '_': ['around', 'buffer', 'tag']
   \ })

" Candidate list item number limit
call deoplete#custom#option('max_list', 30)

" The number of processes used for the deoplete parallel feature.
call deoplete#custom#option('num_processes', 16)

" The delay for completion after input, measured in milliseconds.
call deoplete#custom#option('auto_complete_delay', 100)

" Enable deoplete auto-completion
call deoplete#custom#option('auto_complete', v:true)

" Automatically close function preview windows after completion
" see https://goo.gl/Bn5n39
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Tab-complete, see https://goo.gl/LvwZZY
" inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"

"""""""""""""""""""""""""UltiSnips settings"""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use YouCompleteMe
let g:UltiSnipsExpandTrigger='<tab>'

" Shortcut to jump forward and backward in tabstop positions
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" Configuration for custom snippets directory, see
" https://jdhao.github.io/2019/04/17/neovim_snippet_s1/ for details.
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'my_snippets']

"""""""""""""""""""""""""supertab settings""""""""""""""""""""""""""
" Auto-close method preview window
let g:SuperTabClosePreviewOnPopupClose = 1

" Use the default top to bottom way for scroll, see https://goo.gl/APdo9V
let g:SuperTabDefaultCompletionType = '<c-n>'

" Shortcut to navigate forward and backward in completion menu,
" see https://is.gd/AoSv4m
let g:SuperTabMappingForward = '<tab>'
let g:SuperTabMappingBackward = '<s-tab>'
"}}

"{{ Python-related
""""""""""""""""""deoplete-jedi settings"""""""""""""""""""""""""""
" Whether to show doc string
let g:deoplete#sources#jedi#show_docstring = 0

" For large package, set autocomplete wait time longer
let g:deoplete#sources#jedi#server_timeout = 50

" Ignore jedi errors during completion
let g:deoplete#sources#jedi#ignore_errors = 1

""""""""""""""""""""""""jedi-vim settings"""""""""""""""""""
" Disable autocompletion, because I use deoplete for auto-completion
let g:jedi#completions_enabled = 0

" Whether to show function call signature
let g:jedi#show_call_signatures = '0'

"""""""""""""""""""""""""" semshi settings """""""""""""""""""""""""""""""
" Do not highlight for all occurances of variable under cursor
let g:semshi#mark_selected_nodes=0

" Do not show error sign since neomake is specicialized for that
let g:semshi#error_sign=v:false

"""""""""""""""""""""""""" simpylFold settings """""""""""""""""""""""""""""""
" Do not fold docstring
let g:SimpylFold_fold_docstring = 0
"}}

"{{ Search related
"""""""""""""""""""""""""""""vim-sneak settings"""""""""""""""""""""""
" Use sneak label mode
let g:sneak#label = 1

nmap f <Plug>Sneak_s
xmap f <Plug>Sneak_s
onoremap <silent> f :call sneak#wrap(v:operator, 2, 0, 1, 1)<CR>
nmap F <Plug>Sneak_S
xmap F <Plug>Sneak_S
onoremap <silent> F :call sneak#wrap(v:operator, 2, 1, 1, 1)<CR>

" Immediately after entering sneak mode, you can press f and F to go to next
" or previous match
let g:sneak#s_next = 1

""""""""""""""""""""""""""""is.vim settings"""""""""""""""""""""""
" To make is.vim work together well with vim-anzu and put current match in
" the center of the window.
" `zz`: put cursor line in center of the window.
" `zv`: open a fold to reveal the text when cursor step into it.
nmap n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)zzzv
nmap N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)zzzv

"""""""""""""""""""""""""""""vim-anzu settings"""""""""""""""""""""""
" Do not show search index in statusline since it is shown on command line
let g:airline#extensions#anzu#enabled = 0

" Maximum number of words to search
let g:anzu_search_limit = 500000

"""""""""""""""""""""""""""""vim-asterisk settings"""""""""""""""""""""
nmap *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
nmap #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
nmap g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
nmap g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)

"""""""""""""""""""""""""fzf settings""""""""""""""""""""""""""
" Only use fzf on Mac and Linux, since it doesn't work well for Windows
if has('unix')
    " Hide status line when open fzf window
    augroup fzf_hide_statusline
        autocmd!
        autocmd! FileType fzf
        autocmd  FileType fzf set laststatus=0 noshowmode noruler
                    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    augroup END

    " Search file recursively under current folder
    nnoremap <silent> <leader>f :FZF<cr>

    """""""""""""""""""""""""fzf.vim settings""""""""""""""""""
    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

    " [Tags] Command to generate tags file
    let g:fzf_tags_command = 'ctags -R'

    let $FZF_DEFAULT_OPTS = '--layout=reverse'
    " Floating windows only works for latest nvim version.
    " Use floating window to open the fzf search window
    let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

    function! OpenFloatingWin()

        let height = &lines - 3
        let width = float2nr(&columns - (&columns * 2 / 10))
        let col = float2nr((&columns - width) / 2)

        " Set up the attribute of floating window
        let opts = {
                \ 'relative': 'editor',
                \ 'row': height * 0.3,
                \ 'col': col + 20,
                \ 'width': width * 2 / 3,
                \ 'height': height / 2
                \ }

        let buf = nvim_create_buf(v:false, v:true)
        let win = nvim_open_win(buf, v:true, opts)

        " Floating window highlight setting
        call setwinvar(win, '&winhl', 'Normal:Pmenu')

        setlocal
                \ buftype=nofile
                \ nobuflisted
                \ bufhidden=hide
                \ nonumber
                \ norelativenumber
                \ signcolumn=no
    endfunction
endif
"}}

"{{ URL related
""""""""""""""""""""""""""""open-browser.vim settings"""""""""""""""""""
if has('win32') || has('macunix')
    " Disable netrw's gx mapping.
    let g:netrw_nogx = 1

    " Use another mapping for the open URL method
    nmap ob <Plug>(openbrowser-smart-search)
    vmap ob <Plug>(openbrowser-smart-search)
endif

"{{ Navigation and tags
""""""""""""""""""""""" nerdtree settings """"""""""""""""""""""""""
" Toggle nerdtree window and keep cursor in file window,
" adapted from http://tinyurl.com/y2kt8cy9
nnoremap <silent> <Space>s :NERDTreeToggle<CR>:wincmd p<CR>

" Reveal currently editted file in nerdtree widnow,
" see https://goo.gl/kbxDVK
nnoremap <silent> <Space>f :NERDTreeFind<CR>

" Ignore certain files and folders
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']

" Automatically show nerdtree window on entering nvim,
" see https://github.com/scrooloose/nerdtree. But now the cursor
" is in nerdtree window, so we need to change it to the file window,
" extracted from https://goo.gl/vumpvo
" autocmd VimEnter * NERDTree | wincmd l

" Delete a file buffer when you have deleted it in nerdtree
let NERDTreeAutoDeleteBuffer = 1

" Show current root as realtive path from HOME in status bar,
" see https://github.com/scrooloose/nerdtree/issues/891
let NERDTreeStatusline="%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"

" Disable bookmark and 'press ? for help' text
let NERDTreeMinimalUI=0

""""""""""""""""""""""""""" tagbar settings """"""""""""""""""""""""""""""""""
" Shortcut to toggle tagbar window
nnoremap <silent> <Space>t :TagbarToggle<CR>
"}}

"{{ File editting
""""""""""""""""""""""""""""nerdcommenter settings"""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use one space after # comment character in python,
" see http://tinyurl.com/y4hm29o3
let g:NERDAltDelims_python = 1

" Align line-wise comment delimiters flush left instead
" of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

""""""""""""""""""""""""""""vim-titlecase settings"""""""""""""""""""""""
" Do not use the default mapping provided
let g:titlecase_map_keys = 0

nmap <leader>gt <Plug>Titlecase
vmap <leader>gt <Plug>Titlecase
nmap <leader>gT <Plug>TitlecaseLine

""""""""""""""""""""""""vim-auto-save settings"""""""""""""""""""""""
" Enable autosave on nvim startup
let g:auto_save = 1

" A list of events to trigger autosave
let g:auto_save_events = ['InsertLeave', 'TextChanged']
" let g:auto_save_events = ['InsertLeave']

" Show autosave status on command line
let g:auto_save_silent = 0

""""""""""""""""""""""""""""vim-yoink settings"""""""""""""""""""""""""
if has('win32') || has('macunix')
    " ctrl-n and ctrl-p will not work if you add the TextChanged event to
    " vim-auto-save events
    " nmap <c-n> <plug>(YoinkPostPasteSwapBack)
    " nmap <c-p> <plug>(YoinkPostPasteSwapForward)

    nmap p <plug>(YoinkPaste_p)
    nmap P <plug>(YoinkPaste_P)

    " Cycle the yank stack with the following mappings
    nmap [y <plug>(YoinkRotateBack)
    nmap ]y <plug>(YoinkRotateForward)

    " Do not change the cursor position
    nmap y <plug>(YoinkYankPreserveCursorPosition)
    xmap y <plug>(YoinkYankPreserveCursorPosition)

    " Move cursor to end of paste after multiline paste
    let g:yoinkMoveCursorToEndOfPaste = 0

    " Record yanks in system clipboard
    let g:yoinkSyncSystemClipboardOnFocus = 1
endif

""""""""""""""""""""""""""""""vim-signature settings""""""""""""""""""""""""""
" Change mark highlight to be more visible
augroup signature_highlight
autocmd!
autocmd ColorScheme * highlight SignatureMarkText cterm=bold ctermbg=10
    \ gui=bold guifg=#aeee04
augroup END
"}}

"{{ Linting and formating
"""""""""""""""""""""""""""""" neomake settings """""""""""""""""""""""
" When to activate neomake
call neomake#configure#automake('nrw', 50)

" Change warning signs and color, see https://goo.gl/eHcjSq.
let g:neomake_warning_sign={'text': '!', 'texthl': 'NeomakeWarningSign'}
let g:neomake_error_sign={'text': '✗'}

" Linters enabled for Python source file linting
let g:neomake_python_enabled_makers = ['pylint']

" Whether to open quickfix or location list automatically
let g:neomake_open_list = 0

" Which linter to use for TeX source files
let g:neomake_tex_enabled_makers = []
"}}

"{{ Git-related
"""""""""""""""""""""""""vim-signify settings""""""""""""""""""""""""""""""
" The VCS to use
let g:signify_vcs_list = [ 'git' ]

" Change the sign for certain operations
let g:signify_sign_change = '~'
"}}

"{{ Markdown writing
"""""""""""""""""""""""""goyo.vim settings""""""""""""""""""""""""""""""
" Make goyo and limelight work together automatically
augroup goyo_work_with_limelight
    autocmd!
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
augroup END

"""""""""""""""""""""""""vim-pandoc-syntax settings"""""""""""""""""""""""""
" Whether to conceal urls (seems does not work)
let g:pandoc#syntax#conceal#urls = 0

" Use pandoc-syntax for markdown files, it will disable conceal feature for
" links, use it at your own risk
augroup pandoc_syntax
  au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

"""""""""""""""""""""""""plasticboy/vim-markdown settings"""""""""""""""""""
" Disable header folding
let g:vim_markdown_folding_disabled = 1

" Whether to use conceal feature in markdown
let g:vim_markdown_conceal = 1

" Disable math tex conceal and syntax highlight
let g:tex_conceal = ''
let g:vim_markdown_math = 0

" Support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

" Let the TOC window autofit so that it doesn't take too much space
let g:vim_markdown_toc_autofit = 1

"""""""""""""""""""""""""markdown-preview settings"""""""""""""""""""
" Only setting this for suitable platforms
if has('win32') || has('macunix')
    " Do not close the preview tab when switching to other buffers
    let g:mkdp_auto_close = 0

    " Shortcuts to start and stop markdown previewing
    nnoremap <silent> <M-m> :MarkdownPreview<CR>
    nnoremap <silent> <M-S-m> :MarkdownPreviewStop<CR>
endif

""""""""""""""""""""""""vim-markdownfootnotes settings""""""""""""""""""""""""
" Replace the default mappings provided by the plugin
imap ^^ <Plug>AddVimFootnote
nmap ^^ <Plug>AddVimFootnote
imap @@ <Plug>ReturnFromFootnote
nmap @@ <Plug>ReturnFromFootnote
"}}

"{{ LaTeX editting
""""""""""""""""""""""""""""vimtex settings"""""""""""""""""""""""""""""
if ( has('macunix') || has('win32')) && executable('latex')
    " Enhanced matching with matchup plugin
    let g:matchup_override_vimtex = 1

    " Set up LaTeX flavor
    let g:tex_flavor = 'latex'

    " Deoplete configurations for autocompletion to work
    call deoplete#custom#var('omni', 'input_patterns', {
              \ 'tex': g:vimtex#re#deoplete
              \})

    let g:vimtex_compiler_latexmk = {
         \ 'build_dir' : 'build',
         \}

    " TOC settings
    let g:vimtex_toc_config = {
          \ 'name' : 'TOC',
          \ 'layers' : ['content', 'todo', 'include'],
          \ 'resize' : 1,
          \ 'split_width' : 30,
          \ 'todo_sorted' : 0,
          \ 'show_help' : 1,
          \ 'show_numbers' : 1,
          \ 'mode' : 2,
          \}

    " Viewer settings for different platforms
    if has('win32')
        let g:vimtex_view_general_viewer = 'SumatraPDF'
        let g:vimtex_view_general_options_latexmk = '-reuse-instance'
        let g:vimtex_view_general_options
            \ = '-reuse-instance -forward-search @tex @line @pdf'
    endif

    if has('macunix')
        " let g:vimtex_view_method = "skim"
        let g:vimtex_view_general_viewer
                \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options = '-r @line @pdf @tex'

        " This adds a callback hook that updates Skim after compilation
        let g:vimtex_compiler_callback_hooks = ['UpdateSkim']

        function! UpdateSkim(status)
            if !a:status | return | endif

            let l:out = b:vimtex.out()
            let l:tex = expand('%:p')
            let l:cmd = [g:vimtex_view_general_viewer, '-r']

            if !empty(system('pgrep Skim'))
                call extend(l:cmd, ['-g'])
            endif

            if has('nvim')
                call jobstart(l:cmd + [line('.'), l:out, l:tex])
            elseif has('job')
                call job_start(l:cmd + [line('.'), l:out, l:tex])
            else
                call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
            endif
        endfunction
    endif
endif
"}}

"{{ UI: Status line, look
"""""""""""""""""""""""""""vim-airline setting""""""""""""""""""""""""""""""
" Set airline theme to a random one if it exists
let s:candidate_airlinetheme = ['ayu_mirage', 'base16_flat',
    \ 'base16_grayscale', 'lucius', 'base16_tomorrow', 'ayu_dark',
    \ 'base16_adwaita', 'biogoo', 'distinguished', 'jellybeans',
    \ 'luna', 'raven', 'seagull', 'term', 'vice', 'zenburn', 'tomorrow']
let s:idx = utils#RandInt(0, len(s:candidate_airlinetheme)-1)
let s:theme = s:candidate_airlinetheme[s:idx]

if utils#HasAirlinetheme(s:theme)
    let g:airline_theme=s:theme
endif

" Tabline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Show buffer number for easier switching between buffer,
" see https://github.com/vim-airline/vim-airline/issues/1149
let g:airline#extensions#tabline#buffer_nr_show = 1

" Buffer number display format
let g:airline#extensions#tabline#buffer_nr_format = '%s. '

" Whether to show function or other tags on status line
let g:airline#extensions#tagbar#enabled = 0

" Skip empty sections if there are nothing to show,
" extracted from https://vi.stackexchange.com/a/9637/15292
let g:airline_skip_empty_sections = 1

" Make airline more beautiful, see https://goo.gl/XLY19H for more info
" let g:airline_powerline_fonts = 1

" Show only hunks which are non-zero (git-related)
let g:airline#extensions#hunks#non_zero_only = 1

" Speed up airline
let g:airline_highlighting_cache = 1
"}}

"{{ Misc plugin setting
""""""""""""""""""" vim-highlightedyank settings """"""""""""""
" Reverse the highlight color for yanked text for better visuals
highlight HighlightedyankRegion cterm=reverse gui=reverse

" Let highlight endures longer
let g:highlightedyank_highlight_duration = 1000

""""""""""""""""""""""""""""vim-matchup settings"""""""""""""""""""""""""""""
" Whether to enable matching inside comment or string
let g:matchup_delim_noskips = 0

" Change highlight color of matching bracket for better visual effects
augroup matchup_matchparen_highlight
  autocmd!
  autocmd ColorScheme * highlight MatchParen cterm=underline gui=underline
augroup END

" Show matching keyword as underlined text to reduce color clutter
augroup matchup_matchword_highlight
    autocmd!
    autocmd ColorScheme * hi MatchWord cterm=underline gui=underline
augroup END

""""""""""""""""""""""""""quickrun settings"""""""""""""""""""""""""""""
let g:quickrun_no_default_key_mappings = 1
nnoremap<silent> <F9> :QuickRun<CR>
let g:quickrun_config = {'outputter/buffer/close_on_empty': 1}

""""""""""""""""""""""""comfortable-motion settings """"""""""""""""""""""
let g:comfortable_motion_scroll_down_key = 'j'
let g:comfortable_motion_scroll_up_key = 'k'

" Mouse settings
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
"}}
"}

"{ Colorscheme and highlight settings
"{{ General settings about colors
" Enable true colors support (Do not use this option if your terminal does not
" support true colors! For a comprehensive list of terminals supporting true
" colors, see https://github.com/termstandard/colors and
" https://bit.ly/2InF97t)
set termguicolors

" Use dark background
set background=dark
"}}

"{{ Colorscheme settings
""""""""""""""""""""""""""""gruvbox settings"""""""""""""""""""""""""""
" We should check if theme exists before using it, otherwise you will get
" error message when starting Nvim
if utils#HasColorscheme('gruvbox8')
    " Italic options should be put before colorscheme setting,
    " see https://goo.gl/8nXhcp
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

"""""""""""""""""""""""""""badwolf settings""""""""""""""""""""""""""
" let g:badwolf_darkgutter = 0
" " Make the tab line lighter than the background.
" let g:badwolf_tabline = 2
" colorscheme badwolf
"}}
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