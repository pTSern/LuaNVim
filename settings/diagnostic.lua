-- Configure signs directly: Neovim 0.12 no longer reads legacy sign_define() icons.
vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN]  = '󰀪 ',
            [vim.diagnostic.severity.HINT]  = '󰌶 ',
            [vim.diagnostic.severity.INFO]  = ' ',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
        },
    },
})
