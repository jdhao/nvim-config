local cmp = require('cmp')
cmp.setup.buffer {
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
				buffer = "[Buffer]",
			})[entry.source.name]
		return vim_item
		end,
	},
  sources = cmp.config.sources({
        { name = 'buffer' },
        { name = 'omni',},
      })
}

vim.o.textwidth = 120
vim.o.wrap = true
