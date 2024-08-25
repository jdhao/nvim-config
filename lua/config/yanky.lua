require("yanky").setup {
  preserve_cursor_position = {
    enabled = false,
  },
  highlight = {
    on_put = true,
    on_yank = false,
    timer = 300,
  },
}

vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")

-- cycle through the yank history, only work after paste
vim.keymap.set("n", "[y", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "]y", "<Plug>(YankyNextEntry)")
