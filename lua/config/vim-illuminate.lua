require("illuminate").configure {
  providers = {
    "lsp",
    "treesitter",
  },
  filetypes_denylist = {},
  filetypes_allowlist = {
    "go",
    "java",
    "javascript",
    "json",
    "lua",
    "python",
    "sh",
    "toml",
    "typescript",
    "yaml",
  },
  min_count_to_highlight = 2,
}
