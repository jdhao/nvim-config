local utils = require("utils")

-- Copy file path to clipboard
vim.api.nvim_create_user_command("CopyPath", function(context)
  local full_path = vim.fn.glob("%:p")

  local file_path = nil
  if context["args"] == "nameonly" then
    file_path = vim.fn.fnamemodify(full_path, ":t")
  end

  -- get the file path relative to project root
  if context["args"] == "relative" then
    local project_marker = { ".git", "pyproject.toml" }
    local project_root = vim.fs.root(0, project_marker)
    if project_root == nil then
      vim.print("can not find project root")
      return
    end

    file_path = vim.fn.substitute(full_path, project_root, "<project-root>", "g")
  end

  if context["args"] == "absolute" then
    file_path = full_path
  end

  vim.fn.setreg("+", file_path)
  vim.print("Filepath copied to clipboard!")
end, {
  bang = false,
  nargs = 1,
  force = true,
  desc = "Copy current file path to clipboard",
  complete = function()
    return { "nameonly", "relative", "absolute" }
  end,
})

-- JSON format part of or the whole file
vim.api.nvim_create_user_command("JSONFormat", function(context)
  local range = context["range"]
  local line1 = context["line1"]
  local line2 = context["line2"]

  local python_cmd = nil

  if utils.executable("python3") then
    python_cmd = "python3"
  elseif utils.executable("python") then
    python_cmd = "python"
  else
    vim.print("No python executable found")
    return
  end

  if range == 0 then
    -- the command is invoked without range, then we assume whole buffer
    local cmd_str = string.format("%s,%s!%s -m json.tool --indent 2", line1, line2, python_cmd)
    vim.fn.execute(cmd_str)
  elseif range == 2 then
    -- the command is invoked with some range
    -- for this to work, the mapping has to call this command with `:JSONFormat`,
    -- <cmd>JSONFormat won't work, the range can not be passed with `<cmd>`.
    -- See also: https://www.reddit.com/r/neovim/comments/17xxehz/how_to_correctly_get_line_ranges_from_command/
    local cmd_str = string.format("%s,%s!%s -m json.tool --indent 2", line1, line2, python_cmd)
    vim.fn.execute(cmd_str)
  else
    local msg = string.format("unsupported range: %s", range)
    vim.api.nvim_echo({ { msg } }, true, { err = true })
  end
end, {
  desc = "Format JSON string",
  range = "%",
})

-- modified from solution here: https://github.com/neovim/neovim/issues/30415#issuecomment-2368519968
vim.api.nvim_create_user_command("TermHL", function(args)
  local buf_cur = vim.api.nvim_get_current_buf()
  local buf_new = vim.api.nvim_create_buf(false, true)
  if buf_new == 0 then
    vim._log("Can not create new buffer!")
  end

  vim.b[buf_new].ansi_preview = true

  -- create a "virtual" terminal: it can not accept user input
  local chan = vim.api.nvim_open_term(buf_new, {})
  if chan == 0 then
    vim._log("can not create new channel")
  end

  local data = table.concat(vim.api.nvim_buf_get_lines(buf_cur, 0, -1, false), "\n")
  vim.api.nvim_chan_send(chan, data)

  vim.api.nvim_win_set_buf(0, buf_new)
end, {
  desc = "Highlight buffer with ANSI color",
})
