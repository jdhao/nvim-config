require("live-command").setup {
  enable_highlighting = true,
  inline_highlighting = true,
  commands = {
    Norm = { cmd = "norm" },
  },
}

vim.cmd("cnoreabbrev norm Norm")
