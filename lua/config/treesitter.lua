-- a list of filetypes to install treesitter parsers and queries
local ensure_installed = {
  "python",
  "cpp",
  "lua",
  "vim",
  "json",
  "toml",
  "yaml",
  "javascript",
  "go",
  "typescript",
  "markdown",
  "sh",
  "zsh",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = ensure_installed,

  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)

    -- check if parser is available
    if not vim.treesitter.language.add(lang) then
      local available = vim.g.ts_available or require("nvim-treesitter").get_available()
      if not vim.g.ts_available then
        vim.g.ts_available = available
      end

      if vim.tbl_contains(available, lang) then
        -- install treesitter parsers and queries
        local install_msg = string.format("Installing parsers and queries for %s", lang)
        vim.print(install_msg)
        require("nvim-treesitter").install(lang)
      end
    end

    if vim.treesitter.language.add(lang) then
      -- start treesitter highlighting
      vim.treesitter.start(args.buf, lang)

      -- the following two statements will enable treesitter folding
      -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      -- vim.wo[0][0].foldmethod = "expr"

      -- enable treesitter-based indentation
      -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
