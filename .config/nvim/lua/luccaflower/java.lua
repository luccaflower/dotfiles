local M = {}
local function root_dir()
  return vim
    .fs
    .dirname(vim.fs.find({ 'java' }, { type = 'directory' })[1]) .. '/java/'
  end
local function current_dir()
  return vim.fs.dirname(vim.api.nvim_buf_get_name(0)) .. '/'
end

function M.java_print_root()
  print(root_dir())
end

local class_template = [[
package {{package}};

class {{class}} {

}
]]

local function trim_prefix(prefix, string)
  return (string:sub(0, #prefix) == prefix) and string:sub(#prefix + 1) or string
end

function M.new_class()
  vim.ui.input(
    { prompt = "New class: " .. current_dir() },
    function(name)
      local file = current_dir() .. name
      local buf = vim.api.nvim_create_buf(true, {})
      vim.api.nvim_buf_set_name(buf, file .. '.java')
      vim.api.nvim_buf_set_option(buf, 'buftype', '')
      vim.api.nvim_buf_set_option(buf, 'filetype', 'java')
      vim.api.nvim_buf_set_option(buf, 'modifiable', true)
      vim.api.nvim_set_current_buf(buf)
      local package = string.gsub(vim.fs.dirname(trim_prefix(root_dir(), file)),
        '/', '.')
      local insertion = class_template
          :gsub("{{package}}", package)
          :gsub("{{class}}", name)
      local lines = vim.split(insertion, '\n')
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end)
end

function M.add_commands()
  vim.api.nvim_create_user_command('JavaSrcRoot', M.java_print_root, {})
  vim.api.nvim_create_user_command('JavaNewClass', M.new_class, {})
end

return M
