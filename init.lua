
-------------------------------------------------

g_root = vim.fn.expand("~/.config/nvim/")

dofile(g_root .. 'global_vars.lua')

dofile(g_root .. 'initialization/init.lua')
dofile(g_root .. 'settings/init.lua')

----------------------------------------------------
