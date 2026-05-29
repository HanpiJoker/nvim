vim.loader.enable()

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
		if name == "mason.nvim" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("mason.nvim")
			end
			vim.cmd("MasonUpdate")
		end
		if name == "Trans.nvim" and kind == "install" then
			if not ev.data.active then
				vim.cmd.packadd("Trans.nvim")
			end
			require("Trans").install()
		end
	end,
})

vim.pack.add({
	-- colorscheme (load first)
	"https://github.com/catppuccin/nvim",
	-- dependencies (load before plugins that need them)
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/kkharji/sqlite.lua",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	-- ui
	"https://github.com/folke/noice.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
	-- editing
	"https://github.com/gbprod/yanky.nvim",
	"https://github.com/pteroctopus/faster.nvim",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/smoka7/hop.nvim",
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/nvim-pack/nvim-spectre",
	-- git
	"https://github.com/lewis6991/gitsigns.nvim",
	-- lsp & completion
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/mason/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
	-- formatting & linting
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mfussenegger/nvim-lint",
	-- projects
	"https://github.com/DrKJeff16/project.nvim",
	-- markdown
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	-- translate
	"https://github.com/JuanZoran/Trans.nvim",
	-- snacks (load last as it has many submodules)
	"https://github.com/folke/snacks.nvim",
	-- opencode
	"https://github.com/nickjvandyke/opencode.nvim",
})

require("options")
require("lspconfig")

-- catppuccin
vim.cmd.colorscheme("catppuccin")

-- noice
require("noice").setup({
	lsp = {
		progress = { enabled = false },
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
})

-- faster
require("faster").setup({
	behaviours = {
		bigfile = {
			on = true,
			features_disabled = {
				"matchparen",
				"lsp",
				"treesitter",
				"indent_blankline",
				"vimopts",
				"syntax",
				"filetype",
			},
			filesize = 2,
			pattern = "*",
			extra_patterns = {},
		},
		fastmacro = {
			on = true,
			features_disabled = { "lualine", "mini_clue" },
		},
	},
	features = {
		filetype = { on = true, defer = true },
		indent_blankline = { on = true, defer = false },
		lsp = { on = true, defer = false },
		lualine = { on = true, defer = false },
		matchparen = { on = true, defer = false },
		syntax = { on = true, defer = true },
		treesitter = { on = true, defer = false },
		vimopts = { on = true, defer = false },
	},
})

-- yanky
require("yanky").setup({ ring = { storage = "sqlite" } })
vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "yank" })
vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", { desc = "paste after cursor" })
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", { desc = "paste before cursor" })
vim.keymap.set("n", "gp", "<Plug>(YankyGPutAfter)", { desc = "paste at end of file" })
vim.keymap.set("n", "gP", "<Plug>(YankyGPutBefore)", { desc = "paste at head of file" })
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", { desc = "cycle forward" })
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)", { desc = "cycle backward" })

-- lualine
require("lualine").setup({
	options = { theme = "onedark" },
	sections = {
		lualine_x = { "aerial" },
		lualine_z = {
			{
				function()
					return require("opencode").statusline()
				end,
			},
		},
	},
})

-- bufferline
require("bufferline").setup({ options = { separator_style = "slant" } })

-- which-key
require("which-key").setup()
vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "exit" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "save current changed" })
vim.keymap.set("n", "<leader>wq", "<cmd>w<CR><cmd>q<CR>", { desc = "save and exit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "force exit without save" })

-- fzf-lua
require("fzf-lua").setup()

-- project
require("project_nvim").setup({
	silent_chdir = true,
	snacks = {
		enabled = true,
		opts = {
			sort = "newest",
			hidden = false,
			title = "Select Project",
			layout = "select",
		},
	},
	fzf_lua = { enabled = true },
})

-- snacks
require("snacks").setup({
	animate = { enabled = true, duration = 20, easing = "linear" },
	bigfile = { enabled = true },
	dashboard = { enabled = true },
	explorer = { enabled = true },
	indent = { enabled = true, only_current = true, only_scope = true },
	input = {},
	notifier = { enabled = true },
	picker = {
		enabled = true,
		actions = {
			opencode_send = function(...)
				return require("opencode").snacks_picker_send(...)
			end,
		},
		win = {
			input = {
				keys = {
					["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
				},
			},
		},
	},
	quickfile = { enabled = true },
	scope = { enabled = true },
	statuscolumn = { enabled = true },
	scroll = { enabled = true },
	words = { enabled = true },
	terminal = { enabled = true },
})

_G.dd = function(...)
	Snacks.debug.inspect(...)
end
_G.bt = function()
	Snacks.debug.backtrace()
end
if vim.fn.has("nvim-0.11") == 1 then
	vim._print = function(_, ...)
		dd(...)
	end
else
	vim.print = _G.dd
end

Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
	.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
	:map("<leader>uc")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle
	.option("background", { off = "light", on = "dark", name = "Dark Background" })
	:map("<leader>ub")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.dim():map("<leader>uD")

-- snacks keymaps
local map = vim.keymap.set
map("n", "<leader><space>", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })
map("n", "<leader>,", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", "<leader>/", function()
	Snacks.picker.grep()
end, { desc = "Grep" })
map("n", "<leader>:", function()
	Snacks.picker.command_history()
end, { desc = "Command History" })
map("n", "<leader>n", function()
	Snacks.picker.notifications()
end, { desc = "Notification History" })
map("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "File Explorer" })
map("n", "<leader>fc", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })
map("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })
map("n", "<leader>fg", function()
	Snacks.picker.git_files()
end, { desc = "Find Git Files" })
map("n", "<leader>fp", function()
	Snacks.picker.projects()
end, { desc = "Projects" })
map("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent" })
map("n", "<leader>gb", function()
	Snacks.picker.git_branches()
end, { desc = "Git Branches" })
map("n", "<leader>gl", function()
	Snacks.picker.git_log()
end, { desc = "Git Log" })
map("n", "<leader>gL", function()
	Snacks.picker.git_log_line()
end, { desc = "Git Log Line" })
map("n", "<leader>gs", function()
	Snacks.picker.git_status()
end, { desc = "Git Status" })
map("n", "<leader>gS", function()
	Snacks.picker.git_stash()
end, { desc = "Git Stash" })
map("n", "<leader>gd", function()
	Snacks.picker.git_diff()
end, { desc = "Git Diff (Hunks)" })
map("n", "<leader>gf", function()
	Snacks.picker.git_log_file()
end, { desc = "Git Log File" })
map("n", "<leader>sb", function()
	Snacks.picker.lines()
end, { desc = "Buffer Lines" })
map("n", "<leader>sB", function()
	Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })
map({ "n", "x" }, "<leader>sw", function()
	Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })
map("n", '<leader>s"', function()
	Snacks.picker.registers()
end, { desc = "Registers" })
map("n", "<leader>s/", function()
	Snacks.picker.search_history()
end, { desc = "Search History" })
map("n", "<leader>sa", function()
	Snacks.picker.autocmds()
end, { desc = "Autocmds" })
map("n", "<leader>sC", function()
	Snacks.picker.commands()
end, { desc = "Commands" })
map("n", "<leader>sd", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
map("n", "<leader>sD", function()
	Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", function()
	Snacks.picker.help()
end, { desc = "Help Pages" })
map("n", "<leader>sH", function()
	Snacks.picker.highlights()
end, { desc = "Highlights" })
map("n", "<leader>si", function()
	Snacks.picker.icons()
end, { desc = "Icons" })
map("n", "<leader>sj", function()
	Snacks.picker.jumps()
end, { desc = "Jumps" })
map("n", "<leader>sk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })
map("n", "<leader>sl", function()
	Snacks.picker.loclist()
end, { desc = "Location List" })
map("n", "<leader>sm", function()
	Snacks.picker.marks()
end, { desc = "Marks" })
map("n", "<leader>sM", function()
	Snacks.picker.man()
end, { desc = "Man Pages" })
map("n", "<leader>sp", function()
	Snacks.picker.lazy()
end, { desc = "Search for Plugin Spec" })
map("n", "<leader>sq", function()
	Snacks.picker.qflist()
end, { desc = "Quickfix List" })
map("n", "<leader>sR", function()
	Snacks.picker.resume()
end, { desc = "Resume" })
map("n", "<leader>su", function()
	Snacks.picker.undo()
end, { desc = "Undo History" })
map("n", "<leader>uC", function()
	Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })
map("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
map("n", "gD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })
map("n", "gr", function()
	Snacks.picker.lsp_references()
end, { desc = "References", nowait = true })
map("n", "gI", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })
map("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })
map("n", "gai", function()
	Snacks.picker.lsp_incoming_calls()
end, { desc = "C[a]lls Incoming" })
map("n", "gao", function()
	Snacks.picker.lsp_outgoing_calls()
end, { desc = "C[a]lls Outgoing" })
map("n", "<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })
map("n", "<leader>sS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })
map("n", "<leader>z", function()
	Snacks.zen()
end, { desc = "Toggle Zen Mode" })
map("n", "<leader>Z", function()
	Snacks.zen.zoom()
end, { desc = "Toggle Zoom" })
map("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function()
	Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>cR", function()
	Snacks.rename.rename_file()
end, { desc = "Rename File" })
map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })
map("n", "<leader>un", function()
	Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })
map({ "n", "t" }, "<c-/>", function()
	Snacks.terminal()
end, { desc = "Toggle Terminal" })
map({ "n", "t" }, "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
map({ "n", "t" }, "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

-- nvim-surround
require("nvim-surround").setup()

-- nvim-autopairs
require("plugin.autopairs")

-- hop
require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })

-- Trans
vim.keymap.set({ "n", "x" }, "<leader>te", "<Cmd>Translate<CR>", { desc = "Translate" })
vim.keymap.set("n", "<leader>ti", "<Cmd>TranslateInput<CR>", { desc = "Translate From Input" })

-- spectre
require("spectre").setup()
vim.keymap.set("n", "<leader>S", function()
	require("spectre").open()
end, { desc = "Open Spectre" })
vim.keymap.set({ "n", "v" }, "<leader>sw", function()
	require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word" })
vim.keymap.set("n", "<leader>sp", function()
	require("spectre").open_file_search({ select_word = true })
end, { desc = "Search on current file" })

-- treesitter
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter.setup", {}),
	callback = function(args)
		local buf = args.buf
		local filetype = args.match
		local language = vim.treesitter.language.get_lang(filetype) or filetype
		if not vim.treesitter.language.add(language) then
			return
		end
		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.treesitter.start(buf, language)
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- mason
require("mason").setup()

-- blink.cmp
require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = { nerd_font_variant = "mono" },
	completion = {
		documentation = { auto_show = false },
		ghost_text = { enabled = true },
		menu = {
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", gap = 1 },
					{ "source_name" },
				},
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
	cmdline = {
		completion = { menu = { auto_show = true } },
	},
})

-- tiny-inline-diagnostic
require("tiny-inline-diagnostic").setup({
	options = {
		multilines = { enabled = true },
		show_source = { enabled = true },
	},
})
vim.diagnostic.config({ virtual_text = false })

-- Comment
require("Comment").setup({})

-- gitsigns
require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 500,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
})

-- conform
require("plugin.conform")

-- nvim-lint
require("plugin.nvim-lint")

-- render-markdown
require("render-markdown").setup({
	completions = { lsp = { enabled = true } },
	render_modes = true,
	latex = { enabled = false },
})

-- opencode
vim.g.opencode_opts = {
	start = false,
	port = 41234,
}
vim.o.autoread = true
map({ "n", "x" }, "<C-a>", function()
	require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode…" })
map({ "n", "x" }, "<C-x>", function()
	require("opencode").select()
end, { desc = "Execute opencode action…" })
map({ "n", "t" }, "<C-.>", function()
	require("opencode").toggle()
end, { desc = "Toggle opencode" })
map({ "n", "x" }, "go", function()
	return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })
map("n", "goo", function()
	return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })
map("n", "<S-C-u>", function()
	require("opencode").command("session.half.page.up")
end, { desc = "Scroll opencode up" })
map("n", "<S-C-d>", function()
	require("opencode").command("session.half.page.down")
end, { desc = "Scroll opencode down" })
map("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
map("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })

if vim.g.neovide then
	require("neovide")
end
