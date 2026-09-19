return {
  cmd = { "golangci-lint-langserver" },
  root_markers = { ".git", "go.mod" },
  init_options = {
    command = {
      "golangci-lint",
      "run",
      "--output.json.path",
      "stdout",
      "--show-stats=false",
      "--issues-exit-code=1",
    },
  },
}
