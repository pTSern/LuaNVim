
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
g_opt.rtp:prepend(lazypath)

-- INSTALL PLUGINS

require("lazy").setup(
    {
        { "catppuccin/nvim", name = "catppuccin" },                                                                                                                                                                                                     -- Main theme
        "xiyaowong/transparent.nvim",                                                                                                                                                                                                                   -- Transparent cilent
        "navarasu/onedark.nvim",
        --'tribela/vim-transparent',
        "preservim/nerdTree",                                                                                                                                                                                                                           -- File manager
        "vim-airline/vim-airline",                                                                                                                                                                                                                      -- Status bar
        "vim-airline/vim-airline-themes",                                                                                                                                                                                                               -- Theme for status bar
        "jackguo380/vim-lsp-cxx-highlight",                                                                                                                                                                                                             -- Cpp hightligh
        "LunarWatcher/auto-pairs",                                                                                                                                                                                                                      -- Auto Pairs
        "preservim/nerdcommenter",                                                                                                                                                                                                                      -- Commenter of nerdTree
        { "neoclide/coc.nvim", branch = "release" },                                                                                                                                                                                                    -- Language Server for faster code
        "rafcamlet/coc-nvim-lua",                                                                                                                                                                                                                       -- Lua server
        "lfv89/vim-interestingwords",                                                                                                                                                                                                                   -- Searching and highlight word with different color.
        "Xuyuanp/nerdtree-git-plugin",                                                                                                                                                                                                                  -- Git status for nerdTree
        "voldikss/vim-floaterm",                                                                                                                                                                                                                        -- Float terminal
        --{"junegunn/fzf", build = "./install --bin"},
        --{"ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("fzf-lua").setup({}) end},
        "jreybert/vimagit",                                             -- Git status 
        "ryanoasis/vim-devicons",                                       -- Provide beauty icons
        "nvim-tree/nvim-web-devicons",                                  -- Other plugins for beauty icons
        {'romgrk/barbar.nvim', dependencies = {'lewis6991/gitsigns.nvim', 'nvim-tree/nvim-web-devicons'}, init = function() vim.g.barbar_auto_setup = false end, opts = {}},                                                                            -- Manager buffer tab
        {"folke/which-key.nvim", event = "VeryLazy", init = function() vim.o.timeout = true vim.o.timeoutlen = 30 end, opts = {} },                                                                                                                     -- Display key mapping helper
        --"jinh0/eyeliner.nvim",
        --"puremourning/vimspector",
        "nvim-lua/plenary.nvim",
        {'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' }},                                                                                                                                                   -- Searching all files Like CRT-SHIFT-F
        --{'nvim-treesitter/nvim-treesitter'},
        "williamboman/mason.nvim",                                                                                                                                                                                                                      -- 
        'nvim-treesitter/nvim-treesitter',
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",                                                                                                                                                                                                                        -- 
        {"iamcco/markdown-preview.nvim", cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }, build = "cd app && yarn install", init = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }},              -- Live Markdown file
        'OmniSharp/omnisharp-vim',                                                                                                                                                                                                                      -- Language server for CSharp
        { 'barrett-ruth/live-server.nvim', build = 'yarn global add live-server', config = true },                                                                                                                                                       -- Live server for html
        'dense-analysis/ale',
        { 'nicholasmata/nvim-dap-cs', dependencies = { 'mfussenegger/nvim-dap' } },
        'sheerun/vim-polyglot',
        { 'utilyre/barbecue.nvim', name = "barbecue", version = "*", dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" } },
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
        {'akinsho/git-conflict.nvim', version = "*", config = true}
    }
)
