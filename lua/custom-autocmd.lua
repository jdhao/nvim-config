local fn = vim.fn
local api = vim.api

local utils = require("utils")


-- Display a message when the current file is not in utf-8 format.
-- Note that we need to use `unsilent` command here because of this issue:
-- https://github.com/vim/vim/issues/4379
api.nvim_create_augroup("non_utf8_file", {
  clear = true
})

api.nvim_create_autocmd({ "BufRead" }, {
  pattern = "*",
  group = "non_utf8_file",
  callback = function()
    if vim.bo.fileencoding ~= 'utf-8' then
      vim.notify("File not in UTF-8 format!", vim.log.levels.WARN, { title = "nvim-config" })
    end
  end
})

-- highlight yanked region, see `:h lua-highlight`
api.nvim_create_augroup("highlight_yank", {
  clear = true
})

api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  group = "highlight_yank",
  callback = function()
    vim.highlight.on_yank { higroup = "YankColor", timeout = 300, on_visual = false }
  end
})

-- Auto-generate packer_compiled.lua file
api.nvim_create_augroup("packer_auto_compile", {
  clear = true
})

api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*/nvim/lua/plugins.lua",
  group = "packer_auto_compile",
  callback = function(ctx)
    local cmd = "source " .. ctx.file
    vim.cmd(cmd)
    vim.cmd("PackerCompile")
  end
})

-- Auto-create dir when saving a file, in case some intermediate directory does not exist
api.nvim_create_augroup("auto_create_dir", {
  clear = true
})

api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = "auto_create_dir",
  callback = function(ctx)
    local dir = fn.fnamemodify(ctx.file, ":p:h")
    utils.may_create_dir(dir)
  end
})

-- Automatically reload the file if it is changed outside of Nvim, see https://unix.stackexchange.com/a/383044/221410.
-- It seems that `checktime` does not work in command line. We need to check if we are in command
-- line before executing this command, see also https://vi.stackexchange.com/a/20397/15292 .
api.nvim_create_augroup("auto_read", {
  clear = true
})

api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  pattern = "*",
  group = "auto_read",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN, { title = "nvim-config" })
  end
})

api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
  pattern = "*",
  group = "auto_read",
  callback = function()
    if fn.getcmdwintype() == '' then
      vim.cmd("checktime")
    end
  end
})
