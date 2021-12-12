require('hlslens').setup({
    calm_down = true,
    nearest_only = true,
})

vim.api.nvim_set_keymap(
  "n",
  "n",
  "<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "N",
  "<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "*", "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "#", "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>", { silent = true })
