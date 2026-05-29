local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

local lsp_servers = {
	clangd = {
		cmd = { mason_bin .. "/clangd", "--header-insertion=never", "--background-index" },
	},
	pylsp = {
		cmd = { mason_bin .. "/pylsp" },
	},
	bashls = {
		cmd = { mason_bin .. "/bash-language-server", "start" },
	},
	jsonls = {
		cmd = { mason_bin .. "/vscode-json-language-server", "--stdio" },
	},
	typos_lsp = {
		cmd = { mason_bin .. "/typos-lsp" },
	},
	rust_analyzer = {
		cmd = { mason_bin .. "/rust-analyzer" },
		settings = {
			["rust-analyzer"] = {},
		},
	},
	lua_ls = {
		cmd = { mason_bin .. "/lua-language-server" },
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim", "require" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
}

for server, conf in pairs(lsp_servers) do
	vim.lsp.config(server, {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
		cmd = conf.cmd,
		settings = conf.settings,
	})
	vim.lsp.enable(server)
end