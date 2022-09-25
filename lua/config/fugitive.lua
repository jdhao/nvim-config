local keymap = vim.keymap

keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
keymap.set("n", "<leader>gw", "<cmd>Gwrite<cr>", { desc = "Git add" })
keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git diff" })
keymap.set("n", "<leader>gpl", "<cmd>Git pull<cr>", { desc = "Git pull" })
keymap.set("n", "<leader>gpu", "<cmd>15 split|term git push<cr>", { desc = "Git push" })

-- convert git to Git in command line mode
vim.fn['utils#Cabbrev']('git', 'Git')
