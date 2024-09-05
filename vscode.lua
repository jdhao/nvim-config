-- 1.options
-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'                 -- allow the mouse to be used in Nvim

-- Searching
vim.opt.incsearch = true            -- search as characters are entered
vim.opt.hlsearch = true            -- do not highlight matches
vim.opt.ignorecase = true           -- ignore case in searches by default
vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered

-- Tab
vim.opt.tabstop = 4                 -- number of visual spaces per TAB
vim.opt.softtabstop = 4             -- number of spacesin tab when editing
vim.opt.shiftwidth = 4              -- insert 4 spaces on a tab
vim.opt.expandtab = true            -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true               -- show absolute number
vim.opt.relativenumber = true       -- add numbers to each line on the left side
vim.opt.cursorline = true           -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true           -- open new vertical split bottom
vim.opt.splitright = true           -- open new horizontal splits right
-- vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false            -- we are experienced, wo don't need the "-- INSERT --" mode hint
vim.opt.wrap = false          -- Wrapping sucks (except on markdown)
vim.opt.swapfile = false      -- Do not leave any backup files
vim.opt.showmatch  = true     -- Highlights the matching parenthesis
vim.opt.signcolumn = "yes"    -- Always show the signcolumn, otherwise it would shift the text
vim.opt.hidden = true         -- Allow multple buffers
vim.opt.shortmess:append("c") -- Don't pass messages to |ins-completion-menu|.
vim.opt.encoding = "utf-8"    -- Just in case
vim.opt.cmdheight = 2           -- Shows better messages

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
