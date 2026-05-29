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