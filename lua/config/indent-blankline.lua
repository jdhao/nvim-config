require("indent_blankline").setup({
	-- U+2502 may also be a good choice, it will be on the middle of cursor.
	-- U+250A is also a good choice
	char = "▏",
	show_end_of_line = false,
	disable_with_nolist = true,
	buftype_exclude = { "terminal" },
	filetype_exclude = { "help", "git", "markdown", "snippets", "text", "gitconfig" },
})

vim.cmd([[
augroup indent_blankline
  autocmd!
  autocmd InsertEnter * IndentBlanklineDisable
  autocmd InsertLeave * IndentBlanklineEnable
augroup END
]])
