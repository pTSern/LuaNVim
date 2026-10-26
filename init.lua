-- Reset XDG environment variables so Neovim uses default Windows paths (~/AppData/Local/nvim-data)
vim.env.XDG_DATA_HOME = nil
vim.env.XDG_STATE_HOME = nil
vim.env.XDG_CACHE_HOME = nil

-------------------------------------------------

g_root = vim.fn.expand("~/AppData/Local/nvim/")

dofile(g_root .. 'global_vars.lua')

dofile(g_root .. 'initialization/init.lua')
dofile(g_root .. 'settings/init.lua')

----------------------------------------------------
