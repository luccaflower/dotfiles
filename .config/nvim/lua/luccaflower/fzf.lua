--function! s:list_cmd()
--  let base = fnamemodify(expand('%'), ':h:.:S')
--  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
--endfunction

local function list_cmd()
  local base = vim.fn.fnamemodify(vim.fn.expand('%'), ':h:.:S')
  return 'fd --type file --follow' ..
      (base == '.' and '' or ' | proximity-sort ' .. vim.fn.shellescape(vim.fn.expand('%')))
end

require("fzf-lua").setup({})
vim.keymap.set("n", "<leader>o",
  function() require("fzf-lua").files({ cmd = list_cmd() }) end,
  { silent = true, desc = "Files" })
vim.keymap.set("n", "<leader>s",
  "<cmd>lua require('fzf-lua').grep()<CR><CR>",
  { silent = true, desc = "Search files" })
vim.keymap.set("n", "<leader>b", function() require("fzf-lua").lines() end,
  { silent = true, desc = "Search buffers" })
