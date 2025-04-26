local lsp_utils = require("lsp_utils")

return {
  flags = {
    debounce_text_changes = 500,
  },
  capabilities = lsp_utils.get_default_capabilities(),
}
