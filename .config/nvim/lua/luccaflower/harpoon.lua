local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
vim.keymap.set('n', '<C-S-A-D-n>', function() mark.toggle_file() end,
  { desc = "Harpoon this file" })
vim.keymap.set('n', '<C-S-A-D-t>', function() ui.toggle_quick_menu() end,
  { desc = "Toggle harpoon menu" })
vim.keymap.set('n', '<C-S-A-D-l>', function() ui.nav_next() end,
  { desc = "Navigate to next harpoon" })
vim.keymap.set('n', '<C-S-A-D-h>', function() ui.nav_prev() end,
  { desc = "Navigate to previous harpoon" })
