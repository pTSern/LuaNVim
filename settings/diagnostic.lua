-- Define custom diagnostic signs
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ', -- or '✘'
            [vim.diagnostic.severity.WARN]  = '󰀪 ', -- or '▲'
            [vim.diagnostic.severity.HINT]  = '󰌶 ', -- or '⚑'
            [vim.diagnostic.severity.INFO]  = '󰋽 ', -- or '»'
        },
        -- Keep these as true to retain line highlighting and virtual text
        linehl = false,
        numhl = false,
    },
})
