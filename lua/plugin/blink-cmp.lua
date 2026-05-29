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

