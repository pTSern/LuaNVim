

--g_cmd[[highlight CursorColumn ctermbg=LightGray guibg=LightGray]]
--g_opt.termguicolors = true

vim.g.font = 'Hack'
vim.g.font_size = 12

_G.colorscheme = "catppuccin-macchiato"
GCmd.colorscheme(_G.colorscheme)

if(vim.fn.exists("g:GuiLoaded") == 1) then
  vim.api.nvim_command(":TransparentDisable");
  _G.is_transparent = false;
else
  vim.api.nvim_command(":TransparentEnable")
  _G.is_transparent = true;
end

vim.api.nvim_command('highlight CursorColumn guibg=#353940')
vim.api.nvim_command('highlight CursorLine guibg=#353940')

GCmd('set guifont='..vim.g.font..':h'..vim.g.font_size)
