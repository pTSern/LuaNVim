
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
        "NvChad/nvim-colorizer.lua",
        --#endregion

        --#region Mini
        {
          'echasnovski/mini.nvim',
          config = function()
            -- Better Around/Inside textobjects
            require('mini.ai').setup { n_lines = 500 }
            require('mini.surround').setup()
          end,
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
            build = 'python3 -m chadtree deps'

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
        "vim-airline/vim-airline",                                                                                                                                                                                                                      -- Status bar
        "vim-airline/vim-airline-themes",                                                                                                                                                                                                               -- Theme for status bar
        --#endregion

        --#region Auto-pair code
        "LunarWatcher/auto-pairs",                                                                                                                                                                                                                      -- Auto Pairs
        --#endregion

        --#region Quick comment
        "preservim/nerdcommenter",                                                                                                                                                                                                                      -- Commenter of nerdTree
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
        --#endregion

        --#region Web devicons
        --"ryanoasis/vim-devicons",                                       -- Provide beauty icons
        "nvim-tree/nvim-web-devicons",                                  -- Other plugins for beauty icons
        --#endregion

        --#region Tab manager
        {
            'romgrk/barbar.nvim',
            dependencies = {
                'lewis6991/gitsigns.nvim',
                'nvim-tree/nvim-web-devicons'
            }, init = function() vim.g.barbar_auto_setup = false end,
            opts = {}
        },                                                                            -- Manager buffer tab
        --#endregion

        --#region Show which key
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            init = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 30
            end, opts = {}
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
            --lazy = false,
            dependencies = {
                { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants

                "williamboman/mason-lspconfig.nvim",
                'WhoIsSethDaniel/mason-tool-installer.nvim',
                { 'j-hui/fidget.nvim', opts = {} },
                { 'folke/neodev.nvim', opts = {} },
            },

            config = function()
            end,
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
            },
        },
        {
            "lukas-reineke/cmp-under-comparator"
        },
        --#endregion

        --#region Paser generator tool
        {
            'nvim-treesitter/nvim-treesitter',
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
        'OmniSharp/omnisharp-vim',                                                                                                                                                                                                                      -- Language server for CSharp
        {
            "iabdelkareem/csharp.nvim",
            dependencies = {
                "mfussenegger/nvim-dap",
                "Tastyep/structlog.nvim",
            },

            config = function ()
                require("mason").setup()
                require("csharp").setup()
            end
        },
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
        {
            "pmizio/typescript-tools.nvim",
            dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
            opts = {},
        },
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

        --#region Git-Blame indicator when is the last commited, description and who
        {
            'f-person/git-blame.nvim'
        },
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

        --#region Neogit provide git interface for easily contact with git
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
                'stevearc/dressing.nvim'
            },
            config = true
        }
        --#endregion
    }
)

