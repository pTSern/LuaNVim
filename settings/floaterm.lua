
g_keymap.set('n', '<Leader><Leader>t', ":FloatermToggle<CR>", g_default_opts)
g_keymap.set('t', '<Leader><Leader>t', "<C-\\><C-n>:FloatermToggle<CR>", g_default_opts)

g_keymap.set('n', '<F8>', ":FloatermToggle<CR>", g_default_opts)
g_keymap.set('t', '<F8>', "<C-\\><C-n>:FloatermToggle<CR>", g_default_opts)

vim.g.floaterm_position = 'topright'
vim.g.floaterm_width = 0.6
vim.g.floaterm_height = 0.6
vim.g.floaterm_title = 'Terminal $1/$2'
vim.g.floaterm_wintype = 'float'
vim.g.floaterm_rootmarkers = {'.pro'}
