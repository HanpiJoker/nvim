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
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_step = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#enabled = 0

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
"let g:mkdp_browser = '/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
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
let g:translator_window_max_height = 0.9
let g:translator_window_max_width = 0.9

" 让输入上方，搜索列表在下方
let $FZF_DEFAULT_OPTS = '--layout=reverse'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

"let g:vista_default_executive = 'coc'
"let g:vista_executive_for = {
"	\'c': 'coc',
"	\'rust': 'coc',
"	\'cpp': 'coc'}
"let g:vista_fzf_preview = ['right:50%']
"let g:vista#renderer#enable_icon = 1
"let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
"
"let g:vista_stay_on_open = 0
"let g:vista_echo_cursor_strategy = 'scroll'
"let g:vista_sidebar_position = 'vertical topleft'
"let g:vista_update_on_text_changed_delay = 10
"let g:vista_cursor_delay = 10
"let g:vista_ignore_kinds = ['Variable']
"nnoremap <leader>vf :Vista finder<CR>
"nnoremap <Leader>vt :Vista!!<CR>
"autocmd BufEnter * if winnr("$") == 1 && vista#sidebar#IsOpen() | execute "normal! :q!\<CR>" | endif
"function! NearestMethodOrFunction() abort
"  return get(b:, 'vista_nearest_method_or_function', '')
"endfunction
"
"set statusline+=%{NearestMethodOrFunction()}
"
"autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" floaterm keymapping, install neovim-remote remember
let g:floaterm_autoclose = 2
nnoremap <leader>ft :FloatermToggle<CR>
tnoremap <leader>ft <C-\><C-n>:FloatermToggle<CR>
nnoremap <leader>fw :FloatermNew<CR>
tnoremap <leader>fw <C-\><C-n>:FloatermNew<CR>
nnoremap <leader>fk :FloatermKill<CR>
tnoremap <leader>fk <C-\><C-n>:FloatermKill<CR>
nnoremap <leader>fp :FloatermPrev<CR>
tnoremap <leader>fp <C-\><C-n>:FloatermPrev<CR>
nnoremap <leader>fn :FloatermNext<CR>
tnoremap <leader>fn <C-\><C-n>:FloatermNext<CR>

" vimlsp setting
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

" blamer.nvim
let g:blamer_enabled = 1
let g:blamer_delay = 1000
let g:blamer_date_format = '%y/%m/%d'
let g:blamer_template = '<commit-short>, <committer> -- <summary>'
highlight Blamer guifg=lightgrey

" easymotion setting
" disable default mappings
let g:EasyMotion_do_mapping = 0

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

let g:EasyMotion_prompt = '🔎 {n} >>>'

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

autocmd User EasyMotionPromptBegin silent! CocDisable
autocmd User EasyMotionPromptEnd   silent! CocEnable

" FZF funcitong key-mapping
function! RipgrepFzf(query, fullscreen)
	let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
	let initial_command = printf(command_fmt, shellescape(a:query))
	let reload_command = printf(command_fmt, '{q}')
	let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
	call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <leader>sn :RG <c-r>=expand("<cword>")<cr><cr>
nnoremap <leader>sf :FZF<CR>
