-- Formatting policy:
--   * C files: auto-format on save ONLY if a .clang-format / _clang-format
--     config is found in the project (searched upward from the buffer).
--   * clang-format style resolution:
--       - project has .clang-format / _clang-format -> use it
--       - otherwise -> fall back to the Linux kernel style shipped with
--         this config (.clang-format-kernel)
--   * Everything else: no auto-format.
--   * Manual: <leader>cf formats the buffer (or selection in visual mode).

local kernel_style = vim.fn.stdpath("config") .. "/.clang-format-kernel"

local function clang_format_style(_, ctx)
	local filename = ctx.filename or ""
	if filename ~= "" and vim.fs.root(filename, { ".clang-format", "_clang-format" }) then
		return { "--style=file" }
	end
	return { "--style=file:" .. kernel_style }
end

require("conform").setup({
	format_after_save = function(bufnr)
		if vim.bo[bufnr].filetype ~= "c" then
			return
		end

		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if bufname == "" then
			return
		end

		local root = vim.fs.root(bufnr, { ".clang-format", "_clang-format" })
		if not root then
			return
		end

		return { timeout_ms = 500, lsp_fallback = true }
	end,
	formatters_by_ft = {
		c = { "clang-format" },
		lua = { "stylua" },
		python = { "ruff_organize_imports", "ruff_format" },
	},

	formatters = {
		-- NOTE: key must match the formatters_by_ft name exactly ("clang-format",
		-- with a dash) — conform looks up overrides by that name.
		["clang-format"] = {
			prepend_args = clang_format_style,
		},
	},
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
		timeout_ms = 500,
	})
end, { desc = "Format buffer" })
