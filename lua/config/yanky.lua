require("yanky").setup({
  ring = {
    history_length = 50,
    storage = "memory",
  },
  preserve_cursor_position = {
    enabled = false,
  },
})

-- cycle through the yank history, only work after paste
vim.keymap.set("n", "[y", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "]y", "<Plug>(YankyCycleBackward)")
