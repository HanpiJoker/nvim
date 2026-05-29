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
		if name == "blink.cmp" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("blink.cmp")
			end
			require("blink.cmp").build():wait(60000)
		end
	end,
})

-- colorscheme
vim.pack.add({ "https://github.com/catppuccin/nvim" })
vim.cmd.colorscheme("catppuccin")

-- dependencies
vim.pack.add({ "https://github.com/MunifTanjim/nui.nvim" })
vim.pack.add({ "https://github.com/kkharji/sqlite.lua" })
vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-context" })

-- ui
vim.pack.add({ "https://github.com/folke/noice.nvim" })
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

vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
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

vim.pack.add({ "https://github.com/akinsho/bufferline.nvim" })
require("bufferline").setup({ options = { separator_style = "slant" } })

vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("which-key").setup()
vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "exit" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "save current changed" })
vim.keymap.set("n", "<leader>wq", "<cmd>w<CR><cmd>q<CR>", { desc = "save and exit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "force exit without save" })

vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
require("fzf-lua").setup()

vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })
require("tiny-inline-diagnostic").setup({
	options = {
		multilines = { enabled = true },
		show_source = { enabled = true },
	},
})
vim.diagnostic.config({ virtual_text = false })

-- editing
vim.pack.add({ "https://github.com/gbprod/yanky.nvim" })
require("yanky").setup({ ring = { storage = "sqlite" } })
vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "yank" })
vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", { desc = "paste after cursor" })
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", { desc = "paste before cursor" })
vim.keymap.set("n", "gp", "<Plug>(YankyGPutAfter)", { desc = "paste at end of file" })
vim.keymap.set("n", "gP", "<Plug>(YankyGPutBefore)", { desc = "paste at head of file" })
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)", { desc = "cycle forward" })
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)", { desc = "cycle backward" })

vim.pack.add({ "https://github.com/pteroctopus/faster.nvim" })
require("plugin.faster")

vim.pack.add({ "https://github.com/kylechui/nvim-surround" })
require("nvim-surround").setup()

vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
require("plugin.autopairs")

vim.pack.add({ "https://github.com/smoka7/hop.nvim" })
require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })

vim.pack.add({ "https://github.com/numToStr/Comment.nvim" })
require("Comment").setup({})

vim.pack.add({ "https://github.com/nvim-pack/nvim-spectre" })
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

-- git
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
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

-- lsp & completion
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
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

vim.pack.add({ "https://github.com/mason/mason.nvim" })
require("mason").setup()

vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })

vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.pack.add({ { src = "https://github.com/saghen/blink.cmp" } })
vim.pack.add({ { src = "https://github.com/saghen/blink.lib" } })
require("plugin.blink-cmp")

-- formatting & linting
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("plugin.conform")

vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })
require("plugin.nvim-lint")

-- snacks (load before project, as project depends on it)
vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("plugin.snacks")

-- projects
vim.pack.add({ "https://github.com/DrKJeff16/project.nvim" })
require("project").setup({
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

-- markdown
vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })
require("render-markdown").setup({
	completions = { lsp = { enabled = true } },
	render_modes = true,
	latex = { enabled = false },
})

-- translate
vim.pack.add({ "https://github.com/JuanZoran/Trans.nvim" })
vim.keymap.set({ "n", "x" }, "<leader>te", "<Cmd>Translate<CR>", { desc = "Translate" })
vim.keymap.set("n", "<leader>ti", "<Cmd>TranslateInput<CR>", { desc = "Translate From Input" })

-- opencode
vim.pack.add({ "https://github.com/nickjvandyke/opencode.nvim" })
require("plugin.opencode")
