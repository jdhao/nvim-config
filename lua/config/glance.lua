local glance = require("glance")

glance.setup {
  height = 25,
  border = {
    enable = true,
  },
}

vim.keymap.set("n", "<space>gd", "<cmd>Glance definitions<cr>")
vim.keymap.set("n", "<space>gr", "<cmd>Glance references<cr>")
vim.keymap.set("n", "<space>gi", "<cmd>Glance implementations<cr>")
