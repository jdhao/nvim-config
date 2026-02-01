require("git-conflict").setup {}

vim.api.nvim_create_autocmd("User", {
  pattern = "GitConflictResolved",
  callback = function()
    -- clear qf list
    vim.fn.setqflist({}, "r")

    -- reopen it?
    vim.cmd([[silent! GitConflictListQf]])
  end,
})
