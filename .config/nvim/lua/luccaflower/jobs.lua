local api = vim.api
local M = {}
function M.create_job(cmd)
  return function()
    vim.fn.jobstart(cmd, {
      stderr_buffered = true,
      on_stderr = function(_, data)
        vim.notify(data, vim.log.levels.ERROR)
      end,
    })
  end
end

function M.create_auto_job(event, cmd)
  api.nvim_create_autocmd(event, { callback = M.create_job(cmd) })
end

vim.keymap.set('n', '<leader>j', function()
    vim.ui.input({ prompt = "Command: " }, function(input)
      if input == nil then return end
      M.create_auto_job({ 'BufWritePost' }, input)
    end)
  end,
  { noremap = true, silent = true, desc = "Create on-write job" })
return M
