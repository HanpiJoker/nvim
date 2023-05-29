local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>rf', builtin.find_files)
vim.keymap.set('n', '<leader>rg', builtin.grep_string)
vim.keymap.set('n', '<leader>rb', builtin.buffers)
vim.keymap.set('n', '<leader>rh', builtin.help_tags)
vim.keymap.set('n', '<leader>rk', builtin.keymaps)
vim.keymap.set('n', 'gd', builtin.lsp_definitions)
vim.keymap.set('n', 'gr', builtin.lsp_references)
vim.keymap.set('n', 'gi', builtin.lsp_implementations)
vim.keymap.set('n', 'gy', builtin.lsp_type_definitions)


require('telescope').load_extension('lazygit')