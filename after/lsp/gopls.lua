-- settings for gopls can be found in https://go.dev/gopls/settings
---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      usePlaceholders = true,
      -- Analyzer doc: https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md.
      -- Note that most of the anazlyer (with some number) are from staticcheck.
      -- If staticcheck is true, it is useless to enable those analyzer inside `analyses` field again,
      -- unless we want to disable a certain analyzer from staticcheck.
      analyses = {
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
      semanticTokens = true,
      -- inlayHints settings, see https://go.dev/gopls/inlayHints
      hints = {
        compositeLiteralFields = true,
        parameterNames = true,
      },
      diagnosticsTrigger = "Save",
    },
  },
}
