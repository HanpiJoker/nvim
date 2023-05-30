require('lazy').setup({
	{
		'olimorris/onedarkpro.nvim',
		lazy = false, priority = 1000,
		config = function()
			vim.cmd([[colorscheme onedark]])
		end

	},
	{
		'numToStr/FTerm.nvim',
		lazy = true,
		opts = {
			boarder = 'double'
		},
		keys = {
			{ '<leader>ft', '<CMD>lua require(\'FTerm\').toggle()<CR>', mode = 'n', desc = 'FloatTerm Toggle' },
			{ '<leader>ft', '<C-\\><C-n><CMD>lua require(\'FTerm\').toggle()<CR>', mode = 't', desc = 'FloatTerm Toggle' },
		},
		config = function()
			require('plugin.fterm')
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {
			options = { theme = 'onedark' }
		},
	},
	{
		'akinsho/bufferline.nvim',
		version = '*', dependencies = 'nvim-tree/nvim-web-devicons',
		opts = { options = { separator_style = 'slant' } }, -- enable bufferline
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
		}
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = 'nvim-lua/plenary.nvim',
		config = function()
			require('plugin.telescope')
		end
	},
	{
		'kylechui/nvim-surround',
		version = '*', -- Use for stability; omit to use `main` branch for the latest features
		event = 'VeryLazy',
		config = function()
			require('nvim-surround').setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		'windwp/nvim-autopairs',
		config = function()
			require('plugin.autopairs')
		end
	},
	{
		'nvim-tree/nvim-tree.lua',
		keys = {
			{ '<leader>fl', '<CMD>:NvimTreeToggle<CR>', desc = 'File Explorer Toggle' }
		},
		config = function()
			require('nvim-tree').setup({
				sort_by = 'case_sensitive',
				view = {
					width = 30,
					side = 'right',
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})
		end
	},

	---- LSP Plugins
	{
		'nvim-treesitter/nvim-treesitter', -- Syntax Highlight
		build = ':TSUpdate',
		config = function()
			require('plugin.treesitter')
		end
	},
	{
		'simrat39/symbols-outline.nvim',
		keys = {
			{ '<leader>vt', '<CMD>:SymbolsOutline<CR>', desc = 'Symbol Outline Toggle' }
		},
		config = function()
			require('symbols-outline').setup({
				position = 'left',
				width = 20,
				auto_close = true,
				auto_preview = true,
			})
		end
	},
	{
		'williamboman/mason.nvim',
		build = ':MasonUpdate',
		config = function()
			require('mason').setup()
		end
	},
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require('mason-lspconfig').setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "jsonls" },
			})
		end
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			require('plugin.mason_lsp')
		end
	},
	'hrsh7th/cmp-nvim-lsp', -- { name = nvim_lsp }
	'hrsh7th/cmp-buffer',   -- { name = 'buffer' },
	'hrsh7th/cmp-path',     -- { name = 'path' }
	'hrsh7th/cmp-cmdline',  -- { name = 'cmdline' }
	{
		'hrsh7th/nvim-cmp',
		config = function()
			require('plugin.cmp')
		end
	},
	{
		'L3MON4D3/LuaSnip',
		build = "make install_jsregexp",
		dependencies = { 'rafamadriz/friendly-snippets' },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end
	},
	'saadparwaiz1/cmp_luasnip',
})
