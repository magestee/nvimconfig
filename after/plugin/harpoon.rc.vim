lua << EOF
-- Importing the required modules
local harpoon = require('harpoon')
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

-- Initialize Harpoon
harpoon.setup({
    -- Configuration options
    -- For example, set the save file for Harpoon's marks.
    -- This is optional; if not set, the default will be used.
    save_file = vim.fn.stdpath('data') .. '/harpoon.json',
    -- You can specify other configuration options here.
})

-- Key mappings for Harpoon commands

-- Mark the current file or toggle the mark if already marked
vim.api.nvim_set_keymap('n', ';m', '<cmd>lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })

-- Open the Harpoon UI to navigate marked files
vim.api.nvim_set_keymap('n', ';f', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })

-- Navigate to the next and previous marks
vim.api.nvim_set_keymap('n', ';l', '<cmd>lua require("harpoon.ui").nav_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ';h', '<cmd>lua require("harpoon.ui").nav_prev()<CR>', { noremap = true, silent = true })

EOF
