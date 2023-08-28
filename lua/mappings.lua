local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

-- Save key strokes (now we do not need to press shift to enter command mode).
keymap.set({ "n", "x" }, ";", ":")

-- Turn the word under cursor to upper case
keymap.set("i", "<c-u>", "<Esc>viwUea")

-- Turn the current word into title case
keymap.set("i", "<c-t>", "<Esc>b~lea")

-- Paste non-linewise text above or below current line, see https://stackoverflow.com/a/1346777/6064933
keymap.set("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line" })
keymap.set("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line" })

-- Shortcut for faster save and quit
keymap.set("n", "<leader>w", "<cmd>update<cr>", { silent = true, desc = "save buffer" })

-- Saves the file if modified and quit
keymap.set("n", "<leader>q", "<cmd>x<cr>", { silent = true, desc = "quit current window" })

-- Quit all opened buffers
keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", { silent = true, desc = "quit nvim" })

-- Navigation in the location and quickfix list
keymap.set("n", "[l", "<cmd>lprevious<cr>zv", { silent = true, desc = "previous location item" })
keymap.set("n", "]l", "<cmd>lnext<cr>zv", { silent = true, desc = "next location item" })

keymap.set("n", "[L", "<cmd>lfirst<cr>zv", { silent = true, desc = "first location item" })
keymap.set("n", "]L", "<cmd>llast<cr>zv", { silent = true, desc = "last location item" })

keymap.set("n", "[q", "<cmd>cprevious<cr>zv", { silent = true, desc = "previous qf item" })
keymap.set("n", "]q", "<cmd>cnext<cr>zv", { silent = true, desc = "next qf item" })

keymap.set("n", "[Q", "<cmd>cfirst<cr>zv", { silent = true, desc = "first qf item" })
keymap.set("n", "]Q", "<cmd>clast<cr>zv", { silent = true, desc = "last qf item" })

-- Close location list or quickfix list if they are present, see https://superuser.com/q/355325/736190
keymap.set("n", [[\x]], "<cmd>windo lclose <bar> cclose <cr>", {
  silent = true,
  desc = "close qf and location list",
})

-- Delete a buffer, without closing the window, see https://stackoverflow.com/q/4465095/6064933
keymap.set("n", [[\d]], "<cmd>bprevious <bar> bdelete #<cr>", {
  silent = true,
  desc = "delete buffer",
})

-- Insert a blank line below or above current line (do not move the cursor),
-- see https://stackoverflow.com/a/16136133/6064933
keymap.set("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", {
  expr = true,
  desc = "insert line below",
})

keymap.set("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", {
  expr = true,
  desc = "insert line above",
})

-- Move the cursor based on physical lines, not the actual lines.
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap.set("n", "^", "g^")
keymap.set("n", "0", "g0")

-- Do not include white space characters when using $ in visual mode,
-- see https://vi.stackexchange.com/q/12607/15292
keymap.set("x", "$", "g_")

-- Go to start or end of line easier
keymap.set({ "n", "x" }, "H", "^")
keymap.set({ "n", "x" }, "L", "g_")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://superuser.com/q/310417/736190
keymap.set("x", "<", "<gv")
keymap.set("x", ">", ">gv")

-- Edit and reload nvim config file quickly
keymap.set("n", "<leader>ev", "<cmd>tabnew $MYVIMRC <bar> tcd %:h<cr>", {
  silent = true,
  desc = "open init.lua",
})

keymap.set("n", "<leader>sv", function()
  vim.cmd([[
      update $MYVIMRC
      source $MYVIMRC
    ]])
  vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
end, {
  silent = true,
  desc = "reload init.lua",
})

-- Reselect the text that has just been pasted, see also https://stackoverflow.com/a/4317090/6064933.
keymap.set("n", "<leader>v", "printf('`[%s`]', getregtype()[0])", {
  expr = true,
  desc = "reselect last pasted area",
})

-- Always use very magic mode for searching
keymap.set("n", "/", [[/\v]])

-- Search in selected region
-- xnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change cwd" })

-- Use Esc to quit builtin terminal
keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- Toggle spell checking
keymap.set("n", "<F11>", "<cmd>set spell!<cr>", { desc = "toggle spell" })
keymap.set("i", "<F11>", "<c-o><cmd>set spell!<cr>", { desc = "toggle spell" })

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
keymap.set("n", "c", '"_c')
keymap.set("n", "C", '"_C')
keymap.set("n", "cc", '"_cc')
keymap.set("x", "c", '"_c')

-- Remove trailing whitespace characters
keymap.set("n", "<leader><space>", "<cmd>StripTrailingWhitespace<cr>", { desc = "remove trailing space" })

-- check the syntax group of current cursor position
keymap.set("n", "<leader>st", "<cmd>call utils#SynGroup()<cr>", { desc = "check syntax group" })

-- Copy entire buffer.
keymap.set("n", "<leader>y", "<cmd>%yank<cr>", { desc = "yank entire buffer" })

-- Toggle cursor column
keymap.set("n", "<leader>cl", "<cmd>call utils#ToggleCursorCol()<cr>", { desc = "toggle cursor column" })

-- Move current line up and down
keymap.set("n", "<A-k>", '<cmd>call utils#SwitchLine(line("."), "up")<cr>', { desc = "move line up" })
keymap.set("n", "<A-j>", '<cmd>call utils#SwitchLine(line("."), "down")<cr>', { desc = "move line down" })

-- Move current visual-line selection up and down
keymap.set("x", "<A-k>", '<cmd>call utils#MoveSelection("up")<cr>', { desc = "move selection up" })

keymap.set("x", "<A-j>", '<cmd>call utils#MoveSelection("down")<cr>', { desc = "move selection down" })

-- Replace visual selection with text in register, but not contaminate the register,
-- see also https://stackoverflow.com/q/10723700/6064933.
keymap.set("x", "p", '"_c<Esc>p')

-- Go to a certain buffer
keymap.set("n", "gb", '<cmd>call buf_utils#GoToBuffer(v:count, "forward")<cr>', {
  desc = "go to buffer (forward)",
})
keymap.set("n", "gB", '<cmd>call buf_utils#GoToBuffer(v:count, "backward")<cr>', {
  desc = "go to buffer (backward)",
})

-- Switch windows
keymap.set("n", "<left>", "<c-w>h")
keymap.set("n", "<Right>", "<C-W>l")
keymap.set("n", "<Up>", "<C-W>k")
keymap.set("n", "<Down>", "<C-W>j")

-- Text objects for URL
keymap.set({ "x", "o" }, "iu", "<cmd>call text_obj#URL()<cr>", { desc = "URL text object" })

-- Text objects for entire buffer
keymap.set({ "x", "o" }, "iB", "<cmd>call text_obj#Buffer()<cr>", { desc = "buffer text object" })

-- Do not move my cursor when joining lines.
keymap.set("n", "J", function()
  vim.cmd([[
      normal! mzJ`z
      delmarks z
    ]])
end, {
  desc = "join line",
})

keymap.set("n", "gJ", function()
  -- we must use `normal!`, otherwise it will trigger recursive mapping
  vim.cmd([[
      normal! zmgJ`z
      delmarks z
    ]])
end, {
  desc = "join visual lines",
})

-- Break inserted text into smaller undo units when we insert some punctuation chars.
local undo_ch = { ",", ".", "!", "?", ";", ":" }
for _, ch in ipairs(undo_ch) do
  keymap.set("i", ch, ch .. "<c-g>u")
end

-- insert semicolon in the end
keymap.set("i", "<A-;>", "<Esc>miA;<Esc>`ii")

-- Go to the beginning and end of current line in insert mode quickly
keymap.set("i", "<C-A>", "<HOME>")
keymap.set("i", "<C-E>", "<END>")

-- Go to beginning of command in command-line mode
keymap.set("c", "<C-A>", "<HOME>")

-- Delete the character to the right of the cursor
keymap.set("i", "<C-D>", "<DEL>")

keymap.set("n", "<leader>cb", function()
  local cnt = 0
  local blink_times = 7
  local timer = uv.new_timer()

  timer:start(0, 100, vim.schedule_wrap(function()
    vim.cmd[[
      set cursorcolumn!
      set cursorline!
    ]]

    if cnt == blink_times then
      timer:close()
    end

    cnt = cnt + 1
  end))
end)
