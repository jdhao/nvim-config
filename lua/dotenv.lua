-- code from https://github.com/mcjkula/lua-dotenv/blob/main/env.lua
local M = {}
local env_vars = {}

function M.get(key, default)
  local value = env_vars[key] or os.getenv(key)
  return value or default
end

function M.load_dotenv(file_path)
  file_path = file_path or os.getenv("HOME") .. "/.config/.env"
  local file, _ = io.open(file_path, "r")
  if not file then
    return
  end

  local content = file:read("*all")
  file:close()

  for line in content:gmatch("[^\r\n]+") do
    local key, value = line:match("^([%w_]+)%s*=%s*(.+)$")
    if key and value then
      value = value:gsub("^[\"'](.-)[\"']$", "%1")
      env_vars[key] = value
    end
  end
end

return M
