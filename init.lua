local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local modules = {
	"options",
	"plugins",
	"lspconfig",
}

for key, value in pairs(modules) do
	package.loaded[value] = nil
	require(value)
end

if vim.g.neovide then
	require("neovide")
end

vim.cmd.colorscheme("catppuccin")
