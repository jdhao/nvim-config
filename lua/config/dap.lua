local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
require("nvim-dap-virtual-text").setup {}

-- Automatically open/close the UI panels (scopes, stack, breakpoints, repl)
-- around a debug session, similar to VS Code's debug view.
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.fn.sign_define(
  "DapBreakpoint",
  { text = "●", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "◆", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapLogPoint",
  { text = "◆", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapStopped",
  { text = "▶", texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "" }
)
vim.fn.sign_define(
  "DapBreakpointRejected",
  { text = "✗", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
)
