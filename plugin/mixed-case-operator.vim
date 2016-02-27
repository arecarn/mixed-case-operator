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
            \ ":\<C-U>set opfunc=mixed_case_operator#operator\<CR>g@",
            \ "operator-mixed-case",
            \ g:operator_mixed_case_default_mapping,)

call s:do_map(
            \ "n",
            \ "gMM",
            \ ":\<C-U>set opfunc=mixed_case_operator#operator<bar>:execute 'normal! '.v:count1.'g@_'\<CR>",
            \ "operator-line-mixed-case",
            \ g:operator_mixed_case_default_mapping,)

call s:do_map(
            \ "x",
            \ "gM",
            \ ":\<C-U>call mixed_case_operator#operator(visualmode())\<CR>",
            \ "operator-visual-mixed-case",
            \ g:operator_mixed_case_default_mapping,)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let &cpo = s:save_cpo
unlet s:save_cpo
" vim:foldmethod=marker
" vim: textwidth=78
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
