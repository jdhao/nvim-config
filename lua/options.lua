local utils = require("utils")

local fn = vim.fn
local opt = vim.opt
local o = vim.o

-- Change fillchars for folding, vertical split, end of buffer, and message separator
opt.fillchars = {
  fold = " ",
  foldsep = " ",
  foldopen = "",
  foldclose = "",
  vert = "│",
  eob = " ",
  msgsep = "‾",
  diff = "╱",
}

-- Split window below/right when creating horizontal/vertical windows
opt.splitbelow = true
opt.splitright = true

-- Avoid the flickering when splitting window horizontal
opt.splitkeep = "screen"

-- Time in milliseconds to wait for a mapped sequence to complete,
-- see https://unix.stackexchange.com/q/36882/221410 for more info
opt.timeoutlen = 500

opt.updatetime = 500 -- For CursorHold events

-- Clipboard settings, always use clipboard for all delete, yank, change, put
-- operation, see https://stackoverflow.com/q/30691466/6064933
if fn["provider#clipboard#Executable"]() ~= "" then
  opt.clipboard:append("unnamedplus")
end

-- Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
opt.swapfile = false

-- Ignore certain files and folders when globbing
opt.wildignore:append {
  "*.o",
  "*.obj",
  "*.dylib",
  "*.bin",
  "*.dll",
  "*.exe",
  "*/.git/*",
  "*/.svn/*",
  "*/__pycache__/*",
  "*/build/**",
  "*.jpg",
  "*.png",
  "*.jpeg",
  "*.bmp",
  "*.gif",
  "*.tiff",
  "*.svg",
  "*.ico",
  "*.pyc",
  "*.pkl",
  "*.DS_Store",
  "*.aux",
  "*.bbl",
  "*.blg",
  "*.brf",
  "*.fls",
  "*.fdb_latexmk",
  "*.synctex.gz",
  "*.xdv",
}
opt.wildignorecase = true -- Ignore file and dir name cases in cmd-completion

-- Set up backup directory
vim.g.backupdir = fn.stdpath("data") .. "/backup//"
opt.backupdir = vim.g.backupdir

-- Skip backup for patterns in option wildignore
opt.backupskip = o.wildignore
opt.backup = true -- Create backup for files
opt.backupcopy = "yes" -- Copy the original file to backupdir and overwrite it

-- General tab settings
opt.tabstop = 2 -- Number of visual spaces per TAB
opt.softtabstop = 2 -- Number of spaces in tab when editing
opt.shiftwidth = 2 -- Number of spaces to use for autoindent
opt.expandtab = true -- Expand tab to spaces so that tabs are spaces

-- Set matching pairs of characters and highlight matching brackets
opt.matchpairs:append {
  "<:>",
  "「:」",
  "『:』",
  "【:】",
  '":"',
  "':'",
  "《:》",
}

-- Show line number and relative line number
opt.number = true
opt.relativenumber = true

-- Ignore case in general, but become case-sensitive when uppercase is present
opt.ignorecase = true
opt.smartcase = true

-- File and script encoding settings for vim
opt.fileencoding = "utf-8"
opt.fileencodings = { "ucs-bom", "utf-8", "cp936", "gb18030", "big5", "euc-jp", "euc-kr", "latin1" }

-- Break line at predefined characters
opt.linebreak = true
-- Character to show before the lines that have been soft-wrapped
opt.showbreak = "↪"

-- List all matches and complete till longest common string
opt.wildmode = "list:longest"

-- Minimum lines to keep above and below cursor when scrolling
opt.scrolloff = 3

-- Use mouse to select and resize windows, etc.
opt.mouse = "n"
opt.mousemodel = "popup" -- Set the behaviour of mouse
opt.mousescroll = { "ver:1", "hor:0" }

-- Disable showing current mode on command line since statusline plugins can show it.
opt.showmode = false

opt.fileformats = { "unix", "dos" } -- Fileformats to use for new files

-- Ask for confirmation when handling unsaved or read-only files
opt.confirm = true

opt.visualbell = true
opt.errorbells = false -- Do not use visual and errorbells
opt.history = 500 -- The number of command and search history to keep

-- Use list mode and customized listchars
opt.list = true
opt.listchars = {
  tab = "▸ ",
  extends = "❯",
  precedes = "❮",
  nbsp = "␣",
}

-- Auto-write the file based on some condition
opt.autowrite = true

-- Auto reload file if changed outside nvim
opt.autoread = true

-- Show hostname, full path of file and last-mod time on the window title.
-- The meaning of the format str for strftime can be found in
-- http://man7.org/linux/man-pages/man3/strftime.3.html. The function to get
-- lastmod time is drawn from https://stackoverflow.com/q/8426736/6064933
opt.title = true
o.titlestring = "%{v:lua.require('utils').get_titlestr()}"

-- Persistent undo even after you close a file and re-open it
opt.undofile = true

-- Do not show "match xx of xx" and other messages during auto-completion
-- Do not show search match count on bottom right (seriously, I would strain my
-- neck looking at it). Using plugins like vim-anzu or nvim-hlslens is a better
-- choice, IMHO.
-- Disable showing intro message (:intro)
opt.shortmess:append("cSI")

opt.messagesopt = "hit-enter,history:500"

-- Completion behaviour
opt.completeopt:append("menuone") -- Show menu even if there is only one item
opt.completeopt:remove("preview") -- Disable the preview window

opt.pumheight = 10 -- Maximum number of items to show in popup menu
opt.pumblend = 5 -- Pseudo transparency for completion menu

opt.winblend = 0 -- Pseudo transparency for floating window
opt.winborder = "none"

-- Insert mode key word completion setting
opt.complete:append("kspell")
opt.complete:remove { "w", "b", "u", "t" }

opt.spelllang = { "en", "cjk" } -- Spell languages
opt.spellsuggest:append("9") -- Show 9 spell suggestions at most

-- Align indent to next multiple value of shiftwidth. For its meaning,
-- see http://vim.1045645.n5.nabble.com/shiftround-option-td5712100.html
opt.shiftround = true

opt.virtualedit = "block" -- Virtual edit is useful for visual block edit

-- Correctly break multi-byte characters such as CJK,
-- see https://stackoverflow.com/q/32669814/6064933
opt.formatoptions:append("mM")

-- Tilde (~) is an operator, thus must be followed by motions like `e` or `w`.
opt.tildeop = true

opt.synmaxcol = 250 -- Text after this column number is not highlighted
opt.startofline = false

-- External program to use for grep command
if utils.executable("rg") then
  opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Enable true color support. Do not set this option if your terminal does not
-- support true colors! For a comprehensive list of terminals supporting true
-- colors, see https://github.com/termstandard/colors and https://gist.github.com/XVilka/8346728.
opt.termguicolors = true

-- Set up cursor color and shape in various mode, ref:
-- https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-color-in-the-terminal
opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20"

opt.signcolumn = "yes:1"

-- Remove certain character from file name pattern matching
opt.isfname:remove { "=", "," }

-- diff options
opt.diffopt = {
  "vertical", -- Show diff in vertical position
  "filler", -- Show filler for deleted lines
  "closeoff", -- Turn off diff when one file window is closed
  "context:3", -- Context for diff
  "internal",
  "indent-heuristic",
  "algorithm:histogram",
}
-- inline diff makes changes in a line more noticeable, the author suggests to
-- remove linematch option if you use inline option, see also
-- https://www.reddit.com/r/neovim/comments/1myfvla/comment/najy4s3/
if fn.has("nvim-0.12") == 1 then
  opt.diffopt:append("inline:char")
else
  opt.diffopt:append("linematch:60")
end

opt.wrap = false -- Do not wrap
opt.ruler = false

opt.showcmdloc = "statusline"
