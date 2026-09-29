vim.keymap.set({ "n", "v" }, "<space>f", ":JSONFormat<cr>", {
  desc = "format file",
  buffer = true,
  silent = true,
})
