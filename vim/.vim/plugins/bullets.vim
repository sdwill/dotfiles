" ----- dkarter/bullets.vim
let g:bullets_checkbox_markers = ' -x'
let g:bullets_set_mappings = 0

if !exists('g:vscode')
    inoremap <M-cr> <Esc>:InsertNewBullet<cr>
    nnoremap o :InsertNewBullet<cr>
    vnoremap gN :RenumberSelection<cr>
    nnoremap gN :RenumberList<cr>
endif
nnoremap <leader>x :ToggleCheckbox<cr>
" nnoremap <leader>o :InsertNewBullet<cr><Esc>>>
" nnoremap <leader><M-o> :InsertNewBullet<cr><Esc>>> :call pandoc#keyboard#checkboxes#Delete()<cr>A
" nnoremap <leader><M-o>A<cr><Tab>
" Disable the promotion/demotion keybindings because they automatically force
" sub-bullets to use *, which I don't like
" inoremap <C-t> BulletDemote
" inoremap <C-d> BulletPromote
" nnoremap >> BulletDemote
" nnoremap << BulletPromote
" vnoremap > BulletDemoteVisual
" vnoremap < BulletPromoteVisual


