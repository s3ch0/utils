

"  __________________________________________
"    _   ___     _____ __  __ ____   ____
"   | \ | \ \   / /_ _|  \/  |  _ \ / ___:)
"   |  \| |\ \ / / | || |\/| | |_) | |
"   | |\  | \ V /  | || |  | |  _ <| |___
"   |_| \_|  \_/  |___|_|  |_|_| \_\\____:)  
"  __________________________________________
"     

" Author: @zhouhaobusy @theniceboy



"  Auto load for first time users
" ---------------------------------
" let g:python_host_prog = '/usr/bin/python2'
" let g:python3_host_prog = '/usr/bin/python3'
"
" ╔══════════════════════════════════════════╗
" |         ⎋  Some Vim setting  ⎋           |
" ╚══════════════════════════════════════════╝

" ===
" === Temp setting
" ===

" ===
" === Terminal Behaviors
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>

runtime! archlinux.vim
let mapleader=" "
syntax on
set wildmenu
set wrap
set cursorline
set showcmd
set relativenumber
set hlsearch
set scrolloff=5 " 始终保持光标所在行的下面还有五行
set ts=4
set softtabstop=4
set shiftwidth=4
" set expandtab
set autoindent
" set the cache for undo
silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
" silent !mkdir -p $HOME/.config/nvim/tmp/sessions
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif


" set lazyredraw " 提高宏运行速度(不显示过程)
" ╔══════════════════════════════════════════╗
" |            ⎋  Some Vim Map  ⎋            |
" ╚══════════════════════════════════════════╝

" some map

" show the current word's length
nnoremap <C-_> :echo 'word' expand('<cword>') 'has length' strlen(expand('<cword>'))<CR>
nnoremap <C-_> :echo 'word' expand('<cword>') 'has length' strlen(substitute(expand('<cword>'), '.', 'x', 'g'))<CR>
vnoremap <C-_> "-y:echo 'text' @- 'has length' strlen(@-)<CR>


" Open the vimrc file anytime
noremap <LEADER>rc :e $HOME/.config/nvim/init.vim<CR>
noremap <LEADER>rv :e .nvimrc<CR>

" let the noremal user can edit and write the root file
" noremap M :w !sudo tee > /dev/null

map tx :r !figlet
" Save & quit
" noremap Q :q<CR>
" noremap <C-q> :qa<CR>
" noremap S :w<CR>
noremap ; :
" make Y to copy till the end of the line
nnoremap Y y$

" Copy to system clipboard
vnoremap Y "+y

" Indentation
nnoremap < <<
nnoremap > >>


" Space to Tab
nnoremap <LEADER>tt :%s/    /\t/g
vnoremap <LEADER>tt :s/    /\t/g
" Disable the default s key
noremap s <nop>



" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l
noremap <LEADER>o <C-w>o


" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>




" ===
" === Tab management
" ===
" Create a new tab with tk
noremap tk :tabe<CR>
noremap tK :tab split<CR>
" Move around tabs with tn and ti
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>
" Move the tabs with tmh and tml
noremap tmh :-tabmove<CR>
noremap tml :+tabmove<CR>



" ===
" === buffer management
" ===
noremap bl :bnext<CR>
noremap bh :bprevious<CR>
noremap bo :tabnew<CR>
noremap bd :bdelete<CR>
noremap bL :blast<CR>
noremap bH :bfirst<CR>




" ===
" === Cursor Movement
" ===
" U/E keys for 5 times u/e (faster navigation)
noremap <silent> K 6k
noremap <silent> J 6j

" N key: go to the start of the line
noremap <silent> H 0
" I key: go to the end of the line
noremap <silent> L $

" Faster in-line navigation
noremap W 5w
noremap B 5b


" ===
" === Command line
" ===

cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


" ===
" === Others
" ===
inoremap jk <ESC>
nmap <C-d> :Man <C-R>=expand('<cword>') <CR><CR>
" noremap <C-f> :%s/, /\r/g<CR>
inoremap <C-p> <++> 
noremap <C-p> i<++> <ESC>
inoremap <C-f> <Esc>/<++><CR>:nohlsearch<CR>c4l
noremap <LEADER><CR> :nohlsearch<CR>

" <++>  map ttn :NERDTreeToggle<CR>

" 快速删除placeholder
map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l
" 将前面输入的单词改为大写
inoremap <C-u> <esc>gUb$a




" Press ` to change case (instead of ~)
noremap ` ~

noremap <C-c> zz

" press f10 to show hlgroup
function! SynGroup()
	let l:s = synID(line('.'), col('.'), 1)
	echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
map <F10> :call SynGroup()<CR>
inoremap <c-d> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>

" Compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		set splitbelow
		:sp
		:res -5
		term gcc -ansi -Wall % -o %< && time ./%<
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'cs'
		set splitbelow
		silent! exec "!mcs %"
		:sp
		:res -5
		:term mono %<.exe
	elseif &filetype == 'java'
		set splitbelow
		:sp
		:res -5
		term javac % && time java %<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc



map <F2> :call SetTitle()<CR>
func SetTitle()
let l = 0
let l = l + 1 | call setline(l,'/******************************')
let l = l + 1 | call setline(l,' *File name: '.expand("%"))
let l = l + 1 | call setline(l,' *Author: Busy To Live')
let l = l + 1 | call setline(l,' *Created Time: '.strftime("%c"))
let l = l + 1 | call setline(l,' *TODO: ')
let l = l + 1 | call setline(l,'******************************/')
let l = l + 1 | call setline(l,'')
let l = l + 1 | call setline(l,'#include <cstdio>')
let l = l + 1 | call setline(l,'#include <cstring>')
let l = l + 1 | call setline(l,'#include <cstdlib>')
let l = l + 1 | call setline(l,'#include <iostream>')
let l = l + 1 | call setline(l,'#include <string>')
let l = l + 1 | call setline(l,'#include <algorithm>')
let l = l + 1 | call setline(l,'#include <vector>')
let l = l + 1 | call setline(l,'#include <queue>')
let l = l + 1 | call setline(l,'#include <set>')
let l = l + 1 | call setline(l,'#include <map>')
let l = l + 1 | call setline(l,'')
let l = l + 1 | call setline(l,'using namespace std;')
let l = l + 1 | call setline(l,'int main(int argc, char *argv[])')
let l = l + 1 | call setline(l,'{')
let l = l + 1 | call setline(l,'	<++>')
let l = l + 1 | call setline(l,'}')
let l = l + 1 | call setline(l,'')
endfunc

map <F3> :call SetTitle2()<CR>
func SetTitle2()
let l = 0
let l = l + 1 | call setline(l,'/******************************')
let l = l + 1 | call setline(l,' *File name: '.expand("%"))
let l = l + 1 | call setline(l,' *Author: Busy To Live')
let l = l + 1 | call setline(l,' *Created Time: '.strftime("%c"))
let l = l + 1 | call setline(l,' *TODO: ')
let l = l + 1 | call setline(l,'******************************/')
let l = l + 1 | call setline(l,'')
let l = l + 1 | call setline(l,'#include <stdio.h>')
let l = l + 1 | call setline(l,'#include <stdlib.h>')
let l = l + 1 | call setline(l,'#include <string.h>')
let l = l + 1 | call setline(l,'#include <unistd.h>')
let l = l + 1 | call setline(l,'#include <fcntl.h>')
let l = l + 1 | call setline(l,'int main(int argc, char *argv[])')
let l = l + 1 | call setline(l,'{')
let l = l + 1 | call setline(l,'	<++>')
let l = l + 1 | call setline(l,'	exit(0);')
let l = l + 1 | call setline(l,'}')
endfunc




" ===
" --- some move keymap
" ===
function! MoveLines(offset) range
    let l:col = virtcol('.')
    let l:offset = str2nr(a:offset)
    exe 'silent! :' . a:firstline . ',' . a:lastline . 'm'
        \ . (l:offset > 0 ? a:lastline + l:offset : a:firstline + l:offset)
    exe 'normal ' . l:col . '|'
endf

" M is alt
imap <silent> <M-up> <ESC>:call MoveLines('-2')<CR>i
imap <silent> <M-down> <ESC>:call MoveLines('+1')<CR>i
nmap <silent> <M-up> :call MoveLines('-2')<CR>
nmap <silent> <M-down> :call MoveLines('+1')<CR>
vmap <silent> <M-up> :call MoveLines('-2')<CR>gv
vmap <silent> <M-down> :call MoveLines('+1')<CR>gv




" ╔═════════════════════════════════════════╗
" |            ⎋   Vim Plug   ⎋             |
" ╚═════════════════════════════════════════╝

call plug#begin('~/.config/nvim/plugged')
" Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'preservim/tagbar'
Plug 'junegunn/fzf'

Plug 'junegunn/fzf.vim'
" Plug 'chrisbra/unicode.vim'
Plug 'connorholyday/vim-snazzy' " 主题插件
Plug 'wfxr/minimap.vim'
" Plug 'mg979/vim-xtabline'
Plug 'arcticicestudio/nord-vim'
Plug 'mhinz/vim-startify' " vim羊
Plug 'preservim/nerdcommenter' " 一键注释插件 (leader + cc )
Plug 'preservim/nerdtree'   " 文件树插件 （ctrl + n）开启
Plug 'mbbill/undotree'
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yggdroot/leaderf'
Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
" vim go install
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular' "必要插件，安装在vim-markdown前面
Plug 'NLKNguyen/papercolor-theme'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-capslock'	" Ctrl+L (insert) to toggle capslock
Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
" Track the engine.
Plug 'SirVer/ultisnips'
" Plug 'gcmt/wildfire-vim'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
"安装插件
Plug 'iamcco/mathjax-support-for-mkdp'
" Plug 'iamcco/markdown-preview.vim'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }

" NVIM CONFIG
call plug#end()




" ╔═════════════════════════════════════════╗
" |       ⎋   Dress up my vim   ⎋           |
" ╚═════════════════════════════════════════╝

" 将插入模式的光标变为细条状
let &t_SI = "\<ESC>]50;CursorShape=1\x7"
let &t_SR = "\<ESC>]50;Cue=2\x7"
let &t_EI = "\<ESC>]50;CursorShape=0\x7"

" [切换主题]
map <LEADER>c1 :set background=dark<CR>:colorscheme snazzy<CR>:AirlineTheme bubblegum<CR>
map <LEADER>c2 :set background=dark<CR>:colorscheme onedark<CR>:AirlineTheme onedark<CR>
map <LEADER>c3 :set background=dark<CR>:colorscheme nord<CR>:AirlineTheme nord<CR>
map <LEADER>c4 :set background=dark<CR>:colorscheme gruvbox<CR>:AirlineTheme gruvbox<CR>
map <LEADER>c5 :set background=light<CR>:colorscheme ayu<CR>:AirlineTheme ayu<CR>

nnoremap <C-x> :GFiles<CR>

"color dracula
" color one
"color deus
"color gruvbox
"let ayucolor="light"
"color ayu
"color xcodelighthc
"set background=light
"set cursorcolumn
hi NonText ctermfg=gray guifg=grey10

set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
colorscheme snazzy
" colorscheme onedark
let g:SnazzyTransparent = 1
set background=dark
let g:gruvbox_italic=1

" airline 插件的配置
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩
let g:airline#extensions#tabline#enabled = 1   " 是否打开tabline
" 这个是安装字体后 必须设置此项" 

" 将状态栏变成箭头形状的
let g:airline_powerline_fonts = 1


set laststatus=2  "永远显示状态栏
let g:airline_theme='bubblegum' "选择主题
let g:airline#extensions#tabline#enabled=1    "Smarter tab line: 显示窗口tab和buffer
let g:airline#extensions#tabline#buffer_nr_show = 1 " 显示buffer的编号

" let g:airline#extensions#tabline#formatter = 'jsformatter'


" 设置状态栏为Leaderf状态栏样式
" let g:airline_left_sep = '▶'
" let g:airline_left_alt_sep = '❯'
" let g:airline_right_sep = '◀'
" let g:airline_right_alt_sep = '❮'
"------------------------------------
"
" 彩虹括号插件
let g:rainbow_active = 1
color snazzy
hi comment ctermfg=6





" ╔═════════════════════════════════════════╗
" |       ⎋   vim plug setting  ⎋           |
" ╚═════════════════════════════════════════╝


" ===
" --- vim_markdown
" ===
" 将vim-markdown 不设置影藏模式
let g:vim_markdown_conceal = 0
let g:vim_markdown_math = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = ['csharp=cs','c++=cpp','bash=sh', 'python=py']
"let g:vim_markdown_folding_level = 4 
" 不设置折叠
let g:vim_markdown_folding_disabled = 1


" ===
" --- Leaderf settings
" ===
" 文件搜索
nnoremap <silent> <Leader>f :Leaderf file<CR>
" 历史打开过的文件
nnoremap <silent> <Leader>m :Leaderf mru<CR>
" Buffer
nnoremap <silent> <Leader>b :Leaderf buffer<CR>
" 函数搜索（仅当前文件里）
nnoremap <silent> <Leader>F :Leaderf function<CR>
" 模糊搜索，很强大的功能，迅速秒搜
nnoremap <silent> <Leader>rg :Leaderf rg<CR>



" ===
" --- indentLine 的配置
" ===

" let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进


" ===
" --- nerdcommenter  
" === 
" 撤销注释 <LEADER>+cu  
" 添加注释 <LEADER>+cc 
" Create default mappings 
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCustomDelimiters = { 'php': { 'left': '/*','right': '*/' },'html': { 'left': '<!--','right': '-->' },'py': { 'left': '#' },'sh': { 'left': '#' } ,'c': { 'left': '//'}   }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1


" ===
" --- UltiSnap 的配置
" ===
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-n>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" ===
" === MarkdownPreview
" ===
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''
let g:mkdp_browser = 'firefox'


" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '[${name}]'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" let g:mkdp_auto_start = 0
" let g:mkdp_auto_close = 1
" let g:mkdp_refresh_slow = 0
" let g:mkdp_command_for_global = 0
" let g:mkdp_open_to_the_world = 0
" let g:mkdp_open_ip = ''
" let g:mkdp_browser = 'firefox'
" let g:mkdp_echo_preview_url = 1
" let g:mkdp_browserfunc = ''
" let g:mkdp_markdown_css = ''
" let g:mkdp_highlight_css = ''
" let g:mkdp_port = ''
" let g:mkdp_page_title = '「${name}」'
" nmap <C-s> <Plug>MarkdownPreview
" nmap <C-c> <Plug>MarkdownPreviewStop
" nmap <C-p> <Plug>MarkdownPreviewToggle



" ===
" --- You Complete ME
" ===
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-diagnostic',
	\ 'coc-docker',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-go',
	\ 'coc-flutter-tools',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-import-cost',
	\ 'coc-java',
	\ 'coc-jest',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-omnisharp',
	\ 'coc-prettier',
	\ 'coc-prisma',
	\ 'coc-pyright',
	\ 'coc-snippets',
	\ 'coc-sourcekit',
	\ 'coc-stylelint',
	\ 'coc-syntax',
	\ 'coc-tailwindcss',
	\ 'coc-tasks',
	\ 'coc-translator',
	\ 'coc-tsserver',
	\ 'coc-vetur',
	\ 'coc-vimlsp',
	\ 'coc-yaml',
	\ 'coc-yank']

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c
" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" always show signcolumns
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" let <CR> become auto Completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-o> coc#refresh()
function! Show_documentation()
	call CocActionAsync('highlight')
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
nnoremap ? :call Show_documentation()<CR>
" set runtimepath^=~/.config/nvim/coc-extensions/coc-flutter-tools/
" let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']
" let $NVIM_COC_LOG_LEVEL = 'debug'
" let $NVIM_COC_LOG_FILE = '/Users/david/Desktop/log.txt'

nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<cr>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nnoremap <c-c> :CocCommand<CR>
" Text Objects
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap kc <Plug>(coc-classobj-i)
omap kc <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap tt :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>aw  <Plug>(coc-codeaction-selected)w
" coctodolist
" nnoremap <leader>tn :CocCommand todolist.create<CR>
" nnoremap <leader>tl :CocList todolist<CR>
" nnoremap <leader>tu :CocCommand todolist.download<CR>:CocCommand todolist.upload<CR>
" coc-tasks
noremap <silent> <leader>ts :CocList tasks<CR>
" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-e> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-e>'
let g:coc_snippet_prev = '<c-n>'
imap <C-e> <Plug>(coc-snippets-expand-jump)
let g:snips_author = 'zhouhaobusy'
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc





" ==
" == vim-multiple-cursor
" ==

" --------------------------------------
"  some map instruction of this
"  <C-k>/n --> 查找下一个单词 (默认为 <C-n>)
"  Q       --> 删除选中的光标
"  [/]     --> 往上往下选择光标
"
" --------------------------------------

"let g:multi_cursor_use_default_mapping=0
let g:VM_maps                          = {}
let g:VM_maps["Find Under"]            = '<c-k>'
let g:VM_maps["Find Subword Under"]    = '<c-k>'
let g:VM_maps["Skip Region"]           = '<c-n>'



" ==
" == Tagbar
" ==
" need install ctags at first
nmap <S-t> :TagbarToggle<CR>


" ===
" === Undotree
" ===
noremap M :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> k <plug>UndotreeNextState
	nmap <buffer> j <plug>UndotreePreviousState
	nmap <buffer> K 5<plug>UndotreeNextState
	nmap <buffer> J 5<plug>UndotreePreviousState
endfunc

" ===
" === tabular
" ===
vmap ga :Tabularize /

" ===
" === sdcv
" ===


set keywordprg=sdcv\ -u\ 朗道英汉字典5.0 " 这边的字典要看你安装了什么
function! MySdcv()
    let retStr=system('sdcv '.expand("<cword>"))
    windo if expand("%")=="dictWin" |q!|endif
    30vsp dictWin
    setlocal buftype=nofile bufhidden=hide noswapfile
    1s/^/\=retStr/
    1
endfunction

map F :call MySdcv()<CR>





" use linux move in inset mode
" inoremap <C-a> <ESC>^i
" inoremap <C-e> <ESC>$a


" ===
" === minimap
" ===
"
let g:minimap_width = 5 
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 1

" ===
" === vim-go
" ===
let g:go_echo_go_info = 0
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_doc_keywordprg_enabled = 0

