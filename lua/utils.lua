local fn = vim.fn

-- inspect something
function _G.inspect(item)
  vim.pretty_print(item)
end

local M = {}

function M.executable(name)
  if fn.executable(name) > 0 then
    return true
  end

  return false
end

--- Create a dir if it does not exist
function M.may_create_dir(dir)
  local res = fn.isdirectory(dir)

  if res == 0 then
    fn.mkdir(dir, 'p')
  end
end

function M.get_nvim_version()
  local actual_ver = vim.version()

  local nvim_ver_str = string.format("%d.%d.%d", actual_ver.major, actual_ver.minor, actual_ver.patch)
  return nvim_ver_str
end

return M
