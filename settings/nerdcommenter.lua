
GGlobal.NERDCreateDefaultMappings = 1

GGlobal.NERDSpaceDelims = 1

GGlobal.NERDCompactSexyComs = 1

GGlobal.NERDDefaultAlign = 'left'

GGlobal.NERDCommentEmptyLines = 1

GGlobal.NERDTrimTrailingWhitespace = 1

GGlobal.NERDToggleCheckAllLines = 1

GKeymap.set('n', '<Leader>cj', "V}:call nerdcommenter#Comment('x', 'toggle')<CR>", GQuickOpt('[C]ommenter [j] Down'))
GKeymap.set('n', '<Leader>ck', "V{:call nerdcommenter#Comment('x', 'toggle')<CR>", GQuickOpt('[C]ommenter [k] Up'))

