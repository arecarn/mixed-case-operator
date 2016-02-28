""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Original Author: Ryan Carney
" License: WTFPL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let s:save_cpo = &cpo
set cpo&vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" PUBLIC_FUNCTIONS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! operator_mixed_case#operator(type)
    "Backup Settings That We Will Change
    let sel_save = &selection
    let cb_save = &clipboard
    "make selection and clipboard work the way we need
    set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
    "Backup The Unnamed Register, Which We Will Be Yanking Into
    let reg_save = @@

    if a:type =~ '^.$'
        "if type is 'v', 'V', or '<C-V>' (i.e. 0x16) then re-select the visual region
        silent exe "normal! `<" . a:type . "`>y"
        let type=a:type
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]y"
        let type='\<C-V>'
    elseif a:type == 'line'
        "line-based text motion
        silent exe "normal! `[V`]y"
        let type='V'
    else
        silent exe "normal! `[v`]y"
        let type='v'
    endif
    let regtype = type

    let repl = substitute(@@, '\w\+', '\u\L\0', 'g')

    "don't capitalize the  t in can't or the re in your're
    let repl = substitute(repl, '''\zs\w\+', '\l\0', 'g')

    call setreg('@', repl, regtype)

    normal! gvp

    " return cursor to appropriate place
    execute "normal! gvo\<Esc>"

    set nohlsearch

    "Restore Saved Settings And Register Value
    let @@ = reg_save
    let &selection = sel_save
    let &clipboard = cb_save
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let &cpo = s:save_cpo
unlet s:save_cpo
" vim:foldmethod=marker
" vim: textwidth=78
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
