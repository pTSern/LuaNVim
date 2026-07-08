local keymap = vim.keymap

keymap.set('n', '<M-1>', ':CHADopen<CR>', { silent = true })
keymap.set('n', '<F1>', ':CHADopen<CR>', { silent = true })
keymap.set('x', '<F1>', '<ESC>:CHADopen<CR>', { silent = true })
keymap.set('i', '<F1>', '<ESC>:CHADopen<CR>', { silent = true })

-- Enable horizontal cursor line highlighter when focusing CHADTree, and disable it when leaving.
local group = vim.api.nvim_create_augroup("CHADTreeCursorLine", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    group = group,
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "CHADTree" then
            vim.wo.cursorline = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
    group = group,
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "CHADTree" then
            vim.wo.cursorline = false
        end
    end,
})
