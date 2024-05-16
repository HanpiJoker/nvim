local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		require("none-ls.diagnostics.cpplint"),
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.formatting.clang_format,
	}
})
