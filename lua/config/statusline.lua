local function spell()
  if vim.o.spell then
    return "[SPELL]"
  end

  return ""
end

local function trailing_space()
  local trailing_space_pos = vim.b.trailing_whitespace_pos

  local msg = ""
  if #trailing_space_pos > 0 then
    -- Note that lua index is 1-based, not zero based!!!
    local line = trailing_space_pos[1][1]
    msg = string.format("[%d]trailing", line)
  end

  return msg
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      {
        spell,
        color = "Cursor"
      },
      "filename"
    },
    lualine_x = {
      "encoding",
      {
        "fileformat",
        symbols = {
          unix = "unix",
          dos = "win",
          mac = "mac",
        },
      },
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = {
      "location",
      {
        "diagnostics",
        sources = { "nvim_lsp" }
      },
      {
        trailing_space,
        color = "WarningMsg"
      }
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {'quickfix', 'fugitive'},
})

