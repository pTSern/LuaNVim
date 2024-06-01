
GGlobal.interestingWordsDefaultMappings = 0

GKeymap.set('n', '<M-k>', [[:call InterestingWords('n')<CR>]], GDfgConfig)
GKeymap.set('v', '<M-k>', [[:call InterestingWords('v')<CR>]], GDfgConfig)
GKeymap.set('n', '<M-K>', [[:call UncolorAllWords()<CR>]], GDfgConfig)

GKeymap.set('n', '<M-l>', [[:call WordNavigation(1)<CR>]], GDfgConfig)
GKeymap.set('n', '<M-h>', [[:call WordNavigation(0)<CR>]], GDfgConfig)

GGlobal.interestingWordsGUIColors = {
    '#FFFFFF',
    '#C0C0C0',
    '#808080',
    '#FF0000',
    '#800000',
    '#FFFF00',
    '#808000',
    '#00FF00',
    '#008000',
    '#00FFFF',
    '#008080',
    '#0000FF',
    '#000080',
    '#FF00FF',
    '#800080'
}
GGlobal.interestingWordsTermColors = {'154', '121', '211', '137', '214', '222'}
GGlobal.interestingWordsRandomiseColors = 1
