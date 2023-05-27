local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>rf', builtin.find_files)
vim.keymap.set('n', '<leader>rg', builtin.live_grep)
vim.keymap.set('n', '<leader>rb', builtin.buffers)
vim.keymap.set('n', '<leader>rh', builtin.help_tags)
vim.keymap.set('n', '<leader>rk', builtin.keymaps)

require("telescope").load_extension("lazygit")
