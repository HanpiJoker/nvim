vim.g.neovide_theme = "auto"

vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		if vim.fn.argc() == 0 then
			vim.defer_fn(function()
				require("telescope.builtin").oldfiles()
			end, 100)
		end
	end,
})
