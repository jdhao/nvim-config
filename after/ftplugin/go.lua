-- gofumpt adds more rule to gofmt, and is compatible with gofmt,
-- so also https://github.com/mvdan/gofumpt
vim.keymap.set("n", "<Space>f", function()
  vim.cmd([[silent !gofumpt -w %]])
end, { buffer = true, silent = true })
