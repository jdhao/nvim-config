local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Show diagnostic automatically when cursor is on hold.
  vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})')

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("x", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR><ESC>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi link LspReferenceRead Visual
      hi link LspReferenceText Visual
      hi link LspReferenceWrite Visual
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  local msg = string.format('Language server %s started!' , client.name)
  vim.api.nvim_echo({{msg, 'MoreMsg'}, }, false, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")

lspconfig.pyls.setup{
  on_attach = on_attach,
  settings = {
    pyls = {
      plugins = {
        flake8 = {enabled = false},
        pylint = {enabled = true, executable = "pylint"},
        pyflakes = {enabled = false},
        pycodestyle = {enabled = false},
        jedi_completion = {fuzzy = true},
        pyls_isort = {enabled = true},
        pyls_mypy = {enabled = true}
      }
    }
  },
  flags = {
    debounce_text_changes = 500,
  }
}

lspconfig.clangd.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "c", "cpp", "cc" },
  flags = {
    debounce_text_changes = 500,
  }
}

-- set up vim-language-server
lspconfig.vimls.setup{
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 500,
  }
}

-- Change diagnostic signs.
vim.fn.sign_define('LspDiagnosticsSignError', { text = "✗", texthl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = "!", texthl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = "", texthl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = "", texthl = "LspDiagnosticsDefaultHint" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

-- The following settings works with the bleeding edge neovim.
-- See https://github.com/neovim/neovim/pull/13998.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = {
       {"┌", "Normal"},
       {"─", "Normal"},
       {"┐", "Normal"},
       {"│", "Normal"},
       {"┘", "Normal"},
       {"─", "Normal"},
       {"└", "Normal"},
       {"│", "Normal"}
     }
    }
)

-- nvim-compe settings
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    omni = {filetypes = {'tex'}};
    path = true;
    buffer = false;
    spell = {filetypes = {'markdown', 'tex'}};
    emoji = true;
    nvim_lsp = true;
    nvim_lua = true;
    ultisnips = true;
    calc = false;
    vsnip = false;
  };
}

vim.o.completeopt = "menuone,noselect"

-- nvim-compe mappings
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<CR>', "compe#confirm('<CR>')", {expr = true})
vim.api.nvim_set_keymap('i', '<ESC>', "compe#close('<ESC>')", {expr = true})
vim.api.nvim_set_keymap('i', '<C-f>', "compe#scroll({'delta': +4})", {expr = true})
vim.api.nvim_set_keymap('i', '<C-d>', "compe#scroll({'delta': -4})", {expr = true})
