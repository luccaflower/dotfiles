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

function Mvn_javadoc()
  mvn_command(
    'dependency:resolve -Dclassifier=javadoc',
    notify('javadoc'))
end

function Mvn_sources()
  mvn_command('dependency:sources', notify('sources'))
end

function Mvn_test()
  mvn_command(
    'clean test',
    notify('test'))
end

function Mvn_package()
  mvn_command('clean test', notify('test'))
end

function Mvn_verify()
  mvn_command('clean verify', notify('verify'))
end

vim.api.nvim_create_user_command('MvnJavaDoc', Mvn_javadoc, {})
vim.api.nvim_create_user_command('MvnSources', Mvn_sources, {})
vim.api.nvim_create_user_command('MvnTest', Mvn_test, {})
vim.api.nvim_create_user_command('MvnPackage', Mvn_package, {})
vim.api.nvim_create_user_command('MvnVerify', Mvn_verify, {})
