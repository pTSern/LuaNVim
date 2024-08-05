
GKeymap.set('n', '<Leader><Leader>t', ":FloatermToggle<CR>", GQuickOpt('[ ] floaterm [T]oggle'))
GKeymap.set('t', '<Leader><Leader>t', "<C-\\><C-n>:FloatermToggle<CR>", GQuickOpt('[ ] floaterm [T]oggle'))

GKeymap.set('n', '<F8>', ":FloatermToggle<CR>", GDfgConfig)
GKeymap.set('t', '<F8>', "<C-\\><C-n>:FloatermToggle<CR>", GDfgConfig)

vim.g.floaterm_position = 'top'
vim.g.floaterm_width = 0.95
vim.g.floaterm_height = 0.75
vim.g.floaterm_title = 'Terminal $1/$2'
vim.g.floaterm_wintype = 'float'
vim.g.floaterm_rootmarkers = {'.pro'}
