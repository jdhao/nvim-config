local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n",
  "<leader>rc",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr, desc ="code Action" }
)
vim.keymap.set(
  "n",
  "<leader>rr",
  function()
    vim.cmd.RustLsp('runnables')
  end,
  { silent = true, buffer = bufnr, desc ="select executable to run" }
)
vim.keymap.set(
  "n",
  "<leader>r!",
  function()
    vim.cmd.RustLsp{'runnables', bang = true}
  end,
  { silent = true, buffer = bufnr, desc ="run previous runnable" }
)
vim.keymap.set(
  "n",
  "<leader>re",
  function()
    vim.cmd.RustLsp('explainError', 'current')
  end,
  { silent = true, buffer = bufnr, desc ="explain error in current cursor line" }
)
vim.keymap.set(
  "n",
  "<leader>rd",
  function()
    vim.cmd.RustLsp('renderDiagnostic', 'current')
  end,
  { silent = true, buffer = bufnr, desc ="display the rendered diagnostic in current cursor line" }
)
vim.keymap.set(
  "n",
  "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({'hover', 'actions'})
  end,
  { silent = true, buffer = bufnr }
)
