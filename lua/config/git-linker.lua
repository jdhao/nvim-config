local gitlinker = require('gitlinker')

gitlinker.setup({
  mappings = nil,
})

vim.keymap.set({ 'n', 'v' }, '<leader>gl', '', {
  silent = true,
  desc = "get git permlink",
  callback = function()
    local mode = string.lower(vim.fn.mode())
    gitlinker.get_buf_range_url(mode)
  end
})
