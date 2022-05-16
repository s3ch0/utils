" Find more examples here: https://jb.gg/share-ideavimrc
"--------------------------------------
" This file is pycharm vim plug's vimec
"--------------------------------------
"
""" Plugins  --------------------------------
set surround
set multiple-cursors
set commentary
set argtextobj
set easymotion
set textobj-entire
set ReplaceWithRegister
set exchange
" Trying the new syntax
Plug 'machakann/vim-highlightedyank'

""" Plugin settings -------------------------
let g:argtextobj_pairs="[:],(:),<:>"

" <C-n> seems to me as a better solution than <M-n>,
" but we should finally support vim-visual-multi because vim-multiple-cursors is deprecated now
map <C-n> <Plug>NextWholeOccurrence

set scrolloff=5
let mapleader=" "
" Do incremental searching.
" set incsearch
set hlsearch
""" Common settings -------------------------
set showmode
set so=5
set incsearch
set nu

""" Idea specific settings ------------------
set ideajoin
set ideastatusicon=gray

""" My Mappings -----------------------------
" map <leader>f <Plug>(easymotion-s)
map <leader>e <Plug>(easymotion-f)

map <leader>d <Action>(Debug)
map <leader>r <Action>(RenameElement)
map <leader>c <Action>(Stop)
map <leader>z <Action>(ToggleDistractionFreeMode)

map <leader>f <Action>(ReformatCode)
map <leader>s <Action>(SelectInProjectView)
map <leader>a <Action>(Annotate)
map <leader>h <Action>(Vcs.ShowTabbedFileHistory)
map <S-Space> <Action>(GotoNextError)

" Reformat the current line only
map <leader>l V<Action>(ReformatCode)

map <leader>b <Action>(ToggleLineBreakpoint)
map <leader>o <Action>(FileStructurePopup)

map <leader>J Ji <ESC>

" Just makes me nervous
map H h

" Toggle case and start typing. E.g. `<leader>iget`: `property` -> `getProperty`
map <leader>i ~hi
" Remove selection and toggle case. E.g. `v2l<leader>u`: `getProperty` -> `property`
vmap <leader>u d~h

" I think it's a better solution
map U <C-R>

""" Strict mode for development ---------------
set ideastrictmode

inoremap jk <ESC>
noremap H ^
noremap L $
noremap J 5j
noremap K 5k
noremap ; :
noremap bh :bnext<CR>
noremap bl :bprevious<CR>
noremap bo :tabnew<CR>
noremap bd :bdelete<CR>
noremap bL :blast<CR>
noremap bH :bfirst<CR>

