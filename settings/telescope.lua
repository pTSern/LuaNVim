
local tls = require('telescope.builtin')

g_keymap.set('n', "<Leader>ff", tls.find_files, g_default_opts)
g_keymap.set('n', "<Leader>fg", tls.live_grep, g_default_opts)
g_keymap.set('n', "<Leader>fb", tls.buffers, g_default_opts)
g_keymap.set('n', "<Leader>fh", tls.help_tags, g_default_opts)
