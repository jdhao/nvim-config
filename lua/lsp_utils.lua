local symbol_icon = require("symbol_icon")

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

M.show_lsp_menu = function(size, position)
  local Menu = require("nui.menu")
  local NuiLine = require("nui.line")

  local width, height = size.width, size.height
  local pos_row, pos_col = position.row, position.col

  --- @type nui_popup_options
  local popup_options = {
    relative = "win",
    position = {
      row = pos_row,
      col = pos_col,
    },
    size = {
      width = width,
      height = height,
    },
    border = {
      style = "single",
      text = {
        top = "[LSP attached]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }

  local lsp_names = M.get_attached_lsp()
  local menu_items = {}
  for _, name in ipairs(lsp_names) do
    local line = NuiLine()
    local text = string.format("%s %s", symbol_icon.lsp.icon, name)
    line:append(text)

    local menu_item = Menu.item(line)
    table.insert(menu_items, menu_item)
  end

  local menu_options = {
    lines = menu_items,
    max_width = 30,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>", "q" },
      submit = { "<CR>", "<Space>" },
    },
  }

  local menu = Menu(popup_options, menu_options)

  -- mount the component
  menu:mount()
end

M.main_lsp_by_filetype = {
  python = "pyright",
  go = "gopls",
  lua = "lua_ls",
}

return M
