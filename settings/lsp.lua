local lspcfg = require('lspconfig')

lspcfg.pyright.setup{}

local root = g_root .. 'settings/lsp/'
dofile(root .. 'deno.lua')

lspcfg.ts_ls.setup{
  root_dir = lspcfg.util.root_pattern('package.json', 'tsconfig.json', '.git'),
  single_file_support = false,

  on_attach = function(client, bufnr)
    if lspcfg.util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
        client.stop()
    end
  end
}

lspcfg.clangd.setup {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'h' },
  root_dir = lspcfg.util.root_pattern('.clangd', '.git', 'compile_commands.json'),
  single_file_support = true,
  on_attach = function (client, bufnr)
  end
}

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)

        local qnmap = function(key, mechanic, desc)
            vim.keymap.set('n', key, mechanic, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local qsmap = function(k, m, d)
            vim.keymap.set('n', k, ":w<CR><cmd> lua require('telescope.builtin')." .. m .. "()<CR>", { buffer = event.buf, desc = 'LSP: ' .. d })
        end

        local tb = require('telescope.builtin')
        local vlb = vim.lsp.buf

        qsmap('gd', "lsp_definitions", '[G]oto [D]efinition')
        qsmap('gr', "lsp_references", '[G]oto [R]eferences')
        qsmap('gi', "lsp_implementations", '[G]oto [I]mplement')
        qsmap('gtd', "lsp_type_definitions", '[G]oto [T]ype [D]efinition')
        qsmap('<leader>ds', "lsp_document_symbols", '[D]ocument [S]ymbols')
        qsmap('<leader>hs', "lsp_dynamic_workspace_symbols", '[H] Workspace [S]ymbols')
        qnmap('<leader>rn', vlb.rename, '[R]e[n]ame')
        qnmap('<leader>ca', vlb.code_action, '[C]ode Action')
        qnmap('<M-CR>', vlb.code_action, '[C]ode Action')
        qnmap('<leader>ch', vlb.hover, '[C]ode [H]over')
        qnmap('K', vlb.hover, '[*K]ode hover')
        qnmap('gD', vlb.declaration, '[G]oto [*D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        --if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        --    qnmap('<leader>th', function()
        --      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        --    end, '[T]oggle Inlay [H]ints')
        --end
    end
})



local servers = {
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    },
}

require('mason').setup()

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua', -- Used to format Lua code
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

require('mason-lspconfig').setup {
  handlers = {
    function(server_name)
      if server_name ~= 'tsserver' then
        local server = servers[server_name] or {}
        -- This handles overriding only values explicitly passed
        -- by the server configuration above. Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for tsserver)
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end
    end,
  },
}

local dartExcludedFolders = {
    vim.fn.expand("$LOCALAPPDATA/Pub/Cache"),
    vim.fn.expand("$LOCALAPPDATA/js-frameworks/flutter/")
}

lspcfg.dcmls.setup {
  capabilities = capabilities,
  cmd = {
    "dcm",
    "start-server",
  },
  filetypes = { "dart", "yaml" },
  settings = {
    dart = {
      analysisExcludedFolders = dartExcludedFolders,
    }
  }
}

lspcfg.dartls.setup {
  capabilities = capabilities,
  --cmd = {
  --  os.getenv("LOCALAPPDATA") .. "\\js-frameworks\\flutter\\bin\\dart.bat",
  --  "language-server",
  --  "--protocol=lsp"
  --},
  filetypes = { "dart" },
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = false,
		suggestFromUnimportedLibraries = true,
		closingLabels = true,
		outline = false,
		flutterOutline = false,
  },
  settings = {
    dart = {
      analysisExcludedFolders = dartExcludedFolders,
			updateImportsOnRename = true,
			completeFunctionCalls = true,
			showTodos = true,
    }
  }
}

lspcfg.ast_grep.setup{}
lspcfg.astro.setup{}

--#region DiagnosticSign

vim.diagnostic.config(
  {
    virtual_text      = true,
    signs             = true,
    underline         = true,
    update_in_insert  = true,
    severity_sort     = false
  }
)

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--#endregion

--#region Floating preview

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function ()
    vim.diagnostic.open_float(nil, {focus=false})
  end
})

--#endregion

--#region Borders

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
      {"┏", "FloatBorder"},
      {"━", "FloatBorder"},
      {"┓", "FloatBorder"},
      {"┃", "FloatBorder"},
      {"┛", "FloatBorder"},
      {"━", "FloatBorder"},
      {"┗", "FloatBorder"},
      {"┃", "FloatBorder"},
}

---- LSP settings (for overriding per client)
--local handlers =  {
--  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
--  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
--}

-- Do not forget to use the on_attach function
--require 'lspconfig'.tsserver.setup { handlers=handlers }

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

--require 'lspconfig'.tsserver.setup {}

--#endregion

--#region completion Kinds

local M = {}

M.icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Field = "󰄶 ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "󰜰",
  Keyword = "󰌆 ",
  Method = "ƒ ",
  Module = "󰏗 ",
  Property = " ",
  Snippet = "󰘍 ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = "󰎠 ",
  Variable = " ",
}

function M.setup()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
  end
end

return M

--#endregion
