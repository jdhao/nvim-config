-- inspect something
-- Taken from https://github.com/jamestthompson3/vimConfig/blob/eeef4a8eeb5a24938f8a0969a35f69c78643fb66/lua/tt/nvim_utils.lua#L106
function inspect(item)
  print(vim.inspect(item))
end

local M = {}

function M.executable(name)
  if vim.fn.executable(name) > 0 then
    return true
  end

  return false
end

return M
