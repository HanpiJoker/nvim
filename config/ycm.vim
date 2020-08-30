" YCM 补全

" YCM 补全菜单配色
" 菜单
"
highlight Pmenu ctermfg=30 ctermbg=7 guifg=#005f87 guibg=#EEE8D5
" 选中项
highlight PmenuSel ctermfg=51 ctermbg=61 guifg=#AFD700 guibg=#106900

" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1

" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0

" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1

" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader>; <C-x><C-o>

" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview

" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_auto_trigger = 1

set omnifunc=syntaxcomplete#Complete

" 允许缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=1

" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1

let g:ycm_server_python_interpreter='/usr/bin/python3.6'
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'

"离开插入模式后自动关闭预览窗口"
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"补全后自动关机预览窗口"
let g:ycm_autoclose_preview_window_after_completion=1

"是否在注释中也开启补全"
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" 打开YCM的语义检测
let g:ycm_show_diagnostics_ui = 0
" <<
" >>
" 由接口快速生成实现框架

" 成员函数的实现顺序与声明顺序一致
let g:disable_protodef_sorting=1

