--g_cmd[[highlight CursorColumn ctermbg=LightGray guibg=LightGray]]
--g_opt.termguicolors = true

vim.g.font = "Hack"
vim.g.font_size = 12

_G.colorscheme = "catppuccin-macchiato"
GCmd.colorscheme(_G.colorscheme)

if _G.gui == 'neovide' then
	_G.transparent(false)

	GGlobal.neovide_transparency = 0.80
	GGlobal.neovide_show_border = true

	GGlobal.neovide_no_idle = true
	GGlobal.neovide_cursor_vfx_mode = 'railgun'
	GGlobal.neovide_fullscreen = false

elseif _G.gui == 'qt' then
	_G.transparent(false)
	if vim.fn.exists(":GuiTabline") == 2 then
		vim.cmd("GuiTabline 0")
	end
else
	_G.transparent(true)
end


vim.api.nvim_command("highlight CursorColumn guibg=#353940")
vim.api.nvim_command("highlight CursorLine guibg=#353940")

GCmd("set guifont=" .. vim.g.font .. ":h" .. vim.g.font_size)
