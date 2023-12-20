-- g_keymap.set('n', '<Leader>d', ':bd<CR>', g_default_opts )
g_keymap.set('n', '<Leader>w', ':w<CR>', g_default_opts)
g_keymap.set('n', '<Leader>W', ':wq<CR>', g_default_opts )
g_keymap.set('n', '<Leader>Q', ':q!<CR>', g_default_opts )
g_keymap.set('n', '<Leader>d', ':bd<CR>', g_default_opts )
-- g_keymap.set('n', '<Tab>', ':bn<CR>', g_default_opts)
-- g_keymap.set('n', '<Leader><Tab>', ':bp<CR>', g_default_opts)
g_keymap.set('n', '<Leader>h', ':noh<CR>', g_default_opts)
g_keymap.set('n', '<Leader>tv', ':vs<CR><C-w><C-w>', g_default_opts)
g_keymap.set('n', '<Leader>l', ':ls<CR>', g_default_opts)
g_keymap.set('n', '<Leader>ts', '<C-w><C-w>', g_default_opts)
g_keymap.set('n', '<S-Tab>', '<C-w><C-w>', g_default_opts)
g_keymap.set('n', '<Leader>tq', '<C-w><C-q>', g_default_opts)
g_keymap.set('n', 'df', 'lbde', g_default_opts)
g_keymap.set('n', '<Leader>ve', 'v$', g_default_opts)
g_keymap.set('n', '<C-l>', 'V>', g_default_opts)
g_keymap.set('n', '<C-L>', 'V<$a', g_default_opts)
g_keymap.set('n', '<C-h>', 'V<', g_default_opts)
g_keymap.set('n', '<C-H>', 'V>$a', g_default_opts)
g_keymap.set('n', '<Leader>sn', '*', g_default_opts)
g_keymap.set('n', '<Leader>sN', '*:noh<CR>', g_default_opts)
g_keymap.set('n', '<Leader>sp', '#', g_default_opts)
g_keymap.set('n', '<Leader>sP', '#:noh<CR>', g_default_opts)
g_keymap.set('n', '<Leader>F', 'ddVk<Plug>(coc-format-selected)o')
g_keymap.set('n', '<Leader><Leader>-', 'lbi_<ESC>ea_<ESC>', g_default_opts)
g_keymap.set('n', '<Leader><Leader>_', 'lBi_<ESC>Ea_<ESC>', g_default_opts)
g_keymap.set('n', '<Leader><Leader>[', 'lbi[<ESC>ea]<ESC>', g_default_opts)
g_keymap.set('n', "<Leader><Leader>'", "lbi'<ESC>ea'<ESC>", g_default_opts)
g_keymap.set('n', '<Leader><Leader>]', 'lBi[<ESC>Ea]<ESC>', g_default_opts)
g_keymap.set('n', '<Leader><Leader><', 'lbi<<ESC>ea><ESC>', g_default_opts)
g_keymap.set('n', '<Leader><Leader>>', 'lBi<<ESC>Ea><ESC>', g_default_opts)
g_keymap.set('n', '<Leader>o', 'jI<CR><ESC>ka<TAB>', g_default_opts)
g_keymap.set('n', '<Leader><CR>', ':%s/\r//g<CR>', g_default_opts)
g_keymap.set('n', '<C-Up>', ':m .-2<CR>==', g_default_opts )
g_keymap.set('n', '<C-Down>', ':m .+1<CR>==', g_default_opts )
g_keymap.set('n', '<C-k>', ':m .-2<CR>==', g_default_opts )
g_keymap.set('n', '<C-j>', ':m .+1<CR>==', g_default_opts )
g_keymap.set('n', '<Leader>vy', 'V"+y', g_default_opts )
g_keymap.set('n', '<Leader>vp', 'V"+pV"+y', g_default_opts )
g_keymap.set('n', '<Leader>Vp', '"+y', g_default_opts )
g_keymap.set('n', '<Leader>//', 'i/**<CR>*/<ESC>0xko', g_default_opts )
g_keymap.set('n', '<C-/>', '^i//<ESC>', g_default_opts )
g_keymap.set('n', '<Leader>fn', ":enew<CR>", g_default_opts )

g_keymap.set('i', '<C-Up>', '<ESC>:m .-2<CR>==gi', g_default_opts)
g_keymap.set('i', '<C-Down>', '<ESC>:m .+1<CR>==gi', g_default_opts)
g_keymap.set('i', '<C-k>', '<ESC>:m .-2<CR>==gi', g_default_opts)
g_keymap.set('i', '<C-j>', '<ESC>:m .+1<CR>==gi', g_default_opts)

g_keymap.set('v', '<C-/>', '^<C-v>I//<ESC>', g_default_opts )
g_keymap.set('v', '<C-k>', ":m '>-2<CR>gv=gv", g_default_opts )
g_keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", g_default_opts )
