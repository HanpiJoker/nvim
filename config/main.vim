" 定义快捷键的前缀，即 <Leader>
let mapleader=";"
" 开启256色 
set t_Co=256
set ttimeoutlen=50
" >>
" 文件类型侦测
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" 开启行号显示
set number
set relativenumber
" 高亮当前行
set cursorline cursorcolumn
" 禁止折行
set nowrap
set sidescroll=1
" 自动换行
set textwidth=99
set formatoptions+=mM
" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on
" 自适应不同语言的智能缩进
filetype indent on

" 将制表符扩展为空格
" set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" 基于缩进或语法进行代码折叠
" set foldmethod=manual
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

set completeopt=noinsert,menuone,noselect      

" 配色方案
" set background=dark
" 透明
colorscheme solarized
" colorscheme desert256
" hi Normal ctermbg=NONE
" >>
" vim 自身（非插件）快捷键
" 插入模式下的快捷移动
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p

" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>wq :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>

" 设置快捷键遍历子窗口
" 依次遍历
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j

" 定义快捷键在结对符之间跳转
nmap <Leader>M %

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" <Leader>f{char} to move to {char}
map  <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Leader><Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader><Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader><Leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

nmap <leader>bn :bn<CR>
nmap <leader>bp :bp<CR>
nmap <leader>bd :bd<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 引入 C++ 标准库 tags
"set tags+=/usr/include/c++/9.1.0/stdcpp.tags
"set tags+=/usr/include/sys.tags
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("./cscope/cscope.out")
      cs add ./cscope/cscope.out
  endif
  set csverb
"  set cscopequickfix=g-,c-,d-,i-,t-,e-,s-
endif

nmap <C-s>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-s>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-s>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-s>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-s>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-s>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-s>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-s>d :cs find d <C-R>=expand("<cword>")<CR><CR>

au! BufRead,BufNewFile *.markdown set filetype=markdown
au! BufRead,BufNewFile *.md set filetype=markdown

"show tab and enter character 
set list lcs+=tab:\┆\ ,eol:¬

" set clipboard, install xclip at first
let g:clipboard = {
  \   'name': 'xclip-ubuntu',
  \   'copy': {
  \      '+': 'xclip -selection clipboard',
  \      '*': 'xclip -selection clipboard',
  \    },
  \   'paste': {
  \      '+': 'xclip -selection clipboard -o',
  \      '*': 'xclip -selection clipboard -o',
  \   },
  \   'cache_enabled': 1,
  \ }

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
	\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
	\,sm:block-blinkwait175-blinkoff150-blinkon175
