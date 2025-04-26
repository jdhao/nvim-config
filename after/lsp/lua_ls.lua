local lsp_utils = require("lsp_utils")

-- settings for lua-language-server can be found on https://luals.github.io/wiki/settings/
return {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      hint = {
        enable = true,
      },
    },
  },
  capabilities = lsp_utils.get_default_capabilities(),
}
