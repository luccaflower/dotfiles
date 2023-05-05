local M = {}

local root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'pom.xml' },
  { upward = true })[1])
local function notify(cmd)
  return function(_, exit_code, _)
    if exit_code == 0 then
      vim.notify(cmd .. ' OK')
    else
      vim.notify(cmd .. ' failed!', vim.log.levels.ERROR)
    end
  end
end

local function mvn_command(cmd, on_exit)
  vim.fn.jobstart('mvn ' .. cmd, {
    cwd = root_dir,
    stderr_buffered = true,
    on_exit = on_exit,
    on_stderr = function(_, data, name)
      vim.api.nvim_err_writeln(name .. ': ' .. table.concat(data, "\n"))
    end
  })
end

function M.mvn_javadoc()
  mvn_command(
    'dependency:resolve -Dclassifier=javadoc',
    notify('javadoc'))
end

function M.mvn_sources()
  mvn_command('dependency:sources', notify('sources'))
end

function M.mvn_test()
  mvn_command(
    'clean test',
    notify('test'))
end

function M.mvn_package()
  mvn_command('clean test', notify('test'))
end

function M.mvn_verify()
  mvn_command('clean verify', notify('verify'))
end

function M.add_commands()
  vim.api.nvim_create_user_command('MvnJavaDoc', M.mvn_javadoc, {})
  vim.api.nvim_create_user_command('MvnSources', M.mvn_sources, {})
  vim.api.nvim_create_user_command('MvnTest', M.mvn_test, {})
  vim.api.nvim_create_user_command('MvnPackage', M.mvn_package, {})
  vim.api.nvim_create_user_command('MvnVerify', M.mvn_verify, {})
end

return M
