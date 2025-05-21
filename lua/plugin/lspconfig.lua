-- Setup language servers.
local lspconfig = require("lspconfig")

local lsp_servers = {
	clangd = {
		cmd = { "clangd", "--header-insertion=never", "--background-index" },
	},
	pylsp = {},
	bashls = {},
	jsonls = {},
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
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
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
	for server, config in pairs(lsp_servers) do
		lspconfig[server].setup({
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			cmd = config.cmd,
			settings = config.settings,
		})
	end
elseif vim.tbl_get(require("lazy.core.config").plugins, "coq_nvim") then
	for server, config in pairs(lsp_servers) do
		lspconfig[server].setup({
			require("coq").lsp_ensure_capabilities(),
			cmd = config.cmd,
			settings = config.settings,
		})
	end
else
	vim.print("Error, not enable complete plugin")
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
