require("lazy").setup({
	{
		"olimorris/onedarkpro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme onedark]])
		end,
	},
	{
		'akinsho/toggleterm.nvim',
		opts = {
			start_in_insert = true,
			shade_terminals = false,
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			float_opts = {
				border = 'double',
				title_pos = 'center'
			},
		},
		keys = {
			{
				"<leader>ft",
				"<Cmd>ToggleTerm direction=float<CR>",
				mode = {"n", "t"},
				desc = "ToggleTerm Toggle",
			},
			{
				"<leader>fg",
				"<Cmd>lua require('toggleterm.terminal').Terminal:new({cmd='gitui -t mocha.ron', hidden=true, direction='float'}):toggle()<CR>",
				mode = {"n", "t"},
				desc = "ToggleTerm Toggle GitUI",
			},
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = { theme = "onedark" },
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = { options = { separator_style = "slant" } }, -- enable bufferline
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			"benfowler/telescope-luasnip.nvim",
		},
		config = function()
			require("plugin.telescope")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = 'make'
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = function()
			require("plugin.autopairs")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		keys = {
			{ "<leader>fl", "<Cmd>:NvimTreeToggle<CR>", desc = "File Explorer Toggle" },
		},
		config = function()
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					width = 30,
					side = "right",
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})
		end,
	},
	{
		"JuanZoran/Trans.nvim",
		build = function()
			require("Trans").install()
		end,
		lazy = true,
		keys = {
			{ "<leader>te", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = " Translate" },
			{ "<leader>tp", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = " Auto Play" },
			{ "<leader>ti", "<Cmd>TranslateInput<CR>", desc = " Translate From Input" },
		},
		dependencies = { "kkharji/sqlite.lua" },
		config = true,
	},
	{
		'nvim-pack/nvim-spectre',
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>S", mode = { "n" }, "<Cmd>lua require('spectre').open()<CR>", desc = "Open Spectre" },
			{ "<leader>sw", mode = { "n", "v" }, "<Cmd>lua require('spectre').open_visual({select_word=true})<CR>", desc = "Search current word" },
			{ "<leader>sp", mode = { "n" }, "<Cmd>lua require('spectre').open_file_search({select_word=true})<CR>", desc = "Search on current file" },
		},
		config = function()
			require("spectre").setup()
		end,
	},
	{
		'chipsenkbeil/distant.nvim',
		branch='v0.3',
		config = function()
			require('distant'):setup()
		end
	},

	---- LSP Plugins
	{
		"nvim-treesitter/nvim-treesitter", -- Syntax Highlight
		build = ":TSUpdate",
		config = function()
			require("plugin.treesitter")
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		lazy = true,
		keys = {
			{ "<leader>vt", "<Cmd>:SymbolsOutline<CR>", desc = "Symbol Outline Toggle" },
		},
		config = function()
			require("symbols-outline").setup({
				position = "left",
				width = 20,
				auto_close = true,
				auto_preview = true,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "jsonls", "bashls", "pylsp" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugin.mason_lsp")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
			"hrsh7th/cmp-buffer", -- { name = 'buffer' },
			"hrsh7th/cmp-path", -- { name = 'path' }
			"hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
			'onsails/lspkind.nvim',
			"petertriho/cmp-git",
		},
		config = function()
			require("plugin.cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	"saadparwaiz1/cmp_luasnip",
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},

	{
		"danymat/neogen",
		config = function ()
			require('neogen').setup({
				snippet_engine = "luasnip",
				languages = {
					['cpp.doxygen'] = require('neogen.configurations.cpp'),
					['c.doxygen'] = require('neogen.configurations.c')
				}
			})
		end,
	},
	{
		'numToStr/Comment.nvim',
		lazy = false,
		config = function ()
			require('Comment').setup({ })
		end
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function ()
			require('gitsigns').setup()
		end
	},
	{
		'ggandor/leap.nvim',
		dependencies = "tpope/vim-repeat",
		config = function ()
			require('leap').create_default_mappings()
		end
	},
})
