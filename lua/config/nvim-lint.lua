local nvim_lint = require("lint")

nvim_lint.linters_by_ft = {
  -- to use vale, install it: `brew install vale`
  -- configure it via: https://vale.sh/generator, put config in `.vale.ini` in project root.
  -- to install cspell and typos: `brew install cspell typos-cli`
  -- markdown = { "vale", "cspell", "typos" },
}

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    nvim_lint.try_lint()
  end,
})
