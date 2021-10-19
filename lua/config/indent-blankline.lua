require("indent_blankline").setup {
  char = "|",
  show_end_of_line = false,
  disable_with_nolist = true,
  buftype_exclude = {"terminal"},
  filetype_exclude = { "help", "startify", "git", "markdown" },
}

vim.cmd[[
augroup indent_blankline
  autocmd!
  autocmd InsertEnter * IndentBlanklineDisable
  autocmd InsertLeave * IndentBlanklineEnable
augroup END
]]
