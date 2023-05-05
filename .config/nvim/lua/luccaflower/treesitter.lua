--Java options
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  callback = function()
    vim.api.nvim_set_hl(0, "@interface", { link = "Structure" })
    vim.api.nvim_set_hl(0, "@record", { link = "Structure" })
  end,
  group = java,
})
