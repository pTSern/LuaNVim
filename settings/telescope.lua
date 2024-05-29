require('telescope').setup {
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
        },
    },
}

local tls = require('telescope.builtin')

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

GKeymap.set('n', "<Leader>ff", tls.find_files, { desc = '[F]ind [F]iles' })
GKeymap.set('n', "<Leader>fg", tls.live_grep, { desc = '[F]ind Live [G]rep' })
GKeymap.set('n', "<Leader>fb", tls.buffers, { desc = '[F]ind existing [B]uffers' })
GKeymap.set('n', "<Leader>fh", tls.help_tags, { desc = '[F]ind [H]elp' })
GKeymap.set('n', "<Leader>fk", tls.keymaps, { desc = '[F]ind [K]eymaps' })
GKeymap.set('n', "<Leader>fr", tls.resume, { desc = '[F]ind [R]esume' })
GKeymap.set('n', "<Leader>fs", tls.builtin, { desc = '[F]ind [S]elect Telescope' })
GKeymap.set('n', "<Leader>fw", tls.grep_string, { desc = '[F]ind current [W]ord' })
GKeymap.set('n', "<Leader>fd", tls.diagnostics, { desc = '[F]ind [D]iagnostics' })
GKeymap.set('n', "<Leader>fo", tls.oldfiles, { desc = '[F]ind [O]ldfiles' })

GKeymap.set('n', "<Leader>\\", function () tls.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {windblend = 10, preview = true}) end, {desc = '[\\] Fuzzily search in current buffer'})
GKeymap.set('n', "<Leader>fG", function () tls.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end, { desc = '[F]ind Live [*G]rep in Open Files' })
GKeymap.set('n', "<Leader>fv", function () tls.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[F]ind Neo[V]im files'} )

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

