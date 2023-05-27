local fterm = require("FTerm")

-- Create Custom Terminal

local btop = fterm:new({
    ft = 'fterm_btop',
    cmd = "btop",
    dimensions = {
        height = 0.6,
        width = 0.6
    }
})

vim.keymap.set('n', '<leader>fb', function()
    btop:toggle()
end)
