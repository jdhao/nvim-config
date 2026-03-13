local ok, diffview = pcall(require, "diffview")
if not ok then
  return
end

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
}
