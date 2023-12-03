-- treesitter
require 'nvim-treesitter.configs'.setup {
  auto_install = true,
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
  rainbow = {
    enable = true,
    extended_mode = true,     -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil,     -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
--Java options
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  callback = function()
    vim.api.nvim_set_hl(0, "@interface", { link = "Structure" })
    vim.api.nvim_set_hl(0, "@record", { link = "Structure" })
  end,
  group = java,
})
