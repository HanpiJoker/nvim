-- Setup language servers.
local lsp_servers = {
	clangd = {
		cmd = { "clangd", "--header-insertion=never", "--background-index" },
	},
	-- ruff: lint + format only, hover is handled by pylsp
	ruff = {
		on_attach = function(client, _)
			client.server_capabilities.hoverProvider = false
		end,
	},
	-- pylsp: completion, goto-definition, hover docs only
	pylsp = {
		on_attach = function(client, _)
			-- formatting is handled by ruff
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end,
		settings = {
			pylsp = {
				plugins = {
					-- lint (handled by ruff)
					pycodestyle = { enabled = false },
					pyflakes = { enabled = false },
					mccabe = { enabled = false },
					pylint = { enabled = false },
					flake8 = { enabled = false },
					ruff = { enabled = false },
					pylsp_mypy = { enabled = false },
					-- format (handled by ruff)
					autopep8 = { enabled = false },
					yapf = { enabled = false },
					black = { enabled = false },
					-- keep jedi for completion / definition / hover / signature
					jedi_completion = { enabled = true },
					jedi_definition = { enabled = true },
					jedi_hover = { enabled = true },
					jedi_references = { enabled = true },
					jedi_signature_help = { enabled = true },
					jedi_symbols = { enabled = true },
				},
			},
		},
	},
	bashls = {},
	jsonls = {},
	typos_lsp = {},
	-- markdown: 目录大纲(;ss)、链接跳转(gd)、反向引用(gr)
	marksman = {},
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
			on_attach = conf.on_attach,
		})

		vim.lsp.enable(server)
	end
elseif vim.tbl_get(require("lazy.core.config").plugins, "coq_nvim") then
	for server, conf in pairs(lsp_servers) do
		vim.lsp.config(server, {
			require("coq").lsp_ensure_capabilities(),
			cmd = conf.cmd,
			settings = conf.settings,
			on_attach = conf.on_attach,
		})

		vim.lsp.enable(server)
	end
elseif vim.tbl_get(require("lazy.core.config").plugins, "blink.cmp") then
	for server, conf in pairs(lsp_servers) do
		vim.lsp.config(server, {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
			cmd = conf.cmd,
			settings = conf.settings,
			on_attach = conf.on_attach,
		})

		vim.lsp.enable(server)
	end
else
	vim.print("Error, not enable complete plugin")
end
