local wk = require('which-key')

local window = _G.is_transparent and {
    border = "none",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 1, 2, 1, 2 },
    winblend = 5,
    zindex = 1000,
} or {
    border = "none",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 1, 2, 1, 2 },
    winblend = 10,
    zindex = 1000,
}

wk.setup {
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
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "[LEADER]",
    ["<leader>"] = "[LEADER]",
    ["<cr>"] = "[ENTER]",
    ["<CR>"] = "[ENTER]",
    ["<Tab>"] = "[TAB]",
  },
  motions = {
    count = true,
  },
  icons = {
    breadcrumb = " » ", -- symbol used in the command line area that shows your active key combo
    separator = "| ", -- symbol used between a key and it's label
    group = "╰┈➤ ", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-e>", -- binding to scroll down inside the popup
    scroll_up = "<c-y>", -- binding to scroll up inside the popup
  },
  window = window,
  --{
  --  border = "none", -- none, single, double, shadow
  --  position = "bottom", -- bottom, top
  --  margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
  --  padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
  --  winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
  --  zindex = 1000, -- positive value to position WhichKey above other floating windows.
  --},
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
  show_help = true, -- show a help message in the command line for using WhichKey
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = {
      '<leader>',
      'd',
      'g',
      'z',
      '\\',
      '<Tab>',
      '[', ']',
      '`',
      'm'
  },
  -- "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specifiy a list manually
  -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
  triggers_nowait = {
    -- marks
    "`",
    "'",
    "g`",
    "g'",
    -- registers
    '"',
    "<c-r>",
    -- spelling
    "z=",
  },
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for keymaps that start with a native binding
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by default for Telescope
  disable = {
    buftypes = {},
    filetypes = {},
  },
}

wk.register {
  ['<leader>t'] = { name = '[T]abs Options', _ = 'which_key_ignore' },
  ['<leader>/'] = { name = '[/] Commenter Options', _ = 'which_key_ignore' },
  ['<leader><leader>'] = { name = '[ ] More Options', _ = 'which_key_ignore' },
  ['<leader>a'] = { name = 'Code [A]ctions', _ = 'which_key_ignore' },
  ['<leader>b'] = { name = '[B]uffer Options', _ = 'which_key_ignore' },
  ['<leader>c'] = { name = '[C]ode Options', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]ive Options', _ = 'which_key_ignore' },
  ['<leader>q'] = { name = '[Q]uick Options', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch Options', _ = 'which_key_ignore' },
  ['<leader>v'] = { name = '[V]isual Mode Options', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = '[F]ind Options', _ = 'which_key_ignore' },
  ['<leader><leader><leader>'] = { name = '[ ] Code Server Options', _ = 'which_key_ignore' },
}

if(_G.is_transparent) then
  -- Set custom highlights for which-key
  vim.cmd([[
    augroup WhichKeyHighlights
      autocmd!
      autocmd ColorScheme * highlight WhichKeyFloat ctermbg=DARKGRAY guibg=#303347
      autocmd ColorScheme * highlight WhichKeyBorder ctermfg=DARKBLUE guifg=#00B4DD
      autocmd ColorScheme * highlight WhichKeySeparator ctermfg=DARKBLUE guifg=#6D88FF
      autocmd ColorScheme * highlight WhichKeyGroup ctermfg=MAGENTA guifg=#B14BFF
      autocmd ColorScheme * highlight WhichKeyDesc ctermfg=GREEN guifg=#00FFB3
    augroup END
  ]])

  -- Re-Apply colorscheme
  GCmd.colorscheme(_G.colorscheme)
end
