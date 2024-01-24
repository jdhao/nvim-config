local keymap = vim.keymap

-- disable foldcolumn, see https://github.com/kevinhwang91/nvim-ufo/issues/4
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true -- Don't set nofoldenable in ftplugin

-- treesitter as a main provider instead
-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})

local ufo = require('ufo')
keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })
keymap.set('n', 'zr', ufo.openFoldsExceptKinds, { desc = 'Fold less' })
keymap.set('n', 'zm', ufo.closeFoldsWith, { desc = 'Fold more' })
