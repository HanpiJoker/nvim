-- Format synchronously on save

require("conform").setup({
	format_after_save = function(bufnr)
		local ignore_filetypes = { "sql", "java", "c", "cpp" }

		if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
			return
		end

		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end

		-- ...additional logic...
		return { timeout_ms = 500, lsp_fallback = true, async = true }
	end,
	formatters_by_ft = {
		c = { "clang-format" },
		lua = { "stylua" },
	},
})
