local api = vim.api
local keymap = vim.keymap

require('hlslens').setup({
    calm_down = true,
    nearest_only = true,
})

local activate_hlslens = function(direction)
  local cmd = string.format("normal! %s%szzzv", vim.v.count1, direction)
  local status, msg = pcall(vim.fn.execute, cmd)
  -- 13 is the index where real error message starts
  msg = msg:sub(13)

  if not status then
    api.nvim_err_writeln(msg)
    return
  end
  require('hlslens').start()
end

keymap.set('n', 'n', '',
{
  silent = true,
  callback = function() activate_hlslens('n') end
})

keymap.set('n', 'N', '',
{
  silent = true,
  callback = function() activate_hlslens('N') end
})

keymap.set('n', '*', "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>", { silent = true })
keymap.set('n', '#', "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>", { silent = true })
