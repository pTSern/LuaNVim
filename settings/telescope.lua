
local root = g_root .. 'settings/'
local actions = require('telescope.actions')
local themes = require('telescope.themes')

local function _qdefvert(opt)
    opt = opt or {}

    local show_preview = true
    if opt.previewer ~= nil then show_preview = opt.previewer end

    return {
        initial_mode = opt.mode or "insert",
        previewer = show_preview,
        layout_strategy = opt.layout or "vertical",
        sorting_strategy = opt.sorting or "descending",
        prompt_title = opt.title,
        theme = opt.theme or "dropdown",
        mirror = opt.mirror ~= nil and opt.mirror or true,

        layout_config = {
            width = opt.width or 0.85,
            height = opt.height or 0.9,
            vertical = {
                preview_height = opt.percent and opt.percent.preview or 0.65,
                prompt_position = opt.position or "bottom",
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
        find_files = _qdefvert{ height = 0.9, title = "[ Find Files ]", percent = { preview = 0.65, results = 0.35 }, mirror = true },
        find_buffers = _qdefvert{ height = 0.5, previewer = true, title = "[ Buffers ]" , percent = { preview = 0.5, results = 0.5 }},
        diagnostics = _qdefvert{ height = 0.9, previewer = true, title = "[ Diagnostics ]" , percent = { preview = 0.6, results = 0.4 }, mirror = true },
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

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'fzy_native')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'project')
pcall(require('telescope').load_extension, 'telescope-themes')

dofile(root .. '_telescope.project.lua')
dofile(root .. '_telescope.keymap.lua')



