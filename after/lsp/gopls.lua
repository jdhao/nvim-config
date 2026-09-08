-- settings for gopls can be found in https://go.dev/gopls/settings
---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      semanticTokens = true,
      -- inlayHints settings, see https://go.dev/gopls/inlayHints
      hints = {
        compositeLiteralFields = true,
        parameterNames = true,
      },
    },
  },
}
