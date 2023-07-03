local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.load_extension('undo')

telescope.setup({
	extensions = {
		undo = {
			use_delta = true,
			use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
			side_by_side = false,
			diff_context_lines = vim.o.scrolloff,
			entry_format = "state #$ID, $STAT, $TIME",
			time_format = "",
			mappings = {
				i = {
					-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
					-- you want to replicate these defaults and use the following actions. This means
					-- installing as a dependency of telescope in it's `requirements` and loading this
					-- extension from there instead of having the separate plugin definition as outlined
					-- above.
					["<cr>"] = require("telescope-undo.actions").yank_additions,
					["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
					["<C-cr>"] = require("telescope-undo.actions").restore,
				},
			},
		},
	},
})

vim.keymap.set('n', '<leader>rf', builtin.find_files)
vim.keymap.set('n', '<leader>rg', builtin.grep_string)
vim.keymap.set('n', '<leader>rb', builtin.buffers)
vim.keymap.set('n', '<leader>rh', builtin.help_tags)
vim.keymap.set('n', '<leader>rk', builtin.keymaps)
vim.keymap.set('n', 'gd', builtin.lsp_definitions)
vim.keymap.set('n', 'gr', builtin.lsp_references)
vim.keymap.set('n', 'gi', builtin.lsp_implementations)
vim.keymap.set('n', 'gy', builtin.lsp_type_definitions)
