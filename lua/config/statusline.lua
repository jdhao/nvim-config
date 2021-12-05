local function spell()
  if vim.o.spell then
    return "[SPELL]"
  end

  return ""
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
    lualine_b = { "branch", "diff",  },
    lualine_c = { spell, "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location", { "diagnostics", sources = { "nvim_lsp" } }},
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
  extensions = {},
})

