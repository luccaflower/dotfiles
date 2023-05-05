local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
vim.keymap.set('n', '<leader>hg',
  function()
    return '<cmd>lua require("harpoon.ui").nav_file(' ..
        vim.v.count .. ')<cr>'
  end,
  {
    expr = true,
    desc = "Harpoon to mark <count>"
  })
vim.keymap.set('n', '<leader>hn', function() mark.toggle_file() end,
  { desc = "Harpoon this file" })
vim.keymap.set('n', '<leader>ht', function() ui.toggle_quick_menu() end,
  { desc = "Toggle harpoon menu" })
vim.keymap.set('n', '<leader>hh', function() ui.nav_next() end,
  { desc = "Navigate to next harpoon" })
vim.keymap.set('n', '<leader>hH', function() ui.nav_prev() end,
  { desc = "Navigate to previous harpoon" })
vim.keymap.set('n', '<leader>H', function() ui.nav_prev() end,
  { desc = "Navigate to previous harpoon" })
