require('hlslens').setup({
    calm_down = true,
    nearest_only = true,
})

vim.keymap.set('n', 'n', '',
{
  noremap = true,
  silent = true,
  callback = function()
    vim.fn.execute("normal! " .. vim.v.count1 .. "nzzzv")
    require('hlslens').start()
  end
})

vim.keymap.set('n', 'N', '',
{
  noremap = true,
  silent = true,
  callback = function()
    vim.fn.execute("normal! " .. vim.v.count1 .. "Nzzzv")
    require('hlslens').start()
  end
})

vim.keymap.set('n', '*', "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>", { silent = true })
vim.keymap.set('n', '#', "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>", { silent = true })
