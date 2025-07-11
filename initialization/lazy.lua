
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

GOpts.rtp:prepend(lazypath)

-- INSTALL PLUGINS

require("lazy").setup(
    {
        --#region Theme
        {
            "catppuccin/nvim",
            name = "catppuccin",
        },
        --{
        --    "NvChad/base46",
        --    build = function()
        --        --require('base46').loadd_all_highlights()
        --    end
        --},
        --{
        --    'NvChad/ui',
        --    lazy = false,
        --},
        {
            "NvChad/nvim-colorizer.lua",
            event = 'User FilePost',
            opts = {
                user_default_options = { names = false },
                file_types = {
                    '*',
                    "!lazy",
                }
            },
            config = function(_, o)
                require('colorizer').setup(o)

                vim.defer_fn( function()
                    require('colorizer').attach_to_buffer(0)
                end, 0
                )
            end
        },
        --Web devicons
        --"ryanoasis/vim-devicons",                                       -- Provide beauty icons
        {
            "nvim-tree/nvim-web-devicons",                                  -- Other plugins for beauty icons
            --opts = function()
            --    dofile(GGlobal.base46_cache .. 'devicons')
            --    return { override = require 'nvchad.icons.devicons' }
            --end,
        },

        {
          'echasnovski/mini.nvim',
          config = function()
            -- Better Around/Inside textobjects
            require('mini.ai').setup { n_lines = 500 }
            require('mini.surround').setup()
            require('mini.icons').setup()
          end,
        },
        'echasnovski/mini.ai',
        'echasnovski/mini.surround',
        'echasnovski/mini.icons',
        'echasnovski/mini.deps',



        {
            'lukas-reineke/indent-blankline.nvim',
            event = "User FilePost",
            opts = {
                indent = { char = "│", highlight = "IblChar" },
                scope = { char = "│", highlight = "IblScopeChar" }
            },
            config = function(_, opts)
                --dofile(GGlobal.base46_cache .. 'blankline')

                local hook = require('ibl.hooks')
                hook.register(hook.type.WHITESPACE, hook.builtin.hide_first_space_indent_level)
                require('ibl').setup(opts)

                --dofile(GGlobal.base46_cache .. 'blankline')
            end
        },
        --#endregion




        --#region Transparent
        {
            --'tribela/vim-transparent',
            'xiyaowong/transparent.nvim',
            lazy = false
        },
        --#endregion

        --#region File manager
        {
            --"preservim/nerdTree",                                                                                                                                                                                                                           -- File manager
            'ms-jpq/chadtree',
            branch = 'chad',
            build = 'python3 -m chadtree deps',

        },
        --#endregion

        --#region Dianostics
        {
            "folke/trouble.nvim",
            opts = {},
            cmd = "Trouble"
        },
        --#endregion

        --#region Status line
        --"vim-airline/vim-airline",                                                                                                                                                                                                                      -- Status bar
        --"vim-airline/vim-airline-themes",                                                                                                                                                                                                               -- Theme for status bar
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            }
        },
        --#endregion

        --#region Auto-pair code
        "LunarWatcher/auto-pairs",                                                                                                                                                                                                                      -- Auto Pairs
        --#endregion

        --#region Quick comment
        "preservim/nerdcommenter",                                                                                                                                                                                                                      -- Commenter of nerdTree
        --#endregion

        --#region Todo
        {
            "SyedAsimShah1/quick-todo.nvim",
            config = function()
                require("quick-todo").setup(
                    {
                        keys = {
                            open = "<leader>td"
                        },
                        window = {
                            height = 0.75,
                            width = 0.95,
                            windblend = 1,
                            border = "rounded",
                        }
                    }
                )
            end
        },
        --#endregion

        --#region Coc-vim (Now using LSP client instead)
        -- {
        --     "neoclide/coc.nvim",
        --     branch = "release"
        -- },                                                                                                                                                                                                    -- Language Server for faster code
        -- "rafcamlet/coc-nvim-lua",                                                                                                                                                                                                                       -- Lua server
        --#endregion

        --#region Searching
        "lfv89/vim-interestingwords",
        "nvim-pack/nvim-spectre",
        --#endregion

        --#region Floating terminal
        "voldikss/vim-floaterm",                                                                                                                                                                                                                        -- Float terminal
        --{
        --    "nvzone/floaterm",
        --    dependencies = "nvzone/volt",
        --    cmd = "FloatermToggle",
        --    opts = {},
        --},
        --#endregion

        --#region Tab manager
        {
            'romgrk/barbar.nvim',
            dependencies = {

                'nvim-tree/nvim-web-devicons'
            }, init = function() vim.g.barbar_auto_setup = false end,
            opts = {}
        },                                                                            -- Manager buffer tab
        --#endregion

        --#region Show which key
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            --config = function(_, opts)
            --    dofile(GGlobal.base46_cache .. 'whichkey')
            --    require('which-key').setup(opts)
            --end,
            opts = {
                plugins = {
                  marks = true, -- shows a list of your marks on ' and `
                  registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                  -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                  -- No actual key bindings are created
                  spelling = {
                    enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                  },
                  presets = {
                    operators = true, -- adds help for operators like d, y, ...
                    motions = true, -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = true, -- default bindings on <c-w>
                    nav = true, -- misc bindings to work with windows
                    z = true, -- bindings for folds, spelling and others prefixed with z
                    g = true, -- bindings for prefixed with g
                  },
                },

                layout = {
                  height = { min = 4, max = 25 }, -- min and max height of the columns
                  width = { min = 20, max = 50 }, -- min and max width of the columns
                  spacing = 3, -- spacing between columns
                  align = "left", -- align columns left, center or right
                },

                sort = { "local", "order", "group", "alphanum", "mod" },

                expand = 0,

                replace = {
                  key = {
                    function(key)
                      return require("which-key.view").format(key)
                    end,
                  },
                  desc = {
                    { "<Plug>%(?(.*)%)?", "%1" },
                    { "^%+", "" },
                    { "<[cC]md>", "" },
                    { "<[cC][rR]>", "" },
                    { "<[sS]ilent>", "" },
                    { "^lua%s+", "" },
                    { "^call%s+", "" },
                    { "^:%s*", "" },
                    { "<[lL]eader>", "'␣'"},
                    { "<[sS]pace>", "'␣'"},
                  },
                },


                show_help = true,
                show_keys = true,

                disable = {
                  ft = {},
                  bt = {},
                },

                debug = false,

                keys = {
                  scroll_down = "<c-j>", -- binding to scroll down inside the popup
                  scroll_up = "<c-k>", -- binding to scroll up inside the popup
                },
                icons = {
                  breadcrumb = " » ", -- symbol used in the command line area that shows your active key combo
                  separator = "| ", -- symbol used between a key and it's label
                  group = "➤ ", -- symbol prepended to a group
                  ellipsis = "…",
                  mappings = true,
                  rules = {},
                  colors = true,
                  keys = {
                    Up = "",
                    Down = "",
                    Left = "",
                    Right = "",
                    CR = "⏎",
                    Esc = "X",
                    ScrollWheelDown = "⬇️",
                    ScrollWheelUp = "⬆️",
                    BS = "⌫",
                    Space = "'␣'",
                    Tab = "⇥",
                    NL = "@"
                  },
                },
            }
        },                                                                                                                                                    -- Display key mapping helper
        --#endregion

        --#region Support for Lua
        "nvim-lua/plenary.nvim",
        --#endregion

        --#region Better FZF 
        {
            'nvim-telescope/telescope.nvim',
            event = 'VimEnter',
            branch = '0.1.x',
            dependencies = {
                'nvim-lua/plenary.nvim',
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    build = 'make',
                    cond = function () return vim.fn.executable 'make' == 1 end
                },
                'nvim-telescope/telescope-ui-select.nvim',
                'nvim-telescope/telescope-project.nvim',
                "nvim-telescope/telescope-file-browser.nvim"
            }
        },
        --{
        --    "cljoly/telescope-repo.nvim"
        --},
        -- Searching all files Like CRT-SHIFT-F
        --#endregion

        --#region LSP-Config
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                'williamboman/mason.nvim', -- NOTE: Must be loaded before dependants
                "williamboman/mason-lspconfig.nvim",
                'WhoIsSethDaniel/mason-tool-installer.nvim',
                'j-hui/fidget.nvim',
                'folke/neodev.nvim',
            },
            config = function ()
            end
        },

        --#endregion


        --#region Auto Completion
        --{
        --    'ms-jpq/coq_nvim',
        --    branch = 'coq',
        --    run = ':COQdeps',

        --    dependencies = {
        --        "neovim/nvim-lspconfig",
        --        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        --        { "ms-jpq/coq.thirdparty", branch = "3p" },
        --    },

        --    init = function()
        --        vim.g.coq_settings = {
        --            auto_start = true

        --        }
        --    end,
        --    --config = function ()
        --    --    require("coq").setup {

        --    --    }
        --    --end,

        --},
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            dependencies = {
                {
                    'L3MON4D3/LuaSnip',
                    build = (function()
                      -- Build Step is needed for regex support in snippets.
                      -- This step is not supported in many windows environments.
                      -- Remove the below condition to re-enable on windows.
                      if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                      end
                      return 'make install_jsregexp'
                    end)(),
                    dependencies = {},
                },
                'saadparwaiz1/cmp_luasnip',

                -- Adds other completion capabilities.
                --  nvim-cmp does not ship with all sources by default. They are split
                --  into multiple repos for maintenance purposes.
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-buffer',
                "hrsh7th/cmp-cmdline",
            },
        },
        {
            "lukas-reineke/cmp-under-comparator"
        },
        --#endregion

        --#region Paser generator tool
        {
            'nvim-treesitter/nvim-treesitter',
            branch = 'main',
            build   = ":TSUpdate",
            opts    = {
                ensure_install  = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'typescript', 'javascript', 'vue', 'css', 'cmake', 'cpp', 'c', 'c_sharp', 'json', 'comment'},
                auto_install    = true,
                highlight       = {
                    enable          = true,
                },
                indent = { enable = true }
            },
            config = function(_, opts)
                require('nvim-treesitter.install').prefer_git = true
                require('nvim-treesitter.configs').setup(opts)
            end
        },
        --#endregion

        --#region Markdown previewer
        {
            "iamcco/markdown-preview.nvim",
             cmd = {
                "MarkdownPreviewToggle",
                "MarkdownPreview",
                "MarkdownPreviewStop"
            },
            build = "cd app && yarn install",
            init = function() vim.g.mkdp_filetypes = { "markdown" } end,
            ft = { "markdown" }
        },

        --#region CSharp
        {
            "tris203/rzls.nvim"
        },
        {
            "seblj/roslyn.nvim",
            ft = "cs",
            opts = {
                -- your configuration comes here; leave empty for default settings
            }
        },
        --'OmniSharp/omnisharp-vim',                                                                                                                                                                                                                      -- Language server for CSharp
        --{
        --    "iabdelkareem/csharp.nvim",
        --    dependencies = {
        --        "mfussenegger/nvim-dap",
        --        "Tastyep/structlog.nvim",
        --    },

        --    config = function ()
        --        require("mason").setup()
        --        require("csharp").setup()
        --    end
        --},
        --#endregion
        'sheerun/vim-polyglot',
        {
            'utilyre/barbecue.nvim',
            name = "barbecue",
            version = "*",
            dependencies = {
                "SmiteshP/nvim-navic",
                "nvim-tree/nvim-web-devicons" }
        },
        {
          "folke/flash.nvim",
          event = "VeryLazy",
          opts = {},
          keys = {
            { "M-right", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { ">", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "M-left", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "<", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-.>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
          },
        },
        'rcarriga/nvim-notify',
        --#region Auto formating code
        {
          'stevearc/conform.nvim',
          lazy = false,
          keys = {
            {
              '<leader>fb',
              function()
                require('conform').format { async = true, lsp_fallback = true }
              end,
              mode = '',
              desc = '[F]ormat [B]uffer',
            },
          },
          opts = {
            notify_on_error = false,
            formatters_by_ft = {
              lua = { 'stylua' },
              -- Conform can also run multiple formatters sequentially
              -- python = { "isort", "black" },
              --
              -- You can use a sub-list to tell conform to run *until* a formatter
              -- is found.
              javascript = { { "prettierd", "prettier" } },
            },
          },
        },
        --#endregion

        --#region Typescript
        --{
        --    "pmizio/typescript-tools.nvim",
        --    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        --    opts = {},
        --},
        --#endregion

        --#region GPT Model
        --{
        --    "robitx/gp.nvim",
        --},
        --{
        --    "Aaronik/GPTModels.nvim",
        --    dependencies = {
        --        "MunifTanjim/nui.nvim",
        --        "nvim-telescope/telescope.nvim"
        --    }
        --},
        --#endregion

        --#region LSP-Saga
        --{
        --    'nvimdev/lspsaga.nvim',
        --    config = function()
        --        require('lspsaga').setup({})
        --    end,
        --},
        --#endregion

        --#region
        {
            'nvimdev/dashboard-nvim',
            event = 'VimEnter',
            config = function ()
                require('dashboard').setup {

                }
            end
        },
        --#endregion

        --#region Git
        {
            'lewis6991/gitsigns.nvim',
            event = "User FilePost",
            --opts = function()
            --    return require('nvchad.configs.gitsigns')
            --end,
        },
        -- Neogit provide git interface for easily contact with git
        {
            "NeogitOrg/neogit",
            dependencies = {
              "nvim-lua/plenary.nvim",         -- required
              "sindrets/diffview.nvim",        -- optional - Diff integration
              -- Only one of these is needed, not both.
              "nvim-telescope/telescope.nvim", -- optional
            },
            config = true
        },

        -- Git-Blame indicator when is the last commited, description and who
        {
            'f-person/git-blame.nvim'
        },

        {
            'akinsho/git-conflict.nvim',
            version = "*",
            config = true,
            opts = {
                default_mappings = false,
                default_commands = true,
                disable_diagnostics = false,
                list_opener = 'copen',
                highlight = {
                    incoming = 'DiffAdd',
                    current = 'DiffText',
                }
            }
        },
        --#endregion

        --#region TMUX enhance workspace
        --{
        --    "aserowy/tmux.nvim",
        --}
        --#endregion

        --#region Project Manager
        --{
        --    "pluffie/neoproj",
        --    cmd = { "ProjectOpen", "ProjectNew" },
        --},
        --#endregion

        --#region Flutter
        {
            'akinsho/flutter-tools.nvim',
            lazy = false,
            dependencies = {
                'nvim-lua/plenary.nvim',
                'stevearc/dressing.nvim', -- optional for vim.ui.select
            },
            config = true,
        },
        --#endregion

        --#region AI
        {
            'github/copilot.vim'
        },
        {
            "CopilotC-Nvim/CopilotChat.nvim",
        },

        --#region Key Displaying
        {
            "NStefan002/screenkey.nvim",
            lazy = false,
            version = "*", -- or branch = "dev", to use the latest commit
        },
        --#endregion
        {
            'barrett-ruth/live-server.nvim',
            build = 'pnpm add -g live-server',
            cmd = { 'LiveServerStart', 'LiveServerStop' },
            config = true
        },

        --{
        --    'folke/edgy.nvim',
        --    event = "VeryLazy",
        --    opts = function(_, opts)
        --        opts.top = opts.top or {}
        --        table.insert(opts.top, {
        --            ft = 'copilot-chat',
        --            title = " ︻┳デpTSCopilot]═—— ",
        --            size = { width = 0.95, height = 0.85 }
        --        })

        --        opts.animate = {
        --          enabled = true,
        --          fps = 100, -- frames per second
        --          cps = 120, -- cells per second
        --          on_begin = function()
        --            vim.g.minianimate_disable = true
        --          end,
        --          on_end = function()
        --            vim.g.minianimate_disable = false
        --          end,
        --          -- Spinner for pinned views that are loading.
        --          -- if you have noice.nvim installed, you can use any spinner from it, like:
        --          -- spinner = require("noice.util.spinners").spinners.circleFull,
        --          spinner = {
        --            frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        --            interval = 80,
        --          },
        --        }

        --    end,
        --},
    }
)

