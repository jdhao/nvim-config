local lsp_utils = require("lsp_utils")

return {
  filetypes = { "c", "cpp", "cc" },
  flags = {
    debounce_text_changes = 500,
  },
  capabilities = lsp_utils.get_default_capabilities(),
}
