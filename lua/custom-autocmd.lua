local fn = vim.fn
local api = vim.api

local utils = require("utils")

-- Display a message when the current file is not in utf-8 format.
-- Note that we need to use `unsilent` command here because of this issue:
-- https://github.com/vim/vim/issues/4379
api.nvim_create_autocmd({ "BufRead" }, {
  pattern = "*",
  group = api.nvim_create_augroup("non_utf8_file", { clear = true }),
  callback = function()
    if vim.bo.fileencoding ~= "utf-8" then
      vim.notify("File not in UTF-8 format!", vim.log.levels.WARN, { title = "nvim-config" })
    end
  end,
})

-- highlight yanked region, see `:h lua-highlight`
local yank_group = api.nvim_create_augroup("highlight_yank", { clear = true })
api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  group = yank_group,
  callback = function()
    vim.highlight.on_yank { higroup = "YankColor", timeout = 300 }
  end,
})

api.nvim_create_autocmd({ "CursorMoved" }, {
  pattern = "*",
  group = yank_group,
  callback = function()
    vim.g.current_cursor_pos = vim.fn.getcurpos()
  end,
})

api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = yank_group,
  callback = function(ev)
    if vim.v.event.operator == "y" then
      vim.fn.setpos(".", vim.g.current_cursor_pos)
    end
  end,
})

-- Auto-create dir when saving a file, in case some intermediate directory does not exist
api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(ctx)
    local dir = fn.fnamemodify(ctx.file, ":p:h")
    utils.may_create_dir(dir)
  end,
})

-- Automatically reload the file if it is changed outside of Nvim, see https://unix.stackexchange.com/a/383044/221410.
-- It seems that `checktime` does not work in command line. We need to check if we are in command
-- line before executing this command, see also https://vi.stackexchange.com/a/20397/15292 .
api.nvim_create_augroup("auto_read", { clear = true })

api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  pattern = "*",
  group = "auto_read",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN, { title = "nvim-config" })
  end,
})

api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
  pattern = "*",
  group = "auto_read",
  callback = function()
    if fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- Resize all windows when we resize the terminal
api.nvim_create_autocmd("VimResized", {
  group = api.nvim_create_augroup("win_autoresize", { clear = true }),
  desc = "autoresize windows on resizing operation",
  command = "wincmd =",
})

local function open_nvim_tree(data)
  -- check if buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- create a new, empty buffer
  vim.cmd.enew()

  -- wipe the directory buffer
  vim.cmd.bw(data.buf)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- Do not use smart case in command line mode, extracted from https://vi.stackexchange.com/a/16511/15292.
api.nvim_create_augroup("dynamic_smartcase", { clear = true })
api.nvim_create_autocmd("CmdLineEnter", {
  group = "dynamic_smartcase",
  pattern = ":",
  callback = function()
    vim.o.smartcase = false
  end,
})

api.nvim_create_autocmd("CmdLineLeave", {
  group = "dynamic_smartcase",
  pattern = ":",
  callback = function()
    vim.o.smartcase = true
  end,
})

api.nvim_create_autocmd("TermOpen", {
  group = api.nvim_create_augroup("term_start", { clear = true }),
  pattern = "*",
  callback = function()
    -- Do not use number and relative number for terminal inside nvim
    vim.wo.relativenumber = false
    vim.wo.number = false

    -- Go to insert mode by default to start typing command
    vim.cmd("startinsert")
  end,
})

-- Return to last cursor position when opening a file, note that here we cannot use BufReadPost
-- as event. It seems that when BufReadPost is triggered, FileType event is still not run.
-- So the filetype for this buffer is empty string.
api.nvim_create_autocmd("FileType", {
  group = api.nvim_create_augroup("resume_cursor_position", { clear = true }),
  pattern = "*",
  callback = function(ev)
    local mark_pos = api.nvim_buf_get_mark(ev.buf, '"')
    local last_cursor_line = mark_pos[1]

    local max_line = vim.fn.line("$")
    local buf_filetype = api.nvim_get_option_value("filetype", { buf = ev.buf })
    local buftype = api.nvim_get_option_value("buftype", { buf = ev.buf })

    -- only handle normal files
    if buf_filetype == "" or buftype ~= "" then
      return
    end

    -- Only resume last cursor position when there is no go-to-line command (something like '+23').
    if vim.fn.match(vim.v.argv, [[\v^\+(\d){1,}$]]) ~= -1 then
      return
    end

    if last_cursor_line > 1 and last_cursor_line <= max_line then
      -- vim.print(string.format("mark_pos: %s", vim.inspect(mark_pos)))
      -- it seems that without vim.schedule, the cursor position can not be set correctly
      vim.schedule(function()
        local status, result = pcall(api.nvim_win_set_cursor, 0, mark_pos)
        if not status then
          api.nvim_err_writeln(string.format("Failed to resume cursor position. Context %s, error: %s",
          vim.inspect(ev), result))
        end
      end)
      -- the following two ways also seem to work,
      -- ref: https://www.reddit.com/r/neovim/comments/104lc26/how_can_i_press_escape_key_using_lua/
      -- vim.api.nvim_feedkeys("g`\"", "n", true)
      -- vim.fn.execute("normal! g`\"")
    end
  end,
})

local number_toggle_group = api.nvim_create_augroup("numbertoggle", { clear = true })
api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  pattern = "*",
  group = number_toggle_group,
  desc = "togger line number",
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = true
    end
  end,
})

api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = number_toggle_group,
  desc = "togger line number",
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

api.nvim_create_autocmd("ColorScheme", {
  group = api.nvim_create_augroup("custom_highlight", { clear = true }),
  pattern = "*",
  desc = "Define or overrride some highlight groups",
  callback = function()
    vim.cmd([[
      " For yank highlight
      highlight YankColor ctermfg=59 ctermbg=41 guifg=#34495E guibg=#2ECC71

      " For cursor colors
      highlight Cursor cterm=bold gui=bold guibg=#00c918 guifg=black
      highlight Cursor2 guifg=red guibg=red

      " For floating windows border highlight
      highlight FloatBorder guifg=LightGreen guibg=NONE

      " highlight for matching parentheses
      highlight MatchParen cterm=bold,underline gui=bold,underline
    ]])
  end,
})

api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = api.nvim_create_augroup("auto_close_win", { clear = true }),
  desc = "Quit Nvim if we have only one window, and its filetype match our pattern",
  callback = function(ev)
    local quit_filetypes = {'qf', 'vista', 'NvimTree'}

    local should_quit = true
    local tabwins = api.nvim_tabpage_list_wins(0)

    for _, win in pairs(tabwins) do
      local buf = api.nvim_win_get_buf(win)
      local bf = fn.getbufvar(buf, '&filetype')

      if fn.index(quit_filetypes, bf) == -1 then
        should_quit = false
      end
    end

    if should_quit then
      vim.cmd("qall")
    end
  end
})

api.nvim_create_autocmd({"VimEnter", "DirChanged"}, {
  group = api.nvim_create_augroup("git_repo_check", { clear = true }),
  pattern = "*",
  desc = "check if we are inside Git repo",
  command = "call utils#Inside_git_repo()"
})

-- ref: https://vi.stackexchange.com/a/169/15292
api.nvim_create_autocmd("BufReadPre", {
  group = api.nvim_create_augroup("large_file", { clear = true }),
  pattern = "*",
  desc = "check if we are inside Git repo",
  callback = function (ev)
    local file_size_limit =524288 -- 0.5MB
    local f = ev.file

    if fn.getfsize(f) > file_size_limit or fn.getfsize(f) == -2 then
      vim.o.eventignore = "all"
      --  turning off relative number helps a lot
      vim.wo.relativenumber = false

      vim.bo.swapfile = false
      vim.bo.bufhidden = "unload"
      vim.bo.undolevels = -1
    end
  end
})
