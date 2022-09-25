local keymap = vim.keymap
local gitlinker = require("gitlinker")

gitlinker.setup {
  mappings = nil,
}

keymap.set({ "n", "v" }, "<leader>gl", "", {
  silent = true,
  desc = "get git permlink",
  callback = function()
    local mode = string.lower(vim.fn.mode())
    gitlinker.get_buf_range_url(mode)
  end,
})

keymap.set("n", "<leader>gb", "", {
  silent = true,
  desc = "browse repo in browser",
  callback = function()
    gitlinker.get_repo_url({
      action_callback = gitlinker.actions.open_in_browser
    })
  end
})
