---@type vim.lsp.Config
return {
  filetypes = { "text", "plaintex", "tex", "markdown" },
  ---@type lspconfig.settings.ltex
  settings = {
    ltex = {
      language = "en",
    },
  },
}
