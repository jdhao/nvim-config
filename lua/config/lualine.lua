local utils = require("utils")
local lsp_utils = require("lsp_utils")
local fn = vim.fn

-- cache for git states
local git_status_cache = {
  fetch_success = false,
  behind_count = 0,
  ahead_count = 0,
}

local on_exit_fetch = function(result)
  if result.code == 0 then
    git_status_cache.fetch_success = true
  end
end

local function handle_numeric_result(cache_key)
  return function(result)
    if result.code == 0 then
      git_status_cache[cache_key] = tonumber(result.stdout:match("(%d+)")) or 0
    else
      -- when the git command fails, it usually means there are some changes in your branch. For example, you
      -- on branchA, for this one, you have upstream branch. Then you changed to branchB, and there is no upstream
      -- branch, the git rev-list command will error out. In this case, we should clear the cache
      -- vim.print("Error running git command", result)
      git_status_cache[cache_key] = 0
    end
  end
end

local async_cmd = function(cmd_str, on_exit)
  local cmd = vim.tbl_filter(function(element)
    return element ~= ""
  end, vim.split(cmd_str, " "))

  vim.system(cmd, { text = true }, on_exit)
end

local async_git_status_update = function()
  -- Fetch the latest changes from the remote repository (replace 'origin' if needed)
  async_cmd("git fetch origin", on_exit_fetch)
  if not git_status_cache.fetch_success then
    return
  end

  -- Get the number of commits behind
  -- the @{upstream} notation is inspired by post: https://www.reddit.com/r/neovim/s/OWNFzqE7nO
  -- note that here we should use double dots instead of triple dots
  local behind_cmd_str = "git rev-list --count HEAD..@{upstream}"
  async_cmd(behind_cmd_str, handle_numeric_result("behind_count"))

  -- Get the number of commits ahead
  local ahead_cmd_str = "git rev-list --count @{upstream}..HEAD"
  async_cmd(ahead_cmd_str, handle_numeric_result("ahead_count"))
end

local function get_git_ahead_behind_info()
  async_git_status_update()

  local status = git_status_cache
  if not status then
    return ""
  end

  local msg = ""

  if type(status.ahead_count) == "number" and status.ahead_count > 0 then
    local ahead_str = string.format("↑[%d] ", status.ahead_count)
    msg = msg .. ahead_str
  end

  if type(status.behind_count) == "number" and status.behind_count > 0 then
    local behind_str = string.format("↓[%d] ", status.behind_count)
    msg = msg .. behind_str
  end

  return msg
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
  local r = vim.api.nvim_get_mode()
  if r.mode == "i" then
    return ""
  end

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

local function show_encoding()
  local fileencoding = vim.api.nvim_get_option_value("fileencoding", { buf = 0 })
  -- normalize the format
  fileencoding = string.upper(fileencoding)

  if fileencoding ~= "UTF-8" then
    return fileencoding
  else
    return ""
  end
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
  local venv_name = utils.get_virtual_env()

  if venv_name ~= "" then
    return string.format(" (%s)", venv_name)
  else
    return ""
  end
end

local show_lsp_menu = function()
  local Menu = require("nui.menu")
  local NuiLine = require("nui.line")

  --- @type nui_popup_options
  local popup_options = {
    relative = "win",
    position = {
      row = 69,
      col = 130,
    },
    size = {
      width = 20,
      height = 5,
    },
    border = {
      style = "single",
      text = {
        top = "[LSP attached]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }

  local lsp_names = lsp_utils.get_attached_lsp()
  local menu_items = {}
  for _, name in ipairs(lsp_names) do
    local line = NuiLine()
    local text = string.format("󰒋 %s", name)
    line:append(text)

    local menu_item = Menu.item(line)
    table.insert(menu_items, menu_item)
  end

  local menu_options = {
    lines = menu_items,
    max_width = 30,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>", "q" },
      submit = { "<CR>", "<Space>" },
    },
  }

  local menu = Menu(popup_options, menu_options)

  -- mount the component
  menu:mount()
end

local get_active_lsp = function()
  local msg = "🚫"

  local lsp_names_unordered = lsp_utils.get_attached_lsp()
  if next(lsp_names_unordered) == nil then
    return msg
  end

  local main_lsp = lsp_utils.main_lsp_by_filetype[vim.bo.filetype]
  local client_names = utils.reorder_list_element(lsp_names_unordered, main_lsp)

  local cnt = #client_names
  local lsp_infos = nil
  if cnt == 1 then
    lsp_infos = client_names[1]
  else
    lsp_infos = string.format("%s (+%s)", client_names[1], cnt - 1)
  end

  return lsp_infos
end

local show_branch_menu = function()
  local Menu = require("nui.menu")

  --- @type nui_popup_options
  local popup_options = {
    relative = "win",
    position = {
      row = 70,
      col = 10,
    },
    size = {
      width = 50,
      height = 5,
    },
    border = {
      style = "single",
      text = {
        top = "[Git branches]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }

  local branch_info = utils.get_git_branches()
  local local_branches = branch_info["local"]
  local remote_branches = branch_info["remote"]

  if #local_branches == 0 and #remote_branches == 0 then
    return
  end

  local menu_items = {}
  for _, branch in ipairs(local_branches) do
    local menu_item = Menu.item(branch, { is_local = true })
    table.insert(menu_items, menu_item)
  end

  table.insert(
    menu_items,
    Menu.separator("Remote", {
      char = "-",
      text_align = "center",
    })
  )

  for _, branch in ipairs(remote_branches) do
    local menu_item = Menu.item(branch, { is_local = false })
    table.insert(menu_items, menu_item)
  end

  local menu_options = {
    lines = menu_items,
    max_width = 30,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>", "q" },
      submit = { "<CR>", "<Space>" },
    },
    on_close = function()
      print("Menu Closed!")
    end,
    on_submit = function(item)
      ---@type string
      local branch_name = item.text

      ---@type boolean
      local is_local = item.is_local

      local cmd = {}
      if is_local then
        cmd = { "git", "checkout", branch_name }
      else
        cmd = { "git", "checkout", "--track", branch_name }
      end

      local r = vim.system(cmd, { text = true }):wait()
      if r.code ~= 0 then
        vim._log("failed to switch branch:")
        vim._log(r.stderr)
      end
    end,
  }

  local menu = Menu(popup_options, menu_options)

  -- mount the component
  menu:mount()
end

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "\\", right = "/" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = false,
    refresh = {
      statusline = 1000,
    },
  },
  sections = {
    lualine_a = {
      {
        "filename",
        symbols = {
          readonly = "󰈡",
        },
      },
    },
    lualine_b = {
      {
        "branch",
        icon = "",
        fmt = function(name, _)
          -- truncate branch name in case the name is too long
          return string.sub(name, 1, 20)
        end,
        color = { gui = "italic,bold" },
        on_click = show_branch_menu,
      },
      {
        get_git_ahead_behind_info,
      },
      {
        "diff",
        symbols = { added = "+", modified = "~", removed = "-" },
        source = diff,
      },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = "🆇 ", warn = "⚠️ ", info = "ℹ️ ", hint = " " },
        color = { gui = "bold" },
      },
    },
    lualine_c = {
      {
        ime_state,
        color = { fg = "black", bg = "#f46868" },
      },
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
        icon = "",
        on_click = show_lsp_menu,
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
        show_encoding,
        color = "ErrorMsg",
      },
      {
        "fileformat",
      },
    },
    lualine_z = {
      "progress",
      {
        virtual_env,
        color = { fg = "black", bg = "#F1CA81" },
      },
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
