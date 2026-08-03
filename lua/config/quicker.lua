require("quicker").setup {
  edit = {
    enabled = false,
  },
  max_filename_width = function()
    return math.floor(math.min(40, vim.o.columns / 2))
  end,
}
