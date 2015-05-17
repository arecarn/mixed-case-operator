""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Original Author: Ryan Carney
" License: WTFPL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_operator_mixed_case")
    finish
else
    let g:loaded_operator_mixed_case = 1
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" GLOBALS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:operator_mixed_case_default_mapping = 
            \ get(g:, 'operator_mixed_case_default_mapping', 1)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" MAPPINGS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:do_map(mode, lhs, rhs, name, default_option) abort "{{{2
    let plug = '<Plug>('.a:name.')'
    execute a:mode.'noremap <silent> '.plug.' '.a:rhs
    if a:default_option
        execute a:mode.'map <unique> '.a:lhs.' '.plug
    endif
endfunction "}}}2

call s:do_map(
            \ "n",
            \ "gM",
            \ ":\<C-U>set opfunc=<SID>mixed_case\<CR>g@",
            \ "operator-mixed-case",
            \ g:operator_mixed_case_default_mapping,)

call s:do_map(
            \ "n",
            \ "gMM",
            \ ":\<C-U>set opfunc=<SID>mixed_case<bar>:execute 'normal! '.v:count1.'g@_'\<CR>",
            \ "operator-line-mixed-case",
            \ g:operator_mixed_case_default_mapping,)

call s:do_map(
            \ "x",
            \ "gM",
            \ ":\<C-U>call <SID>mixed_case(visualmode())\<CR>",
            \ "operator-visual-mixed-case",
            \ g:operator_mixed_case_default_mapping,)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" FUNCTIONS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:mixed_case(type)
    "Backup Settings That We Will Change
    let sel_save = &selection
    let cb_save = &clipboard
    "make selection and clipboard work the way we need
    set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
    "Backup The Unnamed Register, Which We Will Be Yanking Into
    let reg_save = @@

    if a:type =~ '^.$'
        "if type is 'v', 'V', or '<C-V>' (i.e. 0x16) then reselect the visual region
        silent exe "normal! `<" . a:type . "`>y"
        let type=a:type
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]y"
        let type=''
    elseif a:type == 'line'
        "line-based text motion
        silent exe "normal! `[V`]y"
        let type='V'
    else
        silent exe "normal! `[v`]y"
        let type='v'
    endif
    let regtype = type

    let repl = substitute(@@, '\w\+', '\u\L&', 'g')
    "don't capitalize the  t in can't or the re in your're
    let repl = substitute(repl, '\w\+', '\u&', 'g')

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
