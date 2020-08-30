" 更新时间: 2019-12-22
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'

" 插件安装
call plug#begin('~/.config/nvim/plugged')
" Error Check
" Plug 'dense-analysis/ale'
" C++语法高亮
Plug 'octol/vim-cpp-enhanced-highlight'
" 多光标
Plug 'terryma/vim-multiple-cursors'
" 智能注释
Plug 'scrooloose/nerdcommenter'
" 代码块补全
Plug 'honza/vim-snippets'
" 代码补全
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

Plug 'easymotion/vim-easymotion'
" 快速选择结对符内文本
Plug 'gcmt/wildfire.vim'
" 为指定文本加括号
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
" 自动格式化代码
Plug 'Chiel92/vim-autoformat'
" Status Line Plugin
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
" 项目效率插件
Plug 'liuchengxu/vista.vim'
Plug 'mbbill/undotree'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'
Plug 'junegunn/fzf.vim'
Plug 'lilydjwg/fcitx.vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'plasticboy/vim-markdown'
Plug 'vimwiki/vimwiki'
Plug 'joker1007/vim-markdown-quote-syntax'

" Other 
Plug 'junegunn/goyo.vim'
Plug 'voldikss/vim-translate-me'
Plug 'dyng/ctrlsf.vim'
Plug 'voldikss/vim-floaterm'
" 插件列表结束
call plug#end()

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/plugin.vim'

" 补全菜单颜色
" highlight Pmenu ctermfg=33 ctermbg=7 guifg=#005f87 guibg=#EEE8D5
" 选中项
" highlight PmenuSel ctermfg=51 ctermbg=61 guifg=#AFD700 guibg=#106900

if filereadable(fnamemodify(expand('<sfile>'), ':h').'/config/coc.vim')
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/coc.vim'
endif

if filereadable(fnamemodify(expand('<sfile>'), ':h').'/config/defx.vim')
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/defx.vim'
endif
