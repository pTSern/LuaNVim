
local telescope = require('telescope');
local actions = require("telescope._extensions.project.actions");

telescope.setup {
    extensions = {
        project = {
            ignore_missing_dirs = true,
            hidden_files = true,
            theme = "dropdown",
            search_by = "title",
            order_by = "asc",
            sync_with_nvim_tree = true,
            on_project_selected = function(prompt_bufnr)
                actions.change_working_directory(prompt_bufnr, true)
            end,

            mappings = {
                n = {
                    ["<C-d>"] = actions.delete_project,
                    ["<C-a>"] = actions.add_project,
                    ['d'] = actions.delete_project,
                    ['r'] = actions.rename_project,
                    ['c'] = actions.add_project,
                    ['C'] = actions.add_project_cwd,
                    ['f'] = actions.find_project_files,
                    ['b'] = actions.browse_project_files,
                    ['s'] = actions.search_in_project_files,
                    ['R'] = actions.recent_project_files,
                    ['w'] = actions.change_working_directory,
                    ['o'] = actions.next_cd_scope,
                },
                i = {
                    ['<C-d>'] = actions.delete_project,
                    ['<C-v>'] = actions.rename_project,
                    ['<C-a>'] = actions.add_project,
                    ['<C-A>'] = actions.add_project_cwd,
                    ['<C-f>'] = actions.find_project_files,
                    ['<C-b>'] = actions.browse_project_files,
                    ['<C-s>'] = actions.search_in_project_files,
                    ['<C-r>'] = actions.recent_project_files,
                    ['<C-l>'] = actions.change_working_directory,
                    ['<C-o>'] = actions.next_cd_scope,
                }
            }
        }
    }

}

local _func = function()
    telescope.extensions.project.project {
        theme = "dropdown",
        display_type = "full",
        layout_config = {
            width = 0.75,
            height = 0.75,
        },
        hide_workspace = true,
    }
end
vim.keymap.set("n", "<Leader>pm", _func, { desc = '[P]roject [P]ick' })
vim.keymap.set("n", "<Leader>fp", _func, { desc = '[F]in [P]roject' })
