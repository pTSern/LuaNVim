
--GGlobal.rooter_cd_cmd = 'lcd'

local root = g_root .. 'settings/'
local telescope = require('telescope')
local actions = require('telescope.actions')
local themes = require('telescope.themes')

local function _qdefvert(opt)
    opt = opt or {}

    if opt.previewer == nil then opt.previewer = true end
    opt.mode = opt.mode or "insert"
    opt.sorting = opt.sorting or "descending"
    opt.path_display = opt.path_display or { "truncate" }
    local _height = opt.height or 0.95

    return {
        initial_mode = opt.mode,
        previewer = opt.previewer,
        sorting_strategy = opt.sorting,
        prompt_title = opt.title,
        path_display = opt.path_display,

        layout_strategy = "vertical",
        layout_config = {
            width = opt.width or 0.85,
            height = _height,
            preview_height = opt.preview_height or 0.5,
            prompt_position = "bottom",
            mirror = false,
        }
    }
end

require('telescope').setup {
    defaults = {
        previewer = true,
        layout_strategy = "vertical",
        layout_config = {
            width = 0.85,
            height = 0.95,
            preview_height = 0.5,
            prompt_position = "bottom",
            mirror = false,
        },
        sorting_strategy = "descending",

        -- UI
        prompt_prefix = " ",
        selection_caret = " ",
        color_devicons = true,

        -- Behavior
        file_ignore_patterns = {
            "node_modules",
            ".git/",
            "build/",
            "%.DS_Store",
        },
        path_display = { "truncate" },

        -- Mappings
        mappings = {
            i = {
                ["<C-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
                -- Clear the prompt easily
                -- Scroll preview window up and down
                ["<C-j>"] = actions.preview_scrolling_down,
                ["<C-k>"] = actions.preview_scrolling_up,
            },
            n = {
                ["q"] = actions.close,
                ["<C-j>"] = actions.preview_scrolling_down,
                ["<C-k>"] = actions.preview_scrolling_up,
            }
        },

        -- External tools
        find_command = {
            'fd',
            '--type', 'f',
            '--strip-cwd-prefix',
            '--hidden',
            '--exclude', '.git',
            '--follow',
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob', '!.git/*',
            '--follow',
            '--pcre2',
        },
    },

    pickers = {
        current_buffer_fuzzy_find = _qdefvert{
            previewer = true,
            title = "[ Search ]",
        },
        find_files = _qdefvert{
            previewer = true,
            title = "[ Find Files ]",
        },
        find_buffers = _qdefvert{
            previewer = true,
            title = "[ Buffers ]",
        },
        diagnostics = _qdefvert{
            previewer = true,
            title = "[ Diagnostics ]",
        },
        live_grep = _qdefvert{
            previewer = true,
            title = "[ Live Grep ]",
        },
        marks = _qdefvert{
            previewer = true,
            title = "[ Marks ]",
        },
    },

    extensions = {
        ['ui-select'] = {
            _qdefvert{ previewer = true },
        },
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,   -- override the generic sorter
            override_file_sorter = true,      -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    },
}

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')
pcall(telescope.load_extension, 'project')
pcall(telescope.load_extension, 'file_browser')

dofile(root .. '_telescope.project.lua')
dofile(root .. '_telescope.keymap.lua')
--require('telescope').extensions.project.project{}


