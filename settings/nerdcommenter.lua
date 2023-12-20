
g_global.NERDCreateDefaultMappings = 1

g_global.NERDSpaceDelims = 1

g_global.NERDCompactSexyComs = 1

g_global.NERDDefaultAlign = 'left'

g_global.NERDCommentEmptyLines = 1

g_global.NERDTrimTrailingWhitespace = 1

g_global.NERDToggleCheckAllLines = 1

g_keymap.set('n', '<Leader>cm', "V}:call nerdcommenter#Comment('x', 'toggle')<CR>", g_default_opts)
g_keymap.set('n', '<Leader>cM', "V{:call nerdcommenter#Comment('x', 'toggle')<CR>", g_default_opts)

