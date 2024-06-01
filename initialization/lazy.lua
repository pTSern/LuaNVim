
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
        { "catppuccin/nvim", name = "catppuccin" },                                                                                                                                                                                                     -- Main theme

        { -- Collection of various small independent plugins/modules
          'echasnovski/mini.nvim',
          config = function()
            -- Better Around/Inside textobjects
            require('mini.ai').setup { n_lines = 500 }
            require('mini.surround').setup()
          end,
        },
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
            },
        },
        --'tribela/vim-transparent',
        "preservim/nerdTree",                                                                                                                                                                                                                           -- File manager
        "vim-airline/vim-airline",                                                                                                                                                                                                                      -- Status bar
        "vim-airline/vim-airline-themes",                                                                                                                                                                                                               -- Theme for status bar
        "jackguo380/vim-lsp-cxx-highlight",                                                                                                                                                                                                             -- Cpp hightligh
        "LunarWatcher/auto-pairs",                                                                                                                                                                                                                      -- Auto Pairs
        "preservim/nerdcommenter",                                                                                                                                                                                                                      -- Commenter of nerdTree
        -- {
        --     "neoclide/coc.nvim",
        --     branch = "release"
        -- },                                                                                                                                                                                                    -- Language Server for faster code
        -- "rafcamlet/coc-nvim-lua",                                                                                                                                                                                                                       -- Lua server
        "lfv89/vim-interestingwords",                                                                                                                                                                                                                   -- Searching and highlight word with different color.
        "Xuyuanp/nerdtree-git-plugin",                                                                                                                                                                                                                  -- Git status for nerdTree
        "voldikss/vim-floaterm",                                                                                                                                                                                                                        -- Float terminal
        "jreybert/vimagit",                                             -- Git status 
        "ryanoasis/vim-devicons",                                       -- Provide beauty icons
        "nvim-tree/nvim-web-devicons",                                  -- Other plugins for beauty icons
        {
            'romgrk/barbar.nvim',
            dependencies = {
                'lewis6991/gitsigns.nvim',
                'nvim-tree/nvim-web-devicons'
            }, init = function() vim.g.barbar_auto_setup = false end,
            opts = {}
        },                                                                            -- Manager buffer tab
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            init = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 30
            end, opts = {} },                                                                                                                                                    -- Display key mapping helper
        "nvim-lua/plenary.nvim",
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
            }
        },                                                                                                                                                   -- Searching all files Like CRT-SHIFT-F
        {
            "neovim/nvim-lspconfig",
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
        },              -- Live Markdown file
            'OmniSharp/omnisharp-vim',                                                                                                                                                                                                                      -- Language server for CSharp
        {
            'barrett-ruth/live-server.nvim',
            build = 'yarn global add live-server',
            config = true 
        },                                                                                                                                                       -- Live server for html
        {
            'nicholasmata/nvim-dap-cs',
            dependencies = { 'mfussenegger/nvim-dap' } 
        },
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
        {
            'akinsho/git-conflict.nvim',
            version = "*",
            config = true
        },

        { -- Autoformat
          'stevearc/conform.nvim',
          lazy = false,
          keys = {
            {
              '<leader>f',
              function()
                require('conform').format { async = true, lsp_fallback = true }
              end,
              mode = '',
              desc = '[F]ormat buffer',
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
        {
            "pmizio/typescript-tools.nvim",
            dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
            opts = {},
        }
    }
)
