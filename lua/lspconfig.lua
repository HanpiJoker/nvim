-- Setup language servers.
local lsp_servers = {
	clangd = {
		cmd = { "clangd", "--header-insertion=never", "--background-index" },
	},
	pylsp = {},
	bashls = {},
	jsonls = {},
	typos_lsp = {},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {},
		},
	},
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim", "require" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	},
}

if vim.tbl_get(require("lazy.core.config").plugins, "nvim-cmp") then
	for server, conf in pairs(lsp_servers) do
		vim.lsp.config(server, {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			cmd = conf.cmd,
			settings = conf.settings,
		})

		vim.lsp.enable(server)
	end
elseif vim.tbl_get(require("lazy.core.config").plugins, "coq_nvim") then
	for server, conf in pairs(lsp_servers) do
		vim.lsp.config(server, {
			require("coq").lsp_ensure_capabilities(),
			cmd = conf.cmd,
			settings = conf.settings,
		})

		vim.lsp.enable(server)
	end
elseif vim.tbl_get(require("lazy.core.config").plugins, "blink.cmp") then
	for server, conf in pairs(lsp_servers) do
		vim.lsp.config(server, {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
			cmd = conf.cmd,
			settings = conf.settings,
		})

		vim.lsp.enable(server)
	end
else
	vim.print("Error, not enable complete plugin")
end
