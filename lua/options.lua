local options = {
	termguicolors = true,

	clipboard = "unnamedplus", -- 同步系统剪贴板

	tabstop = 4, -- 设置编辑时制表符占用空格数
	shiftwidth = 4, -- 设置格式化时制表符占用空格数
	softtabstop = 4, -- 将连续的空格视为一个制表符
	-- expandtab = true, -- 将制表符替换为空格

	number = true, -- 开启行号显示
	relativenumber = true, -- 开启相对行号显示
	cursorline = true, -- 高亮当前行
	cursorcolumn = true, -- 高亮当前列
	colorcolumn = "80,120", -- 高亮指定行
	textwidth = 99,
	statuscolumn = "%s %l %r",
	laststatus = 3,

	wrap = false, -- 禁止自动换行

	-- 代码补全设置
	wildmenu = false, -- nvim-cmp support cmdline autocomplete
	wildoptions = "pum",
	completeopt = "menu,menuone,noselect",

	-- 代码不自动折叠，基于语法进行折叠
	foldmethod = "syntax",
	foldenable = false,

	cindent = true,
	undofile = true,
	undodir = "/home/cambricon/.local/state/nvim/undodir",
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ";"
vim.opt.shortmess:append("c")
vim.opt.formatoptions:append("mM")
for key, value in pairs(options) do
	vim.opt[key] = value
end

-- set clipboard, ubuntu need install xclip, wsl2 need install win32yank
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
elseif vim.env.DISPLAY and vim.fn.executable("xclip") == 1 then
	vim.g.clipboard = {
		name = "xclip",
		copy = {
			["+"] = "xclip -selection clipboard",
			["*"] = "xclip -selection clipboard",
		},
		paste = {
			["+"] = "xclip -selection clipboard -o",
			["*"] = "xclip -selection clipboard -o",
		},
		cache_enabled = 1,
	}
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter.setup", {}),
	callback = function(args)
		local buf = args.buf
		local filetype = args.match

		-- you need some mechanism to avoid running on buffers that do not
		-- correspond to a language (like oil.nvim buffers), this implementation
		-- checks if a parser exists for the current language
		local language = vim.treesitter.language.get_lang(filetype) or filetype
		if not vim.treesitter.language.add(language) then
			return
		end

		-- replicate `fold = { enable = true }`
		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

		-- replicate `highlight = { enable = true }`
		vim.treesitter.start(buf, language)

		-- replicate `indent = { enable = true }`
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

		-- `incremental_selection = { enable = true }` cannot be easily replicated
	end,
})

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
		if not client or type(value) ~= "table" then
			return
		end
		local p = progress[client.id]

		for i = 1, #p + 1 do
			if i == #p + 1 or p[i].token == ev.data.params.token then
				p[i] = {
					token = ev.data.params.token,
					msg = ("[%3d%%] %s%s"):format(
						value.kind == "end" and 100 or value.percentage or 100,
						value.title or "",
						value.message and (" **%s**"):format(value.message) or ""
					),
					done = value.kind == "end",
				}
				break
			end
		end

		local msg = {} ---@type string[]
		progress[client.id] = vim.tbl_filter(function(v)
			return table.insert(msg, v.msg) or not v.done
		end, p)

		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(table.concat(msg, "\n"), "info", {
			id = "lsp_progress",
			title = client.name,
			opts = function(notif)
				notif.icon = #progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})
