local lsp_utils = require("lsp_utils")

return {
  filetypes = { "text", "plaintex", "tex", "markdown" },
  settings = {
    ltex = {
      language = "en",
    },
  },
  flags = { debounce_text_changes = 300 },
  capabilities = lsp_utils.get_default_capabilities(),
}
