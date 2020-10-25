" 库信息参考
" 启用:Man命令查看各类man信息
source $VIMRUNTIME/ftplugin/man.vim

" 定义:Man命令查看各类man信息的快捷键
nmap <Leader>man :Man 3 <C-R>=expand("<cword>")<CR><CR> 

" 快捷键
map <SPACE> <Plug>(wildfire-fuel)
vmap <S-SPACE> <Plug>(wildfire-water)

" 适用于哪些结对符
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]

" Nerdcommenter 配置
let g:NERDSpaceDelims=1

" auto-pairs 配置
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'
let g:AutoPairsShortcutJump = '<M-n>'

" vim-autoformat
let g:formatdef_harttle = '"astyle --style=kr --pad-oper"'
let g:formatters_cpp = ['harttle']
let g:formatters_c = ['harttle']
let g:formatters_java = ['harttle']
" Multip Cursor 
" Default key mapping  
let g:multi_cursor_next_key='<C-n>'  
let g:multi_cursor_prev_key='<C-p>' 
let g:multi_cursor_skip_key='<C-x>'  
let g:multi_cursor_quit_key='<Esc>'

"Air Line Setting
let g:airline_theme='solarized_flood'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_step = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts=1
let g:airline#extensions#coc#enabled = 1

" Ale Error Check
"始终开启标志列
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
" Clang for C & C++
let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\}
" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" === MarkdownPreview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'chromium'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" === Vim Table Mode
" <Leader>tdd 删除一行
" <Leader>tdc 删除一列
nnoremap <leader>tm :TableModeToggle<CR>
" === Vim MarkDown
"let g:markdown_enable_conceal = ""
let g:markdown_quote_syntax_on_filetypes = ['text']
set conceallevel=2

" === UndoTree
function! OpenUndoTree()
    UndotreeToggle 
endfunction
nnoremap <leader>ud :call OpenUndoTree()<CR>
let g:undotree_WindowLayout = 2
set undodir=~/.undodir/
set undofile

" === Goyo
nnoremap <leader>go :Goyo<CR>

" === vim-translate-me
" <Leader>t 翻译光标下的文本，在命令行回显
nmap <silent> <Leader>te <Plug>Translate
vmap <silent> <Leader>te <Plug>TranslateV
" Leader>w 翻译光标下的文本，在窗口中显示
nmap <silent> <Leader>we <Plug>TranslateW
vmap <silent> <Leader>we <Plug>TranslateWV
" Leader>r 替换光标下的文本为翻译内容
nmap <silent> <Leader>re <Plug>TranslateR
vmap <silent> <Leader>re <Plug>TranslateRV

" 设置ctrlsf
let g:ctrlsf_ackprg = 'rg'
let g:ctrlsf_auto_close = {
    \ "normal" : 0,
    \ "compact": 0
    \}
let g:ctrlsf_auto_focus = {
    \ "at": "done",
    \ "duration_less_than": 1000
    \ }
let g:ctrlsf_default_view_mode = 'compact'
nmap <Leader>sf :CtrlSF<space>
nmap <Leader>sn <Plug>CtrlSFCwordPath<CR>
vmap <Leader>sv <Plug>CtrlSFVwordPath<CR>

" 让输入上方，搜索列表在下方
let $FZF_DEFAULT_OPTS = '--layout=reverse'
let g:fzf_layout = { 'window': 'call OpenFloatingWin()'  }
function! OpenFloatingWin()
	let height = &lines - 3
	let width = float2nr(&columns - (&columns * 2 / 10))
	let col = float2nr((&columns - width) / 2)

	" 设置浮动窗口打开的位置，大小等。
	" 这里的大小配置可能不是那么的 flexible 有继续改进的空间
	let opts = {
				\ 'relative': 'editor',
				\ 'row': height * 0.3,
				\ 'col': col + 30,
				\ 'width': width * 2 / 3,
				\ 'height': height / 2
				\ }

	let buf = nvim_create_buf(v:false, v:true)
	let win = nvim_open_win(buf, v:true, opts)

	" 设置浮动窗口高亮
	call setwinvar(win, '&winhl', 'Normal:Pmenu')

	setlocal
		\ buftype=nofile
		\ nobuflisted
		\ bufhidden=hide
		\ nonumber
		\ norelativenumber
		\ signcolumn=no
endfunction

" Vista Setting
" NOTE: vista need universal-ctags support jansson first. 
" 1. Install Jansson First.
" 2. git clone universal-ctags.git and install ctags manuaully
let g:vista#executives = ['coc', 'ctags', 'vim_lsp']
" Declare the command including the executable and options used to generate ctags output
" " for some certain filetypes.The file path will be appened to your custom command.
" " For example:
"
let g:vista_executive_for = {
	\'vim': 'vim_lsp',
	\'c': 'ctags',
	\'rust': 'coc',
	\'cpp': 'coc'}
" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

let g:vista_stay_on_open = 0
let g:vista_echo_cursor_strategy = 'scroll'
let g:vista_sidebar_position = 'vertical topleft'
let g:vista_update_on_text_changed_delay = 10
let g:vista_cursor_delay = 10
nnoremap <leader>vf :Vista finder<CR>
nnoremap <Leader>vt :Vista!!<CR>

" floaterm keymapping, install neovim-remote remember
nnoremap <leader>ft :FloatermToggle<CR>
tnoremap <leader>ft <C-\><C-n>:FloatermToggle<CR>
tnoremap <esc><esc> <C-\><C-n>:FloatermToggle<CR>
nnoremap <leader>fw :FloatermNew<CR>
tnoremap <leader>fw <C-\><C-n>:FloatermNew<CR>
nnoremap <leader>fp :FloatermPrev<CR>
tnoremap <leader>fp <C-\><C-n>:FloatermPrev<CR>
nnoremap <leader>fn :FloatermNext<CR>
tnoremap <leader>fn <C-\><C-n>:FloatermNext<CR>

" vimlsp setting
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]
