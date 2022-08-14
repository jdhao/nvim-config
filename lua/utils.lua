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

function M.may_create_dir()
  local fpath = fn.expand('<afile>')
  local parent_dir = fn.fnamemodify(fpath, ":p:h")
  local res = fn.isdirectory(parent_dir)

  if res == 0 then
    fn.mkdir(parent_dir, 'p')
  end
end

function M.check_version_match()
  -- check if we have the lastest stable version of nvim
  local expected_ver = {major = 0, minor = 7, patch = 2}
  local actual_ver = vim.version()

  local ver_match = true
  for key, val in pairs(expected_ver) do
    if val ~= actual_ver[key] then
      ver_match = false
      break
    end
  end

  local expect_ver_str = string.format("%s.%s.%s", expected_ver.major, expected_ver.minor, expected_ver.patch)
  local nvim_ver_str = string.format("%s.%s.%s", actual_ver.major, actual_ver.minor, actual_ver.patch)

  return {match=ver_match, expected=expect_ver_str, actual=nvim_ver_str}
end

return M
