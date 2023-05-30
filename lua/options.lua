local options = {
	termguicolors = true,

	clipboard = 'unnamedplus', -- 同步系统剪贴板

	tabstop = 4,         -- 设置编辑时制表符占用空格数
	shiftwidth = 4,      -- 设置格式化时制表符占用空格数
	softtabstop = 4,     -- 将连续的空格视为一个制表符
	-- expandtab = true, -- 将制表符替换为空格

	number = true,         -- 开启行号显示
	relativenumber = true, -- 开启相对行号显示
	cursorline = true,     -- 高亮当前行
	cursorcolumn = true,   -- 高亮当前列
	colorcolumn = "80,120", -- 高亮指定行
	textwidth = 99,

	wrap = false,  -- 禁止自动换行

	-- 代码补全设置
	wildoptions = "pum",
	completeopt = "noinsert,menuone,noselect",

	-- 代码不自动折叠，基于语法进行折叠
	foldmethod = "syntax",
	foldenable = false,

	cindent = true,
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.shortmess:append 'c'
vim.opt.formatoptions:append 'mM'
for key, value in pairs(options) do
    vim.opt[key] = value
end

-- set clipboard, ubuntu need install xclip, wsl2 need install win32yank
if vim.fn.has('wsl') == 1 then
	vim.g.clipboard = {
		name = 'win32yank-wsl',
		copy = {
			['+'] = 'win32yank.exe -i --crlf',
			['*'] = 'win32yank.exe -i --crlf',
		},
		paste = {
			['+'] = 'win32yank.exe -o --lf',
			['*'] = 'win32yank.exe -o --lf',
		},
		cache_enabled = 0,
	}
elseif vim.fn.executable('xclip') == 1 then
	vim.g.clipboard = {
		name = 'xclip-ubuntu',
		copy = {
			['+'] = 'xclip -selection clipboard',
			['*'] = 'xclip -selection clipboard',
		},
		paste = {
			['+'] = 'xclip -selection clipboard -o',
			['*'] = 'xclip -selection clipboard -o',
		},
		cache_enabled = 1,
	}
end
