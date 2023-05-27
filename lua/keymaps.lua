local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ';'

-- insert mode, fast move
map('i', '<C-k>', '<Up>', opts)
map('i', '<C-j>', '<Down>', opts)
map('i', '<C-h>', '<Left>', opts)
map('i', '<C-l>', '<Right>', opts)
map('i', '<C-a>', '<Home>', opts)
map('i', '<C-e>', '<End>', opts)

-- clipboard for system clipboard
map('v', '<leader>y', '\"+y', opts)
map('n', '<leader>p', '\"+p', opts)

-- Exit or Save
map('n', '<leader>q', ':q<CR>', opts)
map('n', '<leader>w', ':w<CR>', opts)
map('n', '<leader>wq', ':wa<CR>:q<CR>', opts)
map('n', '<leader>Q',  ':qa!<CR>', opts)

-- Move to sub windows
map('n', 'nw', '<C-W><C-W>', opts)
map('n', '<leader>lw', '<C-W>l', opts)
map('n', '<leader>hw', '<C-W>h', opts)
map('n', '<leader>kw', '<C-W>k', opts)
map('n', '<leader>jw', '<C-W>j', opts)
