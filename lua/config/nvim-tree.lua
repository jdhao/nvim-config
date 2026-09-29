local nvim_tree = require("nvim-tree")

nvim_tree.setup {}

vim.keymap.set("n", "<space>s", require("nvim-tree.api").tree.toggle, {
  silent = true,
  desc = "toggle nvim-tree",
})
