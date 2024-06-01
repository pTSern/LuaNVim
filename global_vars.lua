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


