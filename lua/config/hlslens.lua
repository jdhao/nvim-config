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

  if not status then
    -- 13 is the index where real error message starts
    msg = msg:sub(13)
    api.nvim_err_writeln(msg)
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

keymap.set("n", "*", "", {
  callback = function()
    vim.fn.execute("normal! *N")
    hlslens.start()
  end,
})
keymap.set("n", "#", "", {
  callback = function()
    vim.fn.execute("normal! #N")
    hlslens.start()
  end,
})
