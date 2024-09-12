
--#region Globals

--#endregion

--#region Options

GO.laststatus = 3
GO.smartindent = true
GO.tabstop = 4
GO.softtabstop = 4
GO.showmode = false

GOpts.number = true
GOpts.relativenumber = true
GO.numberwidth = 2
GO.ruler = false

GOpts.shiftwidth = 4
GOpts.expandtab = true
GOpts.autoindent = true
GOpts.clipboard='unnamedplus'
GOpts.wrap = false
GOpts.wildmenu = true
GOpts.wildignore = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'
GOpts.cursorline = true
GOpts.hidden = false
GOpts.mouse = 'a'
GOpts.undofile = true

GOpts.scrolloff = 10

GOpts.hlsearch = true
GOpts.incsearch = true

GOpts.ignorecase = true
GOpts.smartcase = true

GOpts.list = true
GOpts.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

--#endregion

GCmd('syntax enable')
GCmd('filetype plugin indent on')
GCmd('set encoding=UTF-8')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
