local fn = vim.fn

local git_status_cache = {}

local get_cmd_out = function(cmd)
  local result = vim.system(cmd, { text = true }):wait()

  if result.code ~= 0 then
    -- vim.print(vim.inspect(result))
    return false, result.stderr
  end

  return true, result.stdout
end

local function split_cmd_string(cmd_str)
  return vim.tbl_filter(function(element)
    if element ~= "" then
      return true
    end
    return false
  end, vim.split(cmd_str, " "))
end

local function get_branch_name()
  local branch_cmd_str = "git rev-parse --abbrev-ref HEAD"
  local branch_cmd = split_cmd_string(branch_cmd_str)
  local success, branch_output = get_cmd_out(branch_cmd)

  if not success then
    return
  end
  local branch_name = string.gsub(branch_output, "\n$", "")
  -- print(string.format("branch: %s", branch_name))

  return branch_name
end

local function update_git_status()
  -- Fetch the latest changes from the remote repository (replace 'origin' if needed)
  local fetch_cmd = split_cmd_string("git fetch origin")

  local fetch_success, _ = get_cmd_out(fetch_cmd)
  if not fetch_success then
    return
  end

  local branch_name = get_branch_name()
  if branch_name == nil then
    return
  end

  -- Get the number of commits behind
  local behind_cmd_str = string.format("git rev-list --count %s..origin/%s", branch_name, branch_name)
  local behind_cmd = split_cmd_string(behind_cmd_str)
  local behind_success, behind_output = get_cmd_out(behind_cmd)
  if behind_success then
    local behind_count = tonumber(behind_output:match("(%d+)")) or 0
    git_status_cache.behind = behind_count
  end

  -- Get the number of commits ahead
  local ahead_cmd_str = string.format("git rev-list --count origin/%s..%s", branch_name, branch_name)
  local ahead_cmd = split_cmd_string(ahead_cmd_str)
  local ahead_success, ahead_output = get_cmd_out(ahead_cmd)
  if ahead_success then
    local ahead_count = tonumber(ahead_output:match("(%d+)")) or 0
    git_status_cache.ahead = ahead_count
  end
end

local function get_ahead_behind_info()
  local status = git_status_cache
  if not status then
    return ""
  end

  local msg = ""

  if type(status.behind) == "number" and status.behind > 0 then
    local behind_str = string.format("↓[%d] ", status.behind)
    msg = msg .. behind_str
  end

  if type(status.ahead) == "number" and status.ahead > 0 then
    local ahead_str = string.format("↑[%d] ", status.ahead)
    msg = msg .. ahead_str
  end

  return msg
end

local timer = vim.uv.new_timer()

local branch_name = get_branch_name()
-- run frequency in seconds
local interval = 30
local ms = interval * 1000
if branch_name ~= nil then
  timer:start(
    0,
    ms,
    vim.schedule_wrap(function()
      update_git_status()
    end)
  )
end

local function spell()
  if vim.o.spell then
    return string.format("[SPELL]")
  end

  return ""
end

--- show indicator for Chinese IME
local function ime_state()
  if vim.g.is_mac then
    -- ref: https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/extensions/xkblayout.vim#L11
    local layout = fn.libcall(vim.g.XkbSwitchLib, "Xkb_Switch_getXkbLayout", "")

    -- We can use `xkbswitch -g` on the command line to get current mode.
    -- mode for macOS builtin pinyin IME: com.apple.inputmethod.SCIM.ITABC
    -- mode for Rime: im.rime.inputmethod.Squirrel.Rime
    local res = fn.match(layout, [[\v(Squirrel\.Rime|SCIM.ITABC)]])
    if res ~= -1 then
      return "[CN]"
    end
  end

  return ""
end

local function trailing_space()
  if not vim.o.modifiable then
    return ""
  end

  local line_num = nil

  for i = 1, fn.line("$") do
    local linetext = fn.getline(i)
    -- To prevent invalid escape error, we wrap the regex string with `[[]]`.
    local idx = fn.match(linetext, [[\v\s+$]])

    if idx ~= -1 then
      line_num = i
      break
    end
  end

  local msg = ""
  if line_num ~= nil then
    msg = string.format("[%d]trailing", line_num)
  end

  return msg
end

local function mixed_indent()
  if not vim.o.modifiable then
    return ""
  end

  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = fn.search(space_pat, "nwc")
  local tab_indent = fn.search(tab_pat, "nwc")
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = fn.search([[\v^(\t+ | +\t)]], "nwc")
    mixed = mixed_same_line > 0
  end
  if not mixed then
    return ""
  end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return "MI:" .. mixed_same_line
  end
  local space_indent_cnt = fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
  local tab_indent_cnt = fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
  if space_indent_cnt > tab_indent_cnt then
    return "MI:" .. tab_indent
  else
    return "MI:" .. space_indent
  end
end

local diff = function()
  local git_status = vim.b.gitsigns_status_dict
  if git_status == nil then
    return
  end

  local modify_num = git_status.changed
  local remove_num = git_status.removed
  local add_num = git_status.added

  local info = { added = add_num, modified = modify_num, removed = remove_num }
  -- vim.print(info)
  return info
end

local virtual_env = function()
  -- only show virtual env for Python
  if vim.bo.filetype ~= "python" then
    return ""
  end

  local conda_env = os.getenv("CONDA_DEFAULT_ENV")
  local venv_path = os.getenv("VIRTUAL_ENV")

  if venv_path == nil then
    if conda_env == nil then
      return ""
    else
      return string.format("  %s (conda)", conda_env)
    end
  else
    local venv_name = vim.fn.fnamemodify(venv_path, ":t")
    return string.format("  %s (venv)", venv_name)
  end
end

local get_active_lsp = function()
  local msg = "🚫"
  local buf_ft = vim.api.nvim_get_option_value("filetype", {})
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if next(clients) == nil then
    return msg
  end

  for _, client in ipairs(clients) do
    ---@diagnostic disable-next-line: undefined-field
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "⏐", right = "⏐" },
    section_separators = "",
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      {
        "filename",
        symbols = {
          readonly = "[🔒]",
        },
      },
    },
    lualine_b = {
      {
        "branch",
        fmt = function(name, _)
          -- truncate branch name in case the name is too long
          return string.sub(name, 1, 20)
        end,
        color = { gui = "italic,bold" },
      },
      {
        get_ahead_behind_info,
        -- "",
        color = { fg = "#E0C479" },
      },
      {
        "diff",
        source = diff,
      },
      {
        virtual_env,
        color = { fg = "black", bg = "#F1CA81" },
      },
    },
    lualine_c = {
      {
        "%S",
        color = { gui = "bold", fg = "cyan" },
      },
      {
        spell,
        color = { fg = "black", bg = "#a7c080" },
      },
    },
    lualine_x = {
      {
        get_active_lsp,
        icon = "📡",
      },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = "🆇 ", warn = "⚠️ ", info = "ℹ️ ", hint = " " },
      },
      {
        trailing_space,
        color = "WarningMsg",
      },
      {
        mixed_indent,
        color = "WarningMsg",
      },
    },
    lualine_y = {
      {
        "encoding",
        fmt = string.upper,
      },
      {
        "fileformat",
        symbols = {
          unix = "unix",
          dos = "win",
          mac = "mac",
        },
      },
      "filetype",
      {
        ime_state,
        color = { fg = "black", bg = "#f46868" },
      },
    },
    lualine_z = {
      "location",
      "progress",
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "quickfix", "fugitive", "nvim-tree" },
}
