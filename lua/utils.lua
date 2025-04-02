local fn = vim.fn
local version = vim.version

local M = {}

--- Check if an executable exists
--- @param name string An executable name/path
--- @return boolean
function M.executable(name)
  return fn.executable(name) > 0
end

--- check whether a feature exists in Nvim
--- @param feat string the feature name, like `nvim-0.7` or `unix`.
--- @return boolean
M.has = function(feat)
  if fn.has(feat) == 1 then
    return true
  end

  return false
end

--- Create a dir if it does not exist
function M.may_create_dir(dir)
  local res = fn.isdirectory(dir)

  if res == 0 then
    fn.mkdir(dir, "p")
  end
end

--- Generate random integers in the range [Low, High], inclusive,
--- adapted from https://stackoverflow.com/a/12739441/6064933
--- @param low integer the lower value for this range
--- @param high integer the upper value for this range
--- @return integer
function M.rand_int(low, high)
  -- Use lua to generate random int, see also: https://stackoverflow.com/a/20157671/6064933
  math.randomseed(os.time())

  return math.random(low, high)
end

--- Select a random element from a sequence/list.
--- @param seq any[] the sequence to choose an element
function M.rand_element(seq)
  local idx = M.rand_int(1, #seq)

  return seq[idx]
end

--- check if the current nvim version is compatible with the allowed version
--- @param expected_version string
--- @return boolean
function M.is_compatible_version(expected_version)
  -- check if we have the latest stable version of nvim
  local expect_ver = version.parse(expected_version)
  local actual_ver = vim.version()

  if expect_ver == nil then
    local msg = string.format("Unsupported version string: %s", expected_version)
    vim.api.nvim_echo({ { msg } }, true, { err = true })
    return false
  end

  local result = version.cmp(expect_ver, actual_ver)
  if result ~= 0 then
    local _ver = string.format("%s.%s.%s", actual_ver.major, actual_ver.minor, actual_ver.patch)
    local msg = string.format(
      "Expect nvim version %s, but your current nvim version is %s. Use at your own risk!",
      expected_version,
      _ver
    )
    vim.api.nvim_echo({ { msg } }, true, { err = true })
  end

  return true
end

--- check if we are inside a git repo
--- @return boolean
function M.inside_git_repo()
  local result = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }, { text = true }):wait()
  if result.code ~= 0 then
    return false
  end

  -- Manually trigger a special user autocmd InGitRepo (used lazyloading.
  vim.cmd([[doautocmd User InGitRepo]])

  return true
end

return M
