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

-- when we run `:compiler ruff`, then followed by `:make`,
-- Nvim will run ruff in the current directory. By default, `--preview` option is used.
-- The following option is used to customize the option passed to ruff.
vim.g.ruff_makeprg_params = ""

local run_py_script = function()
  local py_cmd = utils.get_py_cmd()
  if py_cmd == nil then
    vim.notify("can not find python to run this script!")
    return
  end

  local run_cmd = ""
  if vim.fn.exists(":AsyncRun") == 2 then
    run_cmd = string.format("AsyncRun %s -u %%", py_cmd)
  else
    run_cmd = string.format("!%s -u %%", py_cmd)
  end

  vim.cmd(run_cmd)
end

vim.keymap.set("n", "<F9>", run_py_script, {
  buffer = true,
  silent = true,
})

-- format current file

local format_py_file = function()
  local black_cmd = ""
  local py_env = utils.get_py_env()

  if py_env == "uv" then
    black_cmd = "!uv run black"
  elseif utils.executable("black") then
    black_cmd = "!black"
  end

  if black_cmd == "" then
    vim.notify("black not available!")
  end

  vim.print(black_cmd)
  local format_cmd = string.format("silent %s %%", black_cmd)

  vim.cmd(format_cmd)
end

vim.keymap.set("n", "<space>f", format_py_file, {
  desc = "format file",
  buffer = true,
  silent = true,
})
