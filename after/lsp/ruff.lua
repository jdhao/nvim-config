local lsp_utils = require("lsp_utils")

return {
  init_options = {
    -- the settings can be found here: https://docs.astral.sh/ruff/editors/settings/
    settings = {
      organizeImports = true,
    },
  },
  capabilities = lsp_utils.get_default_capabilities(),
}
