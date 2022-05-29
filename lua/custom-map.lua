local keymap = vim.keymap

-- Go to the begining and end of current line in insert mode quickly
keymap.set('i', '<C-A>', '<HOME>')
keymap.set('i', '<C-E>', '<END>')

-- Delete the character to the right of the cursor
keymap.set('i', '<C-D>', '<DEL>')
