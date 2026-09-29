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

local py_env = utils.get_py_env()

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
  desc = "format file",
  buffer = true,
  silent = true,
})
