
--GGlobal.rooter_cd_cmd = 'lcd'

require('telescope').setup {
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_cursor(),
        },
        --repo = {
        --    list = {
        --        fd_opts = {
        --            '--no-ignore-vcs',
        --        },
        --        search_dirs = {
        --            "~/my_projects"
        --        }
        --    }
        --}
    },
}

local tls = require('telescope.builtin')

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'project')
--require('telescope').extensions.project.project{}

local qs = _G.qnmap

qs("<Leader>ff", tls.find_files, "[F]ind [F]iles")
qs("<Leader>fg", tls.live_grep, "[F]ind [L]ive Grep")
qs("<Leader>fb", tls.buffers, "[F]ind existing [B]uffers")
qs("<Leader>fh", tls.help_tags, "[F]ind [H]elp")
qs("<Leader>fk", tls.keymaps, "[F]ind [K]eymaps")
qs("<Leader>fr", tls.resume, "[F]ind [R]esume")
qs("<Leader>fs", tls.builtin, "[F]ind [S]elect Telescope")
qs("<Leader>fw", tls.grep_string, "[F]ind current [W]ord")
qs("<Leader>fd", tls.diagnostics, "[F]ind [D]iagnostics")
qs("<Leader>fo", tls.oldfiles, "[F]ind [O]ldfiles")
qs("<Leader>fu", tls.lsp_references, "[F]ind [U]sage")
qs("<Leader>fm", tls.marks, "[F]ind [M]arks")
qs("<Leader>fp", tls.pickers, "[F]ind [P]ickers")
qs("<Leader>fj", tls.jumplist, "[F]ind [J]umplist")
qs("<Leader>fx", tls.quickfix, "[F]ind quick fi[X]")
qs("<Leader>fz", tls.quickfixhistory, "[F]ind quick fix history [Z]")

qs("<Leader>gc", tls.git_commits, "[G]it [C]ommits")
qs("<Leader>gs", tls.git_status, "[G]it [S]tatus")
qs("<Leader>gh", tls.git_stash, "[G]it stas[H]")
qs("<Leader>gb", tls.git_branches, "[G]it [B]ranches")
qs("<Leader>gf", tls.git_files,  '[G]it [F]iles' )

qs("<Leader>pm", [[:Telescope project <CR>]],  '[P]roject [M]anager' )

qs("<Leader>\\", function () tls.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {windblend = 10, preview = true}) end, '[\\] Fuzzily search in current buffer')
qs("<Leader>fG", function () tls.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end, '[F]ind Live [*G]rep in Open Files')
qs("<Leader>fv", function () tls.find_files { cwd = vim.fn.stdpath 'config' } end, '[F]ind Neo[V]im files')

qs("<Leader>vc", function ()
    tls.find_files {
        prompt_title = "< Nvim CFG >",
        cwd = vim.fn.stdpath('config'),
        find_command = { 'rg', '--files', '--hidden', '--glob', '!.git' }
    }
end, 'Find [V]im [C]onfig File')

--require('telescope').load_extension'repo'

