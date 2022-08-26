local utils = require('utils')

local M = {}

-- Theme to directory name mapping, because theme repo name is not necessarily
-- the same as the theme name itself.
M.theme2dir = {
  gruvbox8 = "vim-gruvbox8",
  onedark = 'onedark.nvim',
  edge = 'edge',
  sonokai = 'sonokai',
  gruvbox_material = 'gruvbox-material',
  nord = 'nord.nvim',
  doom_one = 'doom-one.nvim',
  everforest = 'everforest',
  nightfox = 'nightfox.nvim',
  kanagawa = 'kanagawa.nvim',
  catppuccin = 'catppuccin'
}

M.gruvbox8 = function()
  -- Italic options should be put before colorscheme setting,
  -- see https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
  vim.g.gruvbox_italics = 1
  vim.g.gruvbox_italicize_strings = 1
  vim.g.gruvbox_filetype_hi_groups = 1
  vim.g.gruvbox_plugin_hi_groups = 1

  vim.cmd [[colorscheme gruvbox8_hard]]
end

M.onedark = function()
  vim.cmd [[colorscheme onedark]]
end

M.edge = function()
  vim.g.edge_enable_italic = 1
  vim.g.edge_better_performance = 1

  vim.cmd [[colorscheme edge]]
end

M.sonokai = function()
  vim.g.sonokai_enable_italic = 1
  vim.g.sonokai_better_performance = 1

  vim.cmd [[colorscheme sonokai]]
end

M.gruvbox_material = function()
  vim.g.gruvbox_material_enable_italic = 1
  vim.g.gruvbox_material_better_performance = 1

  vim.cmd [[colorscheme gruvbox-material]]
end

M.nord = function()
  vim.cmd [[colorscheme nord]]
end

M.doom_one = function()

  vim.cmd [[colorscheme doom-one]]
end

M.everforest = function()
  vim.g.everforest_enable_italic = 1
  vim.g.everforest_better_performance = 1

  vim.cmd [[colorscheme everforest]]
end

M.nightfox = function()
  vim.cmd [[colorscheme nordfox]]
end


M.kanagawa = function()
  vim.cmd [[colorscheme kanagawa]]
end

M.catppuccin = function()
  -- available option: latte, frappe, macchiato, mocha
  vim.g.catppuccin_flavour = "frappe"

  require("catppuccin").setup()

  vim.cmd [[colorscheme catppuccin]]
end


--- Use a random theme from the pre-defined list of themes.
M.rand_theme = function ()
  local theme = utils.rand_element(vim.tbl_keys(M.theme2dir))

  if not vim.tbl_contains(vim.tbl_keys(M), theme) then
    local msg = "Invalid theme: " .. theme
    vim.notify(msg, vim.log.levels.ERROR, { title = 'nvim-config' })

    return
  end

  -- Load the theme, because all the themes are declared as opt plugins, the theme isn't loaded yet.
  local status = utils.add_pack(M.theme2dir[theme])

  if not status then
    local msg = string.format("Theme %s is not installed. Run PackerSync to install.", theme)
    vim.notify(msg, vim.log.levels.ERROR, { title = 'nvim-config' })

    return
  end

  -- Set the theme.
  M[theme]()

  if vim.g.logging_level == 'debug' then
    local msg = "Colorscheme: " .. theme

    vim.notify(msg, vim.log.levels.DEBUG, { title = 'nvim-config' })
  end
end

M.rand_theme()
