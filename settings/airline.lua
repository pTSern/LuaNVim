local g = vim.g

g['airline_powerline_fonts'] = 1                       -- Enable font for status bar
vim.cmd('AirlineTheme onedark')                        -- Theme Onedark 


if not g.airline_symbols then
    g.airline_symbols = {}
end

g['airline_left_sep'] = '»'
g['airline_left_sep'] = '▶'
g['airline_right_sep'] = '«'
g['airline_right_sep'] = '◀'
g['airline_symbols.linenr'] = '␊'
g['airline_symbols.linenr'] = '␤'
g['airline_symbols.linenr'] = '¶'
g['airline_symbols.branch'] = '⎇'
g['airline_symbols.paste'] = 'ρ'
g['airline_symbols.paste'] = 'Þ'
g['airline_symbols.paste'] = '∥'
g['airline_symbols.whitespace'] = 'Ξ'

g['airline_left_sep'] = ''
g['airline_left_alt_sep'] = ''
g['airline_right_sep'] = ''
g['airline_right_alt_sep'] = ''
g['airline_symbols.branch'] = ''
g['airline_symbols.readonly'] = ''
g['airline_symbols.linenr'] = ''

g['WebDevIconsUnicodeDecorateFolderNodes'] = 1
g['WebDevIconsUnicodeDecorateFolderNodeDefaultSymbol'] = ''

