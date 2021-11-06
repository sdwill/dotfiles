" ----- Goyo: reapply colorscheme when exiting
" Goyo calls 'colorscheme [x]' when leaving, which causes the same issues as
" switching colorschemes in general, i.e. the highlighting disappears for many
" syntax elements.  To work around this, we just disable and re-enable syntax
" highlighting.
function! s:goyo_leave()
    syntax clear
    syntax on
endfunction
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" -----
