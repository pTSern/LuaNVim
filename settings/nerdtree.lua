local keymap = vim.keymap
--
--
--GGlobal.nerd_tree_tabs_open_on_console_startup = 1
--
--keymap.set('n', '<M-1>', ':NERDTreeToggle<CR>', { silent = true })
--keymap.set('n', '<F1>', ':NERDTreeToggle<CR>', { silent = true })
--keymap.set('x', '<F1>', '<ESC>:NERDTreeToggle<CR>', { silent = true })
--keymap.set('i', '<F1>', '<ESC>:NERDTreeToggle<CR>', { silent = true })
--keymap.set('n', '<M-f>', ':NERDTreeFind<CR>', { silent = true })
--
--vim.g['NERDTreeDirArrowExpandable'] = '★'
--vim.g['NERDTreeDirArrowCollapsible'] = '☆'
--
--vim.g['NERDTreeGitStatusIndicatorMapCustom'] = {
--                 Modified  = '๖',
--                 Staged    = '✚',
--                 Untracked = '✭',
--                 Renamed   = '➤',
--                 Unmerged  = '═',
--                 Deleted   = '✖',
--                 Dirty     = '⟡',
--                 Ignored   = '☒',
--                 Clean     = '✔︎',
--                 Unknown   = '?',
--                 }
--

keymap.set('n', '<M-1>', ':CHADopen<CR>', { silent = true })
keymap.set('n', '<F1>', ':CHADopen<CR>', { silent = true })
keymap.set('x', '<F1>', '<ESC>:CHADopen<CR>', { silent = true })
keymap.set('i', '<F1>', '<ESC>:CHADopen<CR>', { silent = true })

