require("iswap").setup {
  move_cursor = true,
}
vim.keymap.set("n", "gs<", "<cmd>ISwapWithLeft<cr>")
vim.keymap.set("n", "gs>", "<cmd>ISwapWithRight<cr>")
