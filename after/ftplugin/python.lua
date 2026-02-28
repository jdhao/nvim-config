local utils = require("utils")
local opt = vim.opt

opt.wrap = false
opt.sidescroll = 5
opt.sidescrolloff = 2
opt.colorcolumn = "100"

opt.tabstop = 4 -- Number of visual spaces per TAB
opt.softtabstop = 4 -- Number of spaces in tab when editing
opt.shiftwidth = 4 -- Number of spaces to use for autoindent
opt.expandtab = true -- Expand tab to spaces so that tabs are spaces

local get_proj_root = function()
  local project_marker = { ".git", "pyproject.toml" }
  local project_root = vim.fs.root(0, project_marker)

  return project_root
end

local get_py_env = function()
  local project_root = get_proj_root()

  local venv_name = utils.get_virtual_env()

  if venv_name ~= "" then
    return "plain_venv"
  end

  -- check if this is uv-managed project
  local uv_lock_path = vim.fs.joinpath(project_root, "uv.lock")
  if vim.fn.filereadable(uv_lock_path) == 1 then
    return "uv"
  end

  return ""
end

local py_env = get_py_env()

if vim.fn.exists(":AsyncRun") == 2 then
  local py_cmd = "python"

  if py_env == "uv" then
    py_cmd = "uv run python"
  end

  local rhs = string.format(":<C-U>AsyncRun %s -u %%<CR>", py_cmd)

  vim.keymap.set("n", "<F9>", rhs, {
    buffer = true,
    silent = true,
  })
end

-- format current file

local py_fmt_cmd = "!black"
if py_env == "uv" then
  py_fmt_cmd = "!uv run black"
end

local rhs = string.format("<cmd>silent %s %%<CR>", py_fmt_cmd)
vim.keymap.set("n", "<space>f", rhs, {
  buffer = true,
  silent = true,
})
