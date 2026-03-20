local ok, diffview = pcall(require, "diffview")
if not ok then
  return
end

local actions = require("diffview.actions")
local prefix_conflicts = "<leader>gC"

diffview.setup {
  enhanced_diff_hl = true,
  view = {
    default = {
      disable_diagnostics = true,
    },
    merge_tool = {
      layout = "diff3_mixed",
    },
  },
  file_history_panel = {
    win_config = {
      type = "split",
      position = "bottom",
      height = 10,
    },
  },
  keymaps = {
    view = {
      {
        "n",
        prefix_conflicts .. "t",
        actions.conflict_choose("theirs"),
        { desc = "Conflict choose theirs" },
      },
      {
        "n",
        prefix_conflicts .. "o",
        actions.conflict_choose("ours"),
        { desc = "Conflict choose ours" },
      },
      {
        "n",
        prefix_conflicts .. "a",
        actions.conflict_choose("all"),
        { desc = "Conflict choose both" },
      },

      { "n", "]C", actions.next_conflict, { desc = "Next conflict" } },
      { "n", "[C", actions.prev_conflict, { desc = "Previous conflict" } },
    },
  },
}
