local win_width = vim.api.nvim_win_get_width(0)

-- do not change layout if the screen is not wide enough
if win_width < 200 then
  return
end

-- L means to put window to leftmost
vim.cmd.wincmd([[L]])
