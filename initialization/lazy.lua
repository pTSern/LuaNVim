
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
        { "catppuccin/nvim", name = "catppuccin", priority = 1000 },    -- Main theme
        "xiyaowong/transparent.nvim",                                   -- Transparent cilent
        "preservim/nerdTree",                                           -- File manager
        "vim-airline/vim-airline",                                      -- Status bar
        "vim-airline/vim-airline-themes",                               -- Theme for status bar
        "jackguo380/vim-lsp-cxx-highlight",                             -- Cpp hightligh
        "LunarWatcher/auto-pairs",                                      -- Auto Pairs
        "preservim/nerdcommenter",
        { "neoclide/coc.nvim", branch = "release" },
        "rafcamlet/coc-nvim-lua",
        "lfv89/vim-interestingwords",
        "Xuyuanp/nerdtree-git-plugin",
        "voldikss/vim-floaterm",
        {"junegunn/fzf", build = "./install --bin"},
        --{"ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("fzf-lua").setup({}) end},
        "jreybert/vimagit",
        "ryanoasis/vim-devicons",
        "nvim-tree/nvim-web-devicons",
        {'romgrk/barbar.nvim', dependencies = {'lewis6991/gitsigns.nvim', 'nvim-tree/nvim-web-devicons'}, init = function() vim.g.barbar_auto_setup = false end, opts = {}},
        {"folke/which-key.nvim", event = "VeryLazy", init = function() vim.o.timeout = true vim.o.timeoutlen = 30 end, opts = {} },
    }
)
