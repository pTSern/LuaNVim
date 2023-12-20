
g_global.interestingWordsDefaultMappings = 0

g_keymap.set('n', '<M-k>', [[:call InterestingWords('n')<CR>]], g_default_opts)
g_keymap.set('v', '<M-k>', [[:call InterestingWords('n')<CR>]], g_default_opts)
g_keymap.set('n', '<M-K>', [[:call UncolorAllWords()<CR>]], g_default_opts)

g_keymap.set('n', '<M-l>', [[:call WordNavigation(1)<CR>]], g_default_opts)
g_keymap.set('n', '<M-h>', [[:call WordNavigation(0)<CR>]], g_default_opts)

g_global.interestingWordsGUIColors = {'#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF'}
g_global.interestingWordsTermColors = {'154', '121', '211', '137', '214', '222'}
g_global.interestingWordsRandomiseColors = 1
