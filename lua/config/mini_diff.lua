local symbol_icon = require("symbol_icon")

require("mini.diff").setup(
  -- No need to copy this inside `setup()`. Will be used automatically.
  {
    -- Options for how hunks are visualized
    view = {
      -- Visualization style. Possible values are 'sign' and 'number'.
      -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
      style = "sign",

      -- Signs used for hunks with 'sign' view
      signs = {
        add = symbol_icon.git.diff.added,
        change = symbol_icon.git.diff.modified,
        delete = symbol_icon.git.diff.removed,
      },

      -- Priority of used visualization extmarks
      priority = 199,
    },

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Go to hunk range in corresponding direction
      goto_first = "[C",
      goto_prev = "[c",
      goto_next = "]c",
      goto_last = "]C",
    },
  }
)
