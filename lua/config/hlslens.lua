local api = vim.api
local keymap = vim.keymap

local hlslens = require("hlslens")

hlslens.setup {
  calm_down = true,
  nearest_only = true,
}

local activate_hlslens = function(direction)
  local cmd = string.format("normal! %s%szzzv", vim.v.count1, direction)
  local status, msg = pcall(vim.cmd, cmd)

  -- Deal with the case that there is no such pattern in current buffer.
  if not status then
    local start_idx, _ = string.find(msg, 'E486', 1, true)
    local msg_part = string.sub(msg, start_idx)
    api.nvim_err_writeln(msg_part)
    return
  end

  hlslens.start()
end

keymap.set("n", "n", "", {
  callback = function()
    activate_hlslens("n")
  end,
})

keymap.set("n", "N", "", {
  callback = function()
    activate_hlslens("N")
  end,
})

local no_word_under_cursor = function()
  local cursor_word = vim.fn.expand("<cword>")

  local result = cursor_word == ""
  if result then
    local msg = "E348: No string under cursor"
    api.nvim_err_writeln(msg)
  end

  return result
end

keymap.set("n", "*", "", {
  callback = function()
    if no_word_under_cursor() then
      return
    end
    vim.fn.execute("normal! *N")
    hlslens.start()
  end,
})
keymap.set("n", "#", "", {
  callback = function()
    if no_word_under_cursor() then
      return
    end
    vim.fn.execute("normal! #N")
    hlslens.start()
  end,
})
