" Remove trailing white space, see https://vi.stackexchange.com/a/456/15292
function utils#StripTrailingWhitespaces() abort
    let l:save = winsaveview()
    " vint: next-line -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    keeppatterns %s/\v\s+$//e
    call winrestview(l:save)
endfunction

" Create command alias safely, see https://stackoverflow.com/q/3878692/6064933
" The following two functions are taken from answer below on SO:
" https://stackoverflow.com/a/10708687/6064933
function! utils#Cabbrev(key, value) abort
    execute printf('cabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() <= %d) ? %s : %s',
    \ a:key, 1+len(a:key), <SID>Single_quote(a:value), <SID>Single_quote(a:key))
endfunction

function! s:Single_quote(str) abort
    return "'" . substitute(copy(a:str), "'", "''", 'g') . "'"
endfunction

" Check the syntax group in the current cursor position, see
" https://stackoverflow.com/q/9464844/6064933 and
" https://jordanelver.co.uk/blog/2015/05/27/working-with-vim-colorschemes/
function! utils#SynGroup() abort
    if !exists('*synstack')
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" Check if a colorscheme exists in runtimepath.
" The following two functions are inspired by https://stackoverflow.com/a/5703164/6064933.
function! utils#HasColorscheme(name) abort
    let l:pat = 'colors/' . a:name . '.vim'
    return !empty(globpath(&runtimepath, l:pat))
endfunction

" Check if an Airline theme exists in runtimepath.
function! utils#HasAirlinetheme(name) abort
    let l:pat = 'autoload/airline/themes/' . a:name . '.vim'
    return !empty(globpath(&runtimepath, l:pat))
endfunction

" Generate random integers in the range [Low, High] in pure vimscrpt,
" adapted from https://stackoverflow.com/a/12739441/6064933
function! utils#RandInt(Low, High) abort
    let l:milisec = str2nr(matchstr(reltimestr(reltime()), '\v\.\zs\d+'), 10)
    return l:milisec % (a:High - a:Low + 1) + a:Low
endfunction

" Custom fold expr, adapted from https://vi.stackexchange.com/a/9094/15292
function! utils#VimFolds(lnum) abort
    " get content of current line and the line below
    let l:cur_line = getline(a:lnum)
    let l:next_line = getline(a:lnum+1)

    if l:cur_line =~# '^"{'
        return '>' . (matchend(l:cur_line, '"{*') - 1)
    else
        if l:cur_line ==# '' && (matchend(l:next_line, '"{*') - 1) == 1
            return 0
        else
            return '='
        endif
    endif
endfunction

" Custom fold text, adapted from https://vi.stackexchange.com/a/3818/15292
" and https://vi.stackexchange.com/a/6608/15292
function! utils#MyFoldText() abort
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) - len(folded_line_num) - 10
    return '+'. repeat('-', 4) . line_text . repeat('.', fillcharcount) . ' (' . folded_line_num . ' L)'
endfunction

" Toggle cursor column
function! utils#ToggleCursorCol() abort
    if &cursorcolumn
        set nocursorcolumn
        echo "cursorcolumn: OFF"
    else
        set cursorcolumn
        echo "cursorcolumn: ON"
    endif
endfunction
