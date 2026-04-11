local opt = vim.opt

-- General tab settings
opt.tabstop = 4 -- Number of visual spaces per TAB
opt.softtabstop = 4 -- Number of spaces in tab when editing
opt.shiftwidth = 4 -- Number of spaces to use for autoindent
opt.expandtab = false -- Expand tab to spaces so that tabs are spaces

-- gofumpt adds more rule to gofmt, and is compatible with gofmt,
-- so also https://github.com/mvdan/gofumpt
vim.keymap.set("n", "<Space>f", function()
  vim.cmd([[silent !gofumpt -w %]])
end, { buffer = true, silent = true })

vim.keymap.set("n", "<F9>", function()
  vim.cmd[[!go run %]]
end, {
  buffer = true,
  silent = true,
})
