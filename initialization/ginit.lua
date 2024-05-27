

--g_cmd[[highlight CursorColumn ctermbg=LightGray guibg=LightGray]]
--g_opt.termguicolors = true

vim.g.font = 'Hack'
vim.g.font_size = 12
g_cmd.colorscheme("catppuccin-macchiato")

-- vim.api.nvim_command(":TransparentDisable")
vim.api.nvim_command('highlight CursorColumn guibg=#353940')
vim.api.nvim_command('highlight CursorLine guibg=#353940')

g_cmd('set guifont='..vim.g.font..':h'..vim.g.font_size)
