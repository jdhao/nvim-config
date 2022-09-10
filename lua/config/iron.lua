local iron = require("iron")
iron.core.set_config {
  preferred = {
    python = "ipython",
  },
  repl_open_cmd = "vertical 120 split",
}
