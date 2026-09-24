local M = {}

M.get_default_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- required by nvim-ufo
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

--- Get the name of LSP attached to current buffer
---@return string[]
M.get_attached_lsp = function()
  local clients = vim.lsp.get_clients { bufnr = 0 }

  local client_names = {}
  for _, client in ipairs(clients) do
    local client_name = client.name
    table.insert(client_names, client_name)
  end

  return client_names
end

M.main_lsp_by_filetype = {
  python = "pyright",
  go = "gopls",
  lua = "lua_ls",
}

return M
