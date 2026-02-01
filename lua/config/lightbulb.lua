---@diagnostic disable: missing-fields
require("nvim-lightbulb").setup {
  autocmd = {
    enabled = true,
    updatetime = -1,
  },
  ---@diagnostic disable-next-line: unused-local
  filter = function(client_name, result)
    -- Ruff always sends these two actions even if there are no action to take,
    -- so it is better to just ignore this to avoid noise. See also discussion below:
    -- https://github.com/astral-sh/ruff-lsp/issues/91
    local ignored_kinds = { "source.fixAll.ruff", "source.organizeImports.ruff" }

    if vim.tbl_contains(ignored_kinds, result.kind) then
      return false
    end

    return true
  end,
}
