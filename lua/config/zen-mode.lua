require("zen-mode").setup {
  window = {
    backdrop = 0.8, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = 120,
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0", -- disable fold column
      list = false, -- disable whitespace characters
    },
  },
}
