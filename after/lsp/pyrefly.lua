---@type vim.lsp.Config
return {
  init_options = {
    pyrefly = {
      typeCheckingMode = "default",
      -- see documentation here: https://pyrefly.org/en/docs/IDE/#lsp-initializationoptions
      disabledLanguageServices = {
        rename = true,
      },
    },
  },
  handlers = {
    -- pyrefly's "unused import/variable/parameter" and "unreachable code" are IDE-only hints
    -- hard-coded with the Unnecessary tag (not configurable error kinds), so they can only be
    -- filtered client-side.
    ["textDocument/publishDiagnostics"] = function(err, result, ctx)
      if result and result.diagnostics then
        result.diagnostics = vim.tbl_filter(function(d)
          local unnecessary = vim.lsp.protocol.DiagnosticTag.Unnecessary
          return not (d.tags and vim.tbl_contains(d.tags, unnecessary))
        end, result.diagnostics)
      end

      vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx)
    end,
  },
}
