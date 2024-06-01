
local cmp = require 'cmp'
local ls = require 'luasnip'

ls.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args) ls.lsp_expand(args.body) end,
    },

    completion = { completeopt = 'menu, menuone, noinsert' },

    mapping = cmp.mapping.preset.insert {
        ['<down>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_next_item(),
        ['<up>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-l>'] = cmp.mapping( function () if ls.expand_or_locally_jumpable() then ls.expand_or_jump() end end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping( function () if ls.locally_jumpable(-1) then ls.jump(-1) end end, { 'i', 's' }),

        ['<C-Leader'] = cmp.mapping.complete {},
    },

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },  {
        { name = 'buffer' },
    })
}

