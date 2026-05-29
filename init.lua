vim.loader.enable()

require("options")
require("plugins")
require("lspconfig")

if vim.g.neovide then
	require("neovide")
end