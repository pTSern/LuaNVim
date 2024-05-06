
local tls = require('telescope.builtin')

g_keymap.set('n', "<Leader>ff", tls.find_files, g_default_opts)
g_keymap.set('n', "<Leader>fg", tls.live_grep, g_default_opts)
g_keymap.set('n', "<Leader>fb", tls.buffers, g_default_opts)
g_keymap.set('n', "<Leader>fh", tls.help_tags, g_default_opts)

local plugin = 'Hello World'

local notify = {
    title = plugin,
    on_open = function()
        vim.notify("Attempting recovery.", vim.log.levels.WARN, { title = plugin })

        local timer = vim.loop.new_timer()
        timer:start(2000, 0, function()
            vim.notify( { 'Fixing problem.', 'Plz wait...'}, "info", {
                title = plugin,
                timeout = 3000,
                on_close = function ()
                    vim.notify('Solved', nil, { title = plugin })
                    vim.notify('Error code 0x0395AF', 1, { title = plugin })
                end
            })
        end)
    end
}

