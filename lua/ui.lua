--- This module will load a random colorscheme on nvim startup process.
local utils = require("utils")

local M = {}

local use_theme = function(name)
  local ok, err = pcall(vim.cmd.colorscheme, name)

  if not ok then
    vim.notify(
      string.format("Failed to load colorscheme %s, err: %s", name, err),
      vim.log.levels.WARN
    )

    vim.cmd.colorscheme("default")
  end
end

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
  oxocarbon = function()
    use_theme("oxocarbon")
  end,
}

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.rand_colorscheme = function()
  local colorscheme_names = vim.tbl_keys(M.colorscheme_conf)
  local colorscheme = utils.rand_element(colorscheme_names)

  -- Load the colorscheme and its settings

  local color_scheme_loader = M.colorscheme_conf[colorscheme]

  color_scheme_loader()

  return colorscheme
end

M.rand_colorscheme()

-- enable the experiment UI
require("vim._core.ui2").enable {
  enable = true,
  msg = { -- Options related to the message module.
    ---@type 'cmd'|'msg' Default message target, either in the
    ---cmdline or in a separate ephemeral message window.
    ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
    ---or table mapping |ui-messages| kinds and triggers to a target.
    targets = "cmd",
    cmd = { -- Options related to messages in the cmdline window.
      height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
    },
    dialog = { -- Options related to dialog window.
      height = 0.5, -- Maximum height.
    },
    msg = { -- Options related to msg window.
      height = 0.5, -- Maximum height.
      timeout = 4000, -- Time a message is visible in the message window.
    },
    pager = { -- Options related to message window.
      height = 0.5, -- Maximum height.
    },
  },
}

return M
