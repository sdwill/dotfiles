" ----- Remove ALL autocommands for the current group.
" See https://stackoverflow.com/questions/18024842/vimrc-file-takes-longer-and-longer-to-reload
:autocmd!
" -----
source ~/.vim/general.vim
source ~/.vim/guifont.vim
source ~/.vim/keybindings.vim
source ~/.vim/vim_plug.vim
source ~/.vim/python.vim

" source ~/.vim/plugins/dashboard_nvim.vim
" source ~/.vim/plugins/markdown.vim
source ~/.vim/plugins/vim_pandoc.vim
" source ~/.vim/plugins/lightline.vim
" source ~/.vim/plugins/lightline_bufferline.vim
source ~/.vim/plugins/bullets.vim
source ~/.vim/plugins/goyo.vim
source ~/.vim/plugins/vim-maximizer.vim
" source ~/.vim/plugins/vim-latex.vim
" source ~/.vim/plugins/vimtex.vim

" source ~/.vim/plugins/fzf.vim
source ~/.vim/plugins/telescope.lua
source ~/.vim/plugins/telescope-file-browser.lua
source ~/.vim/plugins/todo-comments.lua
source ~/.vim/plugins/toggleterm.lua
source ~/.vim/plugins/autosave.lua
source ~/.vim/plugins/vim-easy-align.vim
source ~/.vim/plugins/taboo.vim
source ~/.vim/plugins/zen-mode.lua

source ~/.vim/plugins/lualine.lua

" ----- Color schemes: more at https://vimcolorschemes.com/
" NOTE: setting any of these colorschemes will cause bold/italics in Markdown to disappear after reloading .vimrc. See:
"   - https://github.com/vim-pandoc/vim-pandoc-syntax/issues/200
"   - https://github.com/altercation/solarized/issues/102
" Colors can be restored by resetting filetype manually, e.g. :setf pandoc

set background=light

" source ~/.vim/plugins/vim-colors-pencil.vim
" source ~/.vim/plugins/vim-colors-github.vim
" source ~/.vim/plugins/papercolor-theme.vim
" source ~/.vim/plugins/solarized8.vim
" source ~/.vim/plugins/joshdick-onedark.vim
" source ~/.vim/plugins/tokyonight-vim.vim
" source ~/.vim/plugins/neodark.vim
" source ~/.vim/plugins/vim-one.vim
" source ~/.vim/plugins/onehalf.vim
" source ~/.vim/plugins/doom-one.vim
" source ~/.vim/plugins/vim-deus.vim
" source ~/.vim/plugins/toast.vim
" source ~/.vim/plugins/nord-vim.vim

" With treesitter support
" source ~/.vim/plugins/one-nvim.vim
" source ~/.vim/plugins/navarasu-onedark.vim
" source ~/.vim/plugins/edge.vim
" source ~/.vim/plugins/neon.lua
" source ~/.vim/plugins/sonokai.vim
" source ~/.vim/plugins/tokyonight.lua
" source ~/.vim/plugins/kanagawa.lua
" source ~/.vim/plugins/nightfox.lua
source ~/.vim/plugins/everforest.vim
" source ~/.vim/plugins/rose-pine.lua
" source ~/.vim/plugins/onenord.lua
" source ~/.vim/plugins/zephyr.vim
" -----

" NOTE! Involves reloading lightline, so will cause an error if lightline doesn't exist
source ~/.vim/reload-config.vim

