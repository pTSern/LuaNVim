
g_opt.number = true
g_opt.relativenumber = true
g_opt.shiftwidth = 4
g_opt.expandtab = true
g_opt.autoindent = true
g_opt.clipboard='unnamedplus'
g_opt.wrap = false
g_opt.wildmenu = true
g_opt.wildignore = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'
g_opt.cursorline = true
g_opt.hidden = false
g_opt.mouse = 'a'
g_opt.showmode = false
g_opt.undofile = true
g_opt.scrolloff = 10

g_opt.hlsearch = true
g_opt.incsearch = true 

g_opt.ignorecase = true
g_opt.smartcase = true

g_opt.list = true
g_opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

g_cmd('syntax enable')
g_cmd('filetype plugin indent on')
g_cmd('set encoding=UTF-8')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
