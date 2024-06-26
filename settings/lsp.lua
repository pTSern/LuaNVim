require'lspconfig'.pyright.setup{}
require'lspconfig'.tsserver.setup{}

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

        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
        end
    end
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local servers = {
    lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace', }, }, }, },
}

require('mason').setup()

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua', -- Used to format Lua code
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require('mason-lspconfig').setup {
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}
require'lspconfig'.ast_grep.setup{}
require'lspconfig'.astro.setup{}
