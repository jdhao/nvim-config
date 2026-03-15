-- settings for lua-language-server can be found on https://luals.github.io/wiki/settings/
---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      hint = {
        enable = true,
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME .. "/lua",
        },
      },
    },
  },
}
