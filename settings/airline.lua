--local g = vim.g
--
--g['airline_powerline_fonts'] = 1                        -- Enable font for status bar
--vim.cmd('AirlineTheme onedark')                          -- Theme Onedark 
--
--
--if not g.airline_symbols then
--    g.airline_symbols = {}
--end
--
--g['airline_left_sep'] = '»'
--g['airline_left_sep'] = '▶'
--g['airline_right_sep'] = '«'
--g['airline_right_sep'] = '◀'
--g['airline_symbols.linenr'] = '␊'
--g['airline_symbols.linenr'] = '␤'
--g['airline_symbols.linenr'] = '¶'
--g['airline_symbols.branch'] = '⎇'
--g['airline_symbols.paste'] = 'ρ'
--g['airline_symbols.paste'] = 'Þ'
--g['airline_symbols.paste'] = '∥'
--g['airline_symbols.whitespace'] = 'Ξ'
--
--g['airline_left_sep'] = ''
--g['airline_left_alt_sep'] = ''
--g['airline_right_sep'] = ''
--g['airline_right_alt_sep'] = ''
--g['airline_symbols.branch'] = ''
--g['airline_symbols.readonly'] = ''
--g['airline_symbols.linenr'] = ''
--
--g['WebDevIconsUnicodeDecorateFolderNodes'] = 1
--g['WebDevIconsUnicodeDecorateFolderNodeDefaultSymbol'] = ''

require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'catppuccin-macchiato',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16,
            events = {
                "WinEnter",
                "BufEnter",
                "BufWritePost",
                "SessionLoadPost",
                "FileChangedShellPost",
                "VimResized",
                "Filetype",
                "CursorMoved",
                "CursorMovedI",
                "ModeChanged",
            }
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { }
}
