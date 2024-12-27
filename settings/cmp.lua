if _G.target_cmp == 'cmp' then

local cmp = require 'cmp'
local ls = require 'luasnip'

ls.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end
    },

    completion = { completeopt = 'menu, menuone, noinsert' },

    mapping = cmp.mapping.preset.insert {
        ['<down>'] = cmp.mapping.select_next_item(),
        --['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<up>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-l>'] = cmp.mapping( function () if ls.expand_or_locally_jumpable() then ls.expand_or_jump() end end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping( function () if ls.locally_jumpable(-1) then ls.jump(-1) end end, { 'i', 's' }),

        ['<C-Leader'] = cmp.mapping.complete {},
    },

    sources = cmp.config.sources(
    {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        --{
        --    name = 'dotenv',
        --    option = {
        --        path = '.',
        --        load_shell = true,
        --        item_kind = cmp.lsp.CompletionItemKind.Variable,
        --        eval_on_confirm = false,
        --        show_documentation = true,
        --        show_content_on_docs = true,
        --        documentation_kind = 'markdown',
        --        dotenv_environment = '.*',
        --        file_priority = function (a, b)
        --            return a:upper() < b:upper()
        --        end
        --    }
        --}
    },
    {
        { name = 'buffer' },
    }),

    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require "cmp-under-comparator".under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        }
    }
}

else

    GGlobal.coq_settings = {
        keymap = {
            recommended = false
        },

      display = {
        ghost_text = {
          enabled = false,
          context = {}
        }
      }
    }

    GGlobal.coq_settings.display.ghost_text.enabled = false
    vim.cmd [[ COQnow -s ]]
    function qki(key, mechanic, desc)
      vim.api.nvim_set_keymap('i', key, mechanic, { expr = true, silent = true, desc = desc })
    end

    function qkn(key, mechanic, desc)
      vim.api.nvim_set_keymap('i', key, mechanic, { expr = true, silent = true, desc = desc })
    end

    qki('<ESC>', [[ pumvisible() ? "\<C-e><ESC>" : "\<ESC>" ]], '')
    qki('<C-c>', [[ pumvisible() ? "\<C-e><C-c>" : "\<C-c>" ]], '')
    qki('<BS>', [[ pumvisible() ? "\<C-e><BS>" : "\<BS>"]], '')
    qki('<CR>', [[ pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]], '')
    qki('<TAB>', [[ pumvisible() ? "\<C-n>" : "\<Tab>"]], '')

    qki('<C-j>', [[ pumvisible() ? "\<C-n>" : "\<Tab>"]], '')
    qki('<C-k>', [[pumvisible() ? "\<C-p>" : "\<BS>"]], '')

    vim.api.nvim_set_hl(0, 'COQMenuSel', {bg = '#555555', fg = '#ffffff'})
    vim.api.nvim_set_hl(0, 'COQCompletion', {bg = '#333333', fg = '#ffffff'})
    vim.api.nvim_set_hl(0, 'COQSnipSel', {bg = '#444444', fg = '#ffffff'})
    vim.api.nvim_set_hl(0, 'COQSnip', {bg = '#333333', fg = '#ffffff'})
    vim.api.nvim_set_hl(0, 'COQDoc', {bg = '#222222', fg = '#ffffff'})

end
