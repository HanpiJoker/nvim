local cppcheck = require("lint").linters.cppcheck

cppcheck.args = {
	"--enable=warning,style,performance,information",
	function()
		if vim.bo.filetype == "cpp" then
			return "--language=c++"
		else
			return "--language=c"
		end
	end,
	"--inline-suppr",
	"--quiet",
	function()
		if vim.fn.isdirectory("build") == 1 then
			return "--cppcheck-build-dir=build"
		else
			return nil
		end
	end,
	"--template={file}:{line}:{column}: [{id}] {severity}: {message}",
	"--force",
}

require("lint").linters_by_ft = {
	lua = { "selene" },
	sh = { "shellcheck" },
	bash = { "shellcheck" },
	zsh = { "shellcheck" },
	rust = { "clippy" },
	c = { "cppcheck" },
}
require("lint").try_lint()

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
		if vim.fn.filereadable(".vale.ini") > 0 then
			require("lint").try_lint({ "vale" })
		end
	end,
})
