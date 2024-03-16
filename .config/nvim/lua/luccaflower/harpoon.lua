local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
vim.keymap.set('n', '<leader>hn', function() mark.toggle_file() end,
  { desc = "Harpoon this file" })
vim.keymap.set('n', '<leader>ht', function() ui.toggle_quick_menu() end,
  { desc = "Toggle harpoon menu" })
vim.keymap.set('n', '<leader>hh', function() ui.nav_next() end,
  { desc = "Navigate to next harpoon" })
vim.keymap.set('n', '<leader>hH', function() ui.nav_prev() end,
  { desc = "Navigate to previous harpoon" })
