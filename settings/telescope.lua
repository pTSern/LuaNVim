
local root = g_root .. 'settings/'
local telescope = require('telescope')
local actions = require('telescope.actions')
local themes = require('telescope.themes')

local function _qdefvert(opt)
    opt = opt or {}

    if opt.previewer == nil then opt.previewer = true end
    if opt.mirror == nil then opt.mirror = true end

    opt.height = opt.height or 0.9
    opt.width = opt.width or 0.85
    opt.mode = opt.mode or "insert"
    opt.layout = opt.layout or "vertical"
    opt.sorting = opt.sorting or "descending"
    opt.position = opt.position or "bottom"

    opt.percent = opt.percent or {
        preview = 0.75,
        results = 0.25,
    }

    return {
        initial_mode = opt.mode,
        previewer = opt.previewer,
        layout_strategy = opt.layout,
        sorting_strategy = opt.sorting,
        prompt_title = opt.title,

        layout_config = {
            width = opt.width,
            height = opt.height,
            vertical = {
                preview_height = opt.height * opt.percent.preview,
                results_height = opt.height * opt.percent.results,

                mirror = opt.mirror,
                prompt_position = opt.position,
            }
        }
    }
end

require('telescope').setup {
    defaults = {
        -- UI
        prompt_prefix = " ",
        selection_caret = " ",
        color_devicons = true,

        -- Layout

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

        -- ripgrep
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
        },
    },

    pickers = {
        current_buffer_fuzzy_find = _qdefvert{ height = 0.75, previewer = false, title = "[ Search ]" },
        find_files = _qdefvert{ height = 0.75, title = "[ Find Files ]", percent = { preview = 0.65, results = 0.35 }, mirror = false },
        find_buffers = _qdefvert{ height = 0.75, previewer = true, title = "[ Buffers ]" , percent = { preview = 0.5, results = 0.5 }},
        diagnostics = _qdefvert{ height = 0.9, previewer = true, title = "[ Diagnostics ]" , percent = { preview = 0.6, results = 0.4 }, mirror = false },
        live_grep = {
            initial_mode = "insert",
            theme = "ivy",
        },
    },

    extensions = {
        ['ui-select'] = {
            themes.get_dropdown(),
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

dofile(root .. '_telescope.project.lua')
dofile(root .. '_telescope.keymap.lua')
--require('telescope').extensions.project.project{}


