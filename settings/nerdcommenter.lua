
GGlobal.NERDCreateDefaultMappings = 0

GGlobal.NERDSpaceDelims = 1

GGlobal.NERDCompactSexyComs = 1

GGlobal.NERDDefaultAlign = 'left'

GGlobal.NERDCommentEmptyLines = 1

GGlobal.NERDTrimTrailingWhitespace = 1

GGlobal.NERDToggleCheckAllLines = 1

local map = function(key, func, desc)
    GKeymap.set('n', key, func, GQuickOpt(desc))
end

map('<Leader>/j', "V}:call nerdcommenter#Comment('x', 'toggle')<CR>", '[/] Commenter [J] Down')
map('<Leader>/k', "V{:call nerdcommenter#Comment('x', 'toggle')<CR>", '[/] Commenter [K] Up')

map('<leader>/c', "<Plug>NEREDCommenterComment", '[/] [C]omment')
map('<leader>/t', "<Plug>NEREDCommenterToggle", '[/] [T]oggling commenter')
map('<leader>/a', "<Plug>NEREDCommenterAltDelims", '[/] Commenter [A]lt delims')
map('<leader>/A', "<Plug>NEREDCommenterAppend", '[/] Commenter [*A]ppend')
map('<leader>/b', "<Plug>NEREDCommenterAlignBoth", '[/] Commenter Align [B]oth')
map('<leader>/i', "<Plug>NEREDCommenterInvert", '[/] Commenter [I]nvert')
map('<leader>/l', "<Plug>NEREDCommenterAlignLeft", '[/] Commenter Align [L]eft')
map('<leader>/m', "<Plug>NEREDCommenterMinimal", '[/] Commenter [M]inimal')
map('<leader>/n', "<Plug>NEREDCommenterNested", '[/] Commenter [N]ested')
map('<leader>/s', "<Plug>NEREDCommenterSexy", '[/] Commenter [S]exy')
map('<leader>/u', "<Plug>NEREDCommenterUncomment", '[/] Commenter [U]ncomment')
map('<leader>/y', "<Plug>NEREDCommenterYank", '[/] Commenter [Y]ank')
map('<leader>/$', "<Plug>NEREDCommenterToEOL", '[/] [$] Commenter to end of line')
