require("lazy").setup({
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "darker",
				ending_tildes = true,
			})
			require("onedark").load()
		end,
	},
	{
		"akinsho/toggleterm.nvim",
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
				border = "double",
				title_pos = "center",
			},
		},
		keys = {
			{
				"<leader>ft",
				"<Cmd>ToggleTerm direction=float<CR>",
				mode = { "n", "t" },
				desc = "ToggleTerm Toggle",
			},
			{
				"<leader>fg",
				"<Cmd>lua require('toggleterm.terminal').Terminal:new({cmd='gitui -t mocha.ron', hidden=true, direction='float'}):toggle()<CR>",
				mode = { "n", "t" },
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
			sections = {
				lualine_x = { "aerial" },
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = { options = { separator_style = "slant" } }, -- enable bufferline
	},
	{
		"stevearc/oil.nvim",
		dependencies = "echasnovski/mini.icons",
		config = function()
			require("oil").setup({
				deleted_to_trash = true,
				view_options = {
					show_hidden = true,
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			"benfowler/telescope-luasnip.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-hop.nvim",
			"norcalli/nvim-terminal.lua",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		keys = {
			{ "<leader>tf", mode = { "n", "x" }, "<Cmd>Telescope fd<CR>", desc = "Telescope Find files" },
			{ "<leader>tl", mode = { "n", "x" }, "<Cmd>Telescope file_browser<CR>", desc = "Telescope File Browser" },
			{ "<leader>tw", mode = { "n", "x" }, "<Cmd>Telescope grep_string<CR>", desc = "Telescope Find Words" },
			{ "<leader>tb", mode = { "n", "x" }, "<Cmd>Telescope buffers<CR>", desc = "Telescope Find Words" },
			{ "<leader>th", mode = { "n", "x" }, "<Cmd>Telescope help_tags<CR>", desc = "Telescope Find Help" },
			{ "<leader>tk", mode = { "n", "x" }, "<Cmd>Telescope keymaps<CR>", desc = "Telescope Find Keymap" },

			{ "gd", mode = { "n" }, "<Cmd>Telescope lsp_definitions<CR>", desc = "Telescope Goto definitions" },
			{ "gr", mode = { "n" }, "<Cmd>Telescope lsp_references<CR>", desc = "Telescope Goto references" },
			{ "gi", mode = { "n" }, "<Cmd>Telescope lsp_implementations<CR>", desc = "Telescope Goto implementations" },
			{
				"gt",
				mode = { "n" },
				"<Cmd>Telescope lsp_type_definitions<CR>",
				desc = "Telescope Goto type_definitions",
			},
		},
		config = function()
			require("plugin.telescope")
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
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
		"JuanZoran/Trans.nvim",
		build = function()
			require("Trans").install()
		end,
		lazy = true,
		keys = {
			{ "<leader>te", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = " Translate" },
			{ "<leader>ti", "<Cmd>TranslateInput<CR>", desc = " Translate From Input" },
		},
		dependencies = { "kkharji/sqlite.lua" },
		config = true,
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>S", mode = { "n" }, "<Cmd>lua require('spectre').open()<CR>", desc = "Open Spectre" },
			{
				"<leader>sw",
				mode = { "n", "v" },
				"<Cmd>lua require('spectre').open_visual({select_word=true})<CR>",
				desc = "Search current word",
			},
			{
				"<leader>sp",
				mode = { "n" },
				"<Cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
				desc = "Search on current file",
			},
		},
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"chipsenkbeil/distant.nvim",
		branch = "v0.3",
		config = function()
			require("distant"):setup()
		end,
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
		"stevearc/aerial.nvim",
		opts = {
			backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
			layout = {
				default_direction = "prefer_left",
			},
			close_automatic_events = { "switch_buffer", "unfocus" },
			close_on_select = true,
			show_guides = true,
			filter_kind = false,
			-- {
			-- 	-- "Array",
			-- 	-- "Boolean",
			-- 	"Class",
			-- 	-- "Constant",
			-- 	"Constructor",
			-- 	"Enum",
			-- 	-- "EnumMember",
			-- 	-- "Event",
			-- 	-- "Field",
			-- 	-- "File",
			-- 	"Function",
			-- 	"Interface",
			-- 	-- "Key",
			-- 	"Method",
			-- 	"Module",
			-- 	-- "Namespace",
			-- 	-- "Null",
			-- 	-- "Number",
			-- 	-- "Object",
			-- 	-- "Operator",
			-- 	-- "Package",
			-- 	-- "Property",
			-- 	-- "String",
			-- 	"Struct",
			-- 	-- "TypeParameter",
			-- 	-- "Variable",
			-- },
			nav = {
				autojump = true,
				preview = true,
			},
		},
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
			require("plugin.lspconfig")
		end,
	},
	"tzachar/fuzzy.nvim",
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind.nvim",
			"petertriho/cmp-git",
			"saadparwaiz1/cmp_luasnip",
			"chrisgrieser/cmp_yanky",
			"lukas-reineke/cmp-rg",
			"tzachar/cmp-fuzzy-buffer",
			"tzachar/cmp-fuzzy-path",
		},
		config = function()
			require("plugin.cmp")
		end,
	},
	-- {
	-- 	"ms-jpq/coq_nvim",
	-- 	branch = "coq",
	-- 	dependencies = {
	-- 		-- 9000+ Snippets
	-- 		{ "ms-jpq/coq.artifacts", branch = "artifacts" },

	-- 		-- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
	-- 		-- Need to **configure separately**
	-- 		{ "ms-jpq/coq.thirdparty", branch = "3p" },
	-- 		-- - shell repl
	-- 		-- - nvim lua api
	-- 		-- - scientific calculator
	-- 		-- - comment banner
	-- 		-- - etc
	-- 	},
	-- 	init = function()
	-- 		vim.g.coq_settings = {
	-- 			auto_start = true,
	-- 		}
	-- 	end,
	-- 	config = function()
	-- 		require("plugin.coq")
	-- 	end,
	-- },
	{ "folke/neodev.nvim", opts = {} },
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},

	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				snippet_engine = "luasnip",
				languages = {
					["cpp.doxygen"] = require("neogen.configurations.cpp"),
					["c.doxygen"] = require("neogen.configurations.c"),
				},
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup({})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin.conform")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			require("plugin.nvim-lint")
		end,
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("render-markdown").setup({})
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"gbprod/yanky.nvim",
		opts = {},
	},
})
