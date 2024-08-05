GOpts = vim.opt
GKeymap = vim.keymap
GGlobal = vim.g
GCmd = vim.cmd
GWo = vim.wo

GDfgConfig = {
    noremap = true,
    silent = true
}

GGlobal.mapleader = ' '

GQuickOpt = function (desc)
    return {
        noremap = true,
        silent = true,
        desc = desc
    }
end

_G.qnmap = function(key, mechanic, desc)
    return GKeymap.set('n', key, mechanic, GQuickOpt(desc))
end

_G.qimap = function(key, mechanic, desc)
    return GKeymap.set('i', key, mechanic, GQuickOpt(desc))
end

_G.qvmap = function(key, mechanic, desc)
    return GKeymap.set('v', key, mechanic, GQuickOpt(desc))
end

_G.gui = "default"

if vim.g.neovide then
    _G.gui = 'neovide'
elseif vim.fn.exists('g:GuiLoaded') == 1 then
    if vim.fn.exists(':GuiFont' == 2) then
        _G.gui = 'qt'
    end
end

_G.transparent = function(on)
    if on then
        vim.api.nvim_command(":TransparentEnable")
        _G.is_transparent = true
    else
        vim.api.nvim_command(":TransparentDisable")
        _G.is_transparent = false
    end
end

-- coq | cmp
_G.target_cmp = 'cmp'
