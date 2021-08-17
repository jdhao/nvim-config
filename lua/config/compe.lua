-- nvim-compe settings
require("compe").setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    omni = { filetypes = { "tex" } },
    path = true,
    buffer = false,
    spell = { filetypes = { "markdown", "tex" } },
    emoji = true,
    nvim_lsp = true,
    nvim_lua = true,
    ultisnips = true,
    calc = false,
    vsnip = false,
  },
})

vim.o.completeopt = "menuone,noselect"

-- nvim-compe mappings
local compe_map_opts = { expr = true, noremap = true, silent = true }
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", compe_map_opts)
vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", compe_map_opts)
vim.api.nvim_set_keymap("i", "<ESC>", "compe#close('<ESC>')", compe_map_opts)
vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({'delta': +4})", compe_map_opts)
vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({'delta': -4})", compe_map_opts)
