-- #region OmniSharp
--local lspconfig = require'lspconfig'
--
--local on_attach = function(client, bufnr)
--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--   buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', GQuickOpt('OmniSharp: [G]oto [*D]eclaration'))
--   buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', GQuickOpt('OmniSharp: [G]oto [D]efinition'))
--   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', GQuickOpt('OmniSharp: [G]oto [I]mplementation'))
--   buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', GQuickOpt('OmniSharp: [K] Hover'))
--   buf_set_keymap('n', '<leader>ch', '<cmd>lua vim.lsp.buf.hover()<CR>', GQuickOpt('OmniSharp: [C]ode [H]over'))
--   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', GQuickOpt('OmniSharp: [C-K] Signature Help'))
--   buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', GQuickOpt('OmniSharp: `[` [D]iaglog Goto Previous'))
--   buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', GQuickOpt('OmniSharp: `]` [D]iaglog Goto Next'))
--   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', GQuickOpt('OmniSharp: [G]oto [R]eferences'))
--
--end
----local pid = vim.fn.getpid()
----
--local omnisharp_bin = os.getenv("LOCALAPPDATA") .. "omnisharp-vim\\omnisharp-roslyn\\OmniSharp.exe"
----
--lspconfig.omnisharp.setup {
--   cmd = { omnisharp_bin },
--   on_attach = on_attach,
--   root_dir = require'lspconfig'.util.root_pattern(".git", "."),
--}
--
--vim.g.OmniSharp_server_use_mono = 1
--vim.g.OmniSharp_server_stdio = 1
-- #endregion

-- #region Roslyn
require('roslyn').setup {
  args = {
    '--logLevel=Information',
    '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
    '--razorSourceGenerator=' .. vim.fs.joinpath(
      vim.fn.stdpath 'data' --[[@as string]],
      'mason',
      'packages',
      'roslyn',
      'libexec',
      'Microsoft.CodeAnalysis.Razor.Compiler.dll'
    ),
    '--razorDesignTimePath=' .. vim.fs.joinpath(
      vim.fn.stdpath 'data' --[[@as string]],
      'mason',
      'packages',
      'rzls',
      'libexec',
      'Targets',
      'Microsoft.NET.Sdk.Razor.DesignTime.targets'
    ),
  },
  config = {
    on_attach = require 'lspconfig',
    capabilities = capabilities,
    handlers = require 'rzls.roslyn_handlers',
  },
}

require('telescope').setup {
  defaults = {
    file_ignore_patterns = { '%__virtual.cs$' },
  },
}
-- #endregion
