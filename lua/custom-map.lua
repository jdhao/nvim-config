local keymap = vim.keymap

-- Go to the beginning and end of current line in insert mode quickly
keymap.set('i', '<C-A>', '<HOME>')
keymap.set('i', '<C-E>', '<END>')

-- Go to beginning of command in command-line mode
keymap.set('c', '<C-A>', '<HOME>')

-- Delete the character to the right of the cursor
keymap.set('i', '<C-D>', '<DEL>')
