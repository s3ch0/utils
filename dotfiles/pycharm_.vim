" ================================================================================================
" = Extensions =====================================
" ================================================================================================
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'

" ================================================================================================
" = Basic settings =====================================
" ================================================================================================
set clipboard+=unnamed
set ignorecase
set scrolloff=30
set history=200

set number
set relativenumber

set incsearch
set hlsearch
set keep-english-in-normal

" ================================================================================================
" = No Leader Keymaps =====================================
" ================================================================================================
nmap ge <action>(GotoNextError)
nmap gt <action>(GotoTest)
nmap gm <action>(MethodUp)
" last changed in current buffer(file)
nmap ga '.

" paste之后不会把yank的内容替换掉
vmap p "_dp

" bookmark in whole program
nmap ma mA
nmap 'a 'A
nmap ms mS
nmap 's 'S
nmap md mD
nmap 'd 'D
nmap mf mF
nmap 'f 'F

" ================================================================================================
" = Leader Keymaps =====================================
" ================================================================================================
" leaderkey
let mapleader=" "

" ================================================================================================
" 👻👻👻 Which-Key 👻👻👻
" ================================================================================================
set which-key
set notimeout

" f: Find/Format ⭐️
let g:WhichKeyDesc_FindOrFormat = "<leader>f FindOrFormat"
let g:WhichKeyDesc_FindOrFormat_FindFile = "<leader>ff FindFile"
nmap <leader>ff <action>(GotoFile)

let g:WhichKeyDesc_FindOrFormat_FindFileLocation = "<leader>fl FindFileLocation"
nmap <leader>fl <action>(SelectInProjectView)

let g:WhichKeyDesc_FindOrFormat_FindText = "<leader>ft FindText"
nmap <leader>ft <action>(FindInPath)

let g:WhichKeyDesc_FindOrFormat_Commands = "<leader>fc Commands"
nmap <leader>fc <action>(GotoAction)

let g:WhichKeyDesc_FindOrFormat_OpenedProject = "<leader>fp OpenedProject"
nmap <leader>fp <action>(OpenProjectWindows)

let g:WhichKeyDesc_FindOrFormat_Format = "<leader>fm Format"
nmap <leader>fm <action>(ReformatCode) \| <action>(OptimizeImports)

" g: Git ⭐️
let g:WhichKeyDesc_Git = "<leader>g Git"
let g:WhichKeyDesc_Git_RollbackHunk = "<leader>gr RollbackHunk"
nmap <leader>gr :action Vcs.RollbackChangedLines<CR>

" i: Insert ⭐️
let g:WhichKeyDesc_InsertAfterBrackets = "<leader>i InsertAfterBrackets"
nmap <leader>i f(a

" j: add Semicolon and goto nextline⭐️
let g:WhichKeyDesc_InsertSemicolon = "<leader>j InsertSemicolon"
nmap <leader>j A;<ESC>o

" l: lsp: Language server protocol (align with neovim)⭐️
let g:WhichKeyDesc_LSP = "<leader>l LSP"
let g:WhichKeyDesc_LSP_Rename = "<leader>lr Rename"
nmap <leader>lr <action>(RenameElement)


" n: No ⭐️
let g:WhichKeyDesc_No_Highlight = "<leader>nl NoHighlight"
nmap <leader>nl :nohlsearch<CR>


" s: Show ⭐️
let g:WhichKeyDesc_Show = "<leader>s Show"
let g:WhichKeyDesc_Show_FileStructure = "<leader>ss ShowFileStructure"
nmap <leader>ss <action>(FileStructurePopup)
let g:WhichKeyDesc_Show_Bookmarks = "<leader>sb ShowBookmarks"
nmap <leader>sb <action>(ShowBookmarks)

" r: Run/Re ⭐️
let g:WhichKeyDesc_RunOrRe = "<leader>r RunOrRe"
let g:WhichKeyDesc_RunOrRe_ReRun = "<leader>rr ReRun"
nmap <leader>rr <action>(Rerun)
let g:WhichKeyDesc_RunOrRe_ReRunTests = "<leader>rt ReRunTests"
nmap <leader>rt <action>(RerunTests)
let g:WhichKeyDesc_RunOrRe_Rename = "<leader>rn Rename"
map <leader>rn <action>(RenameElement)

" w: Window ⭐️
let g:WhichKeyDesc_Windows = "<leader>w Windows"
let g:WhichKeyDesc_Windows_maximize = "<leader>wo maximize"
nmap <leader>wo <action>(UnsplitAll) \| <action>(HideAllWindows)
let g:WhichKeyDesc_Windows_splitWindowVertically = "<leader>wl splitWindowVertically"
nmap <leader>wl <action>(Macro.SplitVertically)
let g:WhichKeyDesc_Windows_closeActiveWindow = "<leader>wc closeActiveWindow"
nmap <leader>wc <c-w>c

" z: zip(fold) ⭐️
let g:WhichKeyDesc_Zip = "<leader>z Zip"
let g:WhichKeyDesc_Zip_unZipAll = "<leader>zo unZipAll"
nmap <leader>zo <action>(ExpandAllRegions)
let g:WhichKeyDesc_Zip_ZipAll = "<leader>zc ZipAll"
nmap <leader>zc <action>(CollapseAllRegions)

" c: Close ⭐️;
let g:WhichKeyDesc_CloseBuffer = "<leader>c CloseBuffer"
nmap <leader>c :q!<CR>

" e: Toggle Explorer ⭐️
let g:WhichKeyDesc_ToggleExplorerOrExtract = "<leader>e ToggleExplorer"
nmap <leader>e <action>(ActivateProjectToolWindow)
" e: Extract
" extract method/function
vmap <leader>em <action>(ExtractMethod)
" extract constant
vmap <leader>ec <action>(IntroduceConstant)
" extract field
vmap <leader>ef <action>(IntroduceField)
" extract variable
vmap <leader>ev <action>(IntroduceVariable)
