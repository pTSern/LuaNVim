vim.g.barbar_auto_setup = false -- disable auto-setup

require'barbar'.setup {
  -- WARN: do not copy everything below into your config!
  --       It is just an example of what configuration options there are.
  --       The defaults are suitable for most people.

  -- Enable/disable animations
  animation = true,

  -- Automatically hide the tabline when there are this many buffers left.
  -- Set to any value >=0 to enable.
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = false,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
  -- Valid options are 'left' (the default), 'previous', and 'right'
  focus_on_close = 'left',

  -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
  -- hide = {extensions = true, inactive = true},

  -- Disable highlighting alternate buffers
  highlight_alternate = false,

  -- Disable highlighting file icons in inactive buffers
  highlight_inactive_file_icons = false,

  -- Enable highlighting visible buffers
  highlight_visible = false,

  icons = {
    -- Configure the base icons on the bufferline.
    -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
    buffer_index = true,
    buffer_number = false,
    button = '',
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = false, icon = '⇲'},
      [vim.diagnostic.severity.WARN] = {enabled = false},
      [vim.diagnostic.severity.INFO] = {enabled = false, icon = '♕'},
      [vim.diagnostic.severity.HINT] = {enabled = false, icon = '✯'},
    },
    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '~'},
      deleted = {enabled = true, icon = '-'},
    },
    filetype = {
      -- Sets the icon's highlight group.
      -- If false, will use nvim-web-devicons colors
      custom_colors = false,

      -- Requires `nvim-web-devicons` if `true`
      enabled = true,
    },
    separator = {left = '▎', right = ''},

    -- If true, add an additional separator at the end of the buffer list
    separator_at_end = true,

    -- Configure the icons on the bufferline when modified or pinned.
    -- Supports all the base icon options.
    modified = {button = '●'},
    pinned = {button = '', filename = true},

    -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
    preset = 'default',

    -- Configure the icons on the bufferline based on the visibility of a buffer.
    -- Supports all the base icon options, plus `modified` and `pinned`.
    alternate = {filetype = {enabled = false}},
    current = {buffer_index = true},
    inactive = {button = '×'},
    visible = {modified = {buffer_number = false}},
  },

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the minimum padding width with which to surround each tab
  minimum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 20,

  -- Sets the minimum buffer name length.
  minimum_length = 0,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    -- Use the default values: {event = 'BufWinLeave', text = nil}
    NvimTree = true,
    -- Or, specify the text used for the offset:
    undotree = {text = 'undotree'},
    -- Or, specify the event which the sidebar executes when leaving:
    ['neo-tree'] = {event = 'BufWipeout'},
    -- Or, specify both
    Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
  },

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustment
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}

-----------------------
-----------------------
----- KEY MAPPING -----
-----------------------
-----------------------

local map = GKeymap.set


-- Move to previous/next
map('n', '<Tab>\\', "<C-w><C-w>", GQuickOpt('[\\] Switching bar'))
map('n', '<Tab>j', ':w<CR><Cmd>BufferPrevious<CR>', GQuickOpt('[j] Previous Buffer'))
map('n', '<Tab>k', ':w<CR><Cmd>BufferNext<CR>', GQuickOpt('[k] Next Buffer'))
-- map('n', '<Tab>k', ':bn<CR>', g_default_opts)
-- map('n', '<Tab>j', ':bp<CR>', g_default_opts)

-- Re-order to previous/next
map('n', '<Tab>h', '<Cmd>BufferMovePrevious<CR>', GQuickOpt('[h] Move Buffer to Left'))
map('n', '<Tab>l', '<Cmd>BufferMoveNext<CR>', GQuickOpt('[l] Move Buffer to Right'))
-- Goto buffer in position...
map('n', '\\1', '<Cmd>BufferGoto 1<CR>', GQuickOpt('Goto Buffer [1]'))
map('n', '\\2', '<Cmd>BufferGoto 2<CR>', GQuickOpt('Goto Buffer [2]'))
map('n', '\\3', '<Cmd>BufferGoto 3<CR>', GQuickOpt('Goto Buffer [3]'))
map('n', '\\4', '<Cmd>BufferGoto 4<CR>', GQuickOpt('Goto Buffer [4]'))
map('n', '\\5', '<Cmd>BufferGoto 5<CR>', GQuickOpt('Goto Buffer [5]'))
map('n', '\\6', '<Cmd>BufferGoto 6<CR>', GQuickOpt('Goto Buffer [6]'))
map('n', '\\7', '<Cmd>BufferGoto 7<CR>', GQuickOpt('Goto Buffer [7]'))
map('n', '\\8', '<Cmd>BufferGoto 8<CR>', GQuickOpt('Goto Buffer [8]'))
map('n', '\\9', '<Cmd>BufferGoto 9<CR>', GQuickOpt('Goto Buffer [9]'))
map('n', '\\0', '<Cmd>BufferLast<CR>', GQuickOpt('Last Buffer [0]'))

-- Pin/unpin buffer
map('n', '<Leader><Tab>', '<Cmd>BufferPin<CR>', GQuickOpt('[TAB] Pin this Buffer'))
-- Close buffer
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<Tab>d', '<Cmd>BufferDelete<CR>', GQuickOpt('Buffer [D]elete'))
map('n', '<Tab>c', '<Cmd>BufferClose<CR>', GQuickOpt('Buffer [C]lose'))
map('n', '<Tab>r', '<Cmd>BufferRestore<CR>', GQuickOpt('Buffer [R]estore'))
map('n', '<Tab>bp', '<Cmd>BufferPick<CR>', GQuickOpt('[B]uffer [P]icking'))

-- Sort automatically by...
map('n', '<Tab>bn', '<Cmd>BufferOrderByBufferNumber<CR>', GQuickOpt('[B]uffer sort by [N]umber'))
map('n', '<Tab>bd', '<Cmd>BufferOrderByDirectory<CR>', GQuickOpt('[B]uffer sort by [D]irectory'))
map('n', '<Tab>bl', '<Cmd>BufferOrderByLanguage<CR>', GQuickOpt('[B]uffer sort by [L]anguage'))
map('n', '<Tab>bw', '<Cmd>BufferOrderByWindowNumber<CR>', GQuickOpt('[B]uffer sort by [W]indow number'))

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
--

vim.api.nvim_set_hl(0, "BufferCurrent",     { fg = "#c44fff", bg = "NONE", bold = false })
vim.api.nvim_set_hl(0, "BufferInactive",    { fg = "#888888", bg = "NONE", italic = true })
vim.api.nvim_set_hl(0, "BufferVisible",     { fg = "#aaaaaa", bg = "NONE" })
