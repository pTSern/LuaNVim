local keymap = vim.keymap

keymap.set('n', '<M-1>', ':NERDTreeToggle<CR>', { silent = true })
keymap.set('n', '<M-f>', ':NERDTreeFind<CR>', { silent = true })
keymap.set('n', '<F1>', ':NERDTreeToggle<CR>', { silent = true })

vim.g['NERDTreeDirArrowExpandable'] = '▸'
vim.g['NERDTreeDirArrowCollapsible'] = '▾'

vim.g['NERDTreeGitStatusIndicatorMapCustom'] = {
                 Modified  = '✹',
                 Staged    = '✚',
                 Untracked = '✭',
                 Renamed   = '➜',
                 Unmerged  = '═',
                 Deleted   = '✖',
                 Dirty     = '✗',
                 Ignored   = '☒',
                 Clean     = '✔︎',
                 Unknown   = '?',
                 }
