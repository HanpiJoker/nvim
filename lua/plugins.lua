require("lazy").setup({
	-- basic plugins
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup()
			vim.notify = require("notify")
		end,
	},
	{
		"gbprod/yanky.nvim",
		dependencies = { "kkharji/sqlite.lua" },
		opts = {
			ring = {
				history_length = 100,
				storage = "sqlite",
				sync_with_numbered_registers = true,
				cancel_event = "update",
				ignore_registers = { "_" },
				update_register_on_cycle = false,
			},
			picker = {
				select = {
					action = nil,
				},
				telescope = {
					use_default_mappings = true,
					mappings = nil,
				},
			},
			system_clipboard = {
				sync_with_ring = true,
			},
			highlight = {
				on_put = true,
				on_yank = true,
				timer = 200,
			},
		},
		keys = {
			{
				"y",
				"<Plug>(YankyYank)",
				mode = { "n", "x" },
				desc = "yank",
			},
			{
				"<leader>y",
				"<Cmd>lua require('telescope').extensions.yank_history.yank_history()<CR>",
				mode = { "n", "x" },
				desc = "yank",
			},
			{
				"p",
				"<Plug>(YankyPutAfter)",
				mode = { "n" },
				desc = "paste after cursor",
			},
			{
				"P",
				"<Plug>(YankyPutBefore)",
				mode = { "n" },
				desc = "paste before cursor",
			},
			{
				"gp",
				"<Plug>(YankyGPutAfter)",
				mode = { "n" },
				desc = "paste at end of file",
			},
			{
				"gP",
				"<Plug>(YankyGPutBefore)",
				mode = { "n" },
				desc = "paste at head of file",
			},
			{
				"<c-n>",
				"<Plug>(YankyCycleForward)",
				mode = { "n" },
				desc = "paste at end of file",
			},
			{
				"<c-p>",
				"<Plug>(YankyCycleBackward)",
				mode = { "n" },
				desc = "paste at head of file",
			},
		},
	},
	---- float terminal plugins
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
				"<Cmd>lua require('toggleterm.terminal').Terminal:new({cmd='gitui -t catppuccin-mocha.ron', hidden=true, direction='float'}):toggle()<CR>",
				mode = { "n", "t" },
				desc = "ToggleTerm Toggle GitUI",
			},
		},
	},
	-- lualine for status line
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
	-- bufferline for buffer tab line
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = { options = { separator_style = "slant" } }, -- enable bufferline
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
		"smoka7/hop.nvim",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
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

	---- LSP Plugins
	{
		"nvim-treesitter/nvim-treesitter", -- Syntax Highlight
		build = ":TSUpdate",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("treesitter-context").setup()
				end,
			},
		},
		config = function()
			require("plugin.treesitter")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = false, -- neo-tree will lazily load itself
		opts = {
			-- fill any relevant options here
		},
		keys = {
			{
				"<leader>ff",
				mode = { "n" },
				"<Cmd>Neotree<CR>",
				desc = "Toggle File Tree",
			},
		},
	},
	{
		"stevearc/aerial.nvim",
		keys = {
			{
				"<leader>fo",
				mode = { "n" },
				"<Cmd>AerialToggle!<CR>",
				desc = "Toggle Aerial Outline",
			},
		},
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
		version = "1.x",
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
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "default" },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
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
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 500,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
			})
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
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("render-markdown").setup({
				render_modes = { "n", "c", "i", "v" },
			})
		end,
	},
})
