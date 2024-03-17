local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
vim.keymap.set('n', '<C-S-A-D-n>', function() mark.toggle_file() end,
  { desc = "Harpoon this file" })
vim.keymap.set('n', '<C-S-A-D-q>', function() ui.toggle_quick_menu() end,
  { desc = "Toggle harpoon menu" })
vim.keymap.set('n', '<C-S-A-D-l>', function() ui.nav_next() end,
  { desc = "Navigate to next harpoon" })
vim.keymap.set('n', '<C-S-A-D-h>', function() ui.nav_prev() end,
  { desc = "Navigate to previous harpoon" })
local function term()
  vim.ui.input({ prompt = "Terminal", default = "0" }, function(input)
    if input == nil then return end
    local term = tonumber(input)
    require("harpoon.term").gotoTerminal(term)
  end)
end
vim.keymap.set('n', '<C-S-A-D-t>', term, { desc = "Open terminal" })
