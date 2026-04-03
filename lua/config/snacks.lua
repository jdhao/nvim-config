require("snacks").setup {
  -- more beautiful vim.ui.input
  input = {
    enabled = true,
    win = {
      relative = "cursor",
      backdrop = true,
    },
  },
  -- more beautiful vim.ui.select
  picker = { enabled = true },
}
