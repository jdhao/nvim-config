local M = {}

M.lsp = {
  icon = "",
  not_exist = "🚫",
}

M.git = {
  branch = "",
  diff = {
    added = "+",
    modified = "~",
    removed = "-",
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "│" },
  },
  commit = {
    ahead = "↑",
    behind = "↓",
  },
}

M.file = {
  readonly = "󰈡",
}

M.diagnostic = {
  error = "🆇",
  warn = "⚠️",
  info = "ℹ️",
  hint = "",
}

M.IME = {
  chinese = "[CN]",
}

M.python = ""

M.fileformat = {
  unix = "", -- e712
  dos = "", -- e70f
  mac = "", -- e711
}

M.statusline = {
  section_separators = {
    left = "",
    right = "",
  },
  component_separators = {
    left = "\\",
    right = "/",
  },
}

M.fillchars = {
  fold = " ",
  foldsep = " ",
  foldopen = "",
  foldclose = "",
  vert = "│",
  eob = " ",
  msgsep = "‾",
  diff = "╱",
}

M.indent = "▏"

M.tabline = {
  buffer_close = "",
  buffer_modified = "●",
  close = "",
  left_trunc_marker = "",
  right_trunc_marker = "",
}

M.fold_indicator = "󰁂"

return M
