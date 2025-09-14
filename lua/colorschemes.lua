--- This module will load a random colorscheme on nvim startup process.
local utils = require("utils")

local M = {}

local use_theme = vim.cmd.colorscheme

-- Colorscheme to its directory name mapping, because colorscheme repo name is not necessarily
-- the same as the colorscheme name itself.
M.colorscheme_conf = {
  onedark = function()
    -- Lua
    require("onedark").setup {
      style = "darker",
    }
    require("onedark").load()
  end,
  edge = function()
    vim.g.edge_style = "default"
    vim.g.edge_enable_italic = 1
    vim.g.edge_better_performance = 1

    use_theme("edge")
  end,
  sonokai = function()
    vim.g.sonokai_enable_italic = 1
    vim.g.sonokai_better_performance = 1

    use_theme("sonokai")
  end,
  gruvbox_material = function()
    -- foreground option can be material, mix, or original
    vim.g.gruvbox_material_foreground = "original"
    --background option can be hard, medium, soft
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_better_performance = 1

    use_theme("gruvbox-material")
  end,
  everforest = function()
    vim.g.everforest_background = "hard"
    vim.g.everforest_enable_italic = 1
    vim.g.everforest_better_performance = 1

    use_theme("everforest")
  end,
  nightfox = function()
    use_theme("carbonfox")
  end,
  onedarkpro = function()
    -- set colorscheme after options
    -- onedark_vivid does not enough contrast
    use_theme("onedark_dark")
  end,
  material = function()
    vim.g.material_style = "darker"
    use_theme("material")
  end,
  arctic = function()
    use_theme("arctic")
  end,
  kanagawa = function()
    use_theme("kanagawa-dragon")
  end,
  modus = function()
    use_theme("modus")
  end,
  jellybeans = function()
    use_theme("jellybeans")
  end,
  github = function()
    use_theme("github_dark_default")
  end,
  e_ink = function()
    require("e-ink").setup()
    use_theme("e-ink")
  end,
  ashen = function()
    use_theme("ashen")
  end,
  melange = function()
    use_theme("melange")
  end,
  makurai = function()
    use_theme("makurai_dark")
  end,
  vague = function()
    use_theme("vague")
  end,
  kanso = function()
    use_theme("kanso")
  end,
  citruszest = function()
    use_theme("citruszest")
  end,
}

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.rand_colorscheme = function()
  local colorscheme = utils.rand_element(vim.tbl_keys(M.colorscheme_conf))

  -- Load the colorscheme and its settings
  M.colorscheme_conf[colorscheme]()
end

return M
