--g_cmd[[highlight CursorColumn ctermbg=LightGray guibg=LightGray]]
--g_opt.termguicolors = true

_G.colorscheme = "catppuccin-macchiato"

_G.font = {
	name = "Hack Nerd Font",
	size = 13
}

GCmd.colorscheme(_G.colorscheme)

if _G.gui == 'neovide' then
	_G.transparent(false)

	GGlobal.neovide_transparency = 0.90
	GGlobal.neovide_show_border = true

	local cursor_vfx_modes = { "railgun", "wireframe", "sonicboom", "pixiedust", "torpedo" }
	local rand_cursor_vfx = cursor_vfx_modes[math.random(#cursor_vfx_modes)]

	GGlobal.neovide_no_idle = true
	GGlobal.neovide_cursor_vfx_mode = rand_cursor_vfx;
	GGlobal.neovide_fullscreen = false
	GGlobal.neovide_scroll_animation_length = 0.3

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

vim.o.guifont = _G.font.name .. ":h" .. _G.font.size;

--GCmd("set guifont=" .. _G.font.name .. ":h" .. _G.font.size)
