local hop = require('hop')
hop.setup({
  quit_key = '<leader>'
})
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })
vim.keymap.set('', '<A-f>', function()
  hop.hint_words({ direction = directions.AFTER_CURSOR })
end, { remap = true })
vim.keymap.set('', '<A-F>', function()
  hop.hint_words({ direction = directions.BEFORE_CURSOR })
end, { remap = true })
vim.keymap.set('', '<A-t>', function()
  hop.hint_words({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
end, { remap = true })
vim.keymap.set('', '<A-T>', function()
  hop.hint_words({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
end, { remap = true })
