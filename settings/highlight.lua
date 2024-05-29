
GGlobal.interestingWordsDefaultMappings = 0

GKeymap.set('n', '<M-k>', [[:call InterestingWords('n')<CR>]], GDfgConfig)
GKeymap.set('v', '<M-k>', [[:call InterestingWords('v')<CR>]], GDfgConfig)
GKeymap.set('n', '<M-K>', [[:call UncolorAllWords()<CR>]], GDfgConfig)

GKeymap.set('n', '<M-l>', [[:call WordNavigation(1)<CR>]], GDfgConfig)
GKeymap.set('n', '<M-h>', [[:call WordNavigation(0)<CR>]], GDfgConfig)

GGlobal.interestingWordsGUIColors = {'#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF'}
GGlobal.interestingWordsTermColors = {'154', '121', '211', '137', '214', '222'}
GGlobal.interestingWordsRandomiseColors = 1
