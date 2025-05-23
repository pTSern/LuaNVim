local wk = require('which-key')

local window = _G.is_transparent and {
    border = "none",
    height = 5,
    margin = { 1, 2, 1, 0 },
    padding = { 1, 2, 1, 2 },
    wo = {
      winblend = 5
    },
    zindex = 1000,
    no_overlap = true,
    title = true,
    title_pos = "center"
} or {
    no_overlap = true,
    height = 7,
    border = "none",
    margin = { 1, 0, 1, 0 },
    padding = { 1, 2, 1, 2 },
    wo = {
      winblend = 10
    },
    zindex = 1000,
    title = true,
    title_pos = "center"
}
wk.setup {
  ---@type false | "classic" | "modern" | "helix"
  preset = "modern",

  ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
  delay = 0,
  win = window,

  notify = true,

  triggers = {
    { "<auto>", mode = "nxsot" },
  },
}

local function quick_wk(key,desc)
  return { key, desc = desc, 'n'}
end

wk.add( {
  quick_wk('<leader>t', '[T]abs Options'),
  quick_wk('<leader>/', '[/] Commenter Options'),
  quick_wk('<leader><leader>', '[ ] More Options'),
  quick_wk('<leader>a', '[A]I Help'),
  quick_wk('<leader>b', '[B]uffer Options'),
  quick_wk('<leader>c', '[C]ode Options'),
  quick_wk('<leader>l', '[L]ive Options'),
  quick_wk('<leader>q', '[Q]uick Options'),
  quick_wk('<leader>s', '[S]earch Options'),
  quick_wk('<leader>v', '[V]isual Mode Options'),
  quick_wk('<leader>f', '[F]ind Options'),
  quick_wk('<leader><leader><leader>', '[ ] Code Server Options'),
  quick_wk('gc', '[G]it [C]onflic Options'),
})

if(_G.is_transparent) then
  -- Set custom highlights for which-key
  vim.cmd([[
    augroup WhichKeyHighlights
      autocmd!
      autocmd ColorScheme * highlight WhichKeyFloat ctermbg=DARKGRAY guibg=#303347
      autocmd ColorScheme * highlight WhichKeyBorder ctermfg=DARKBLUE guifg=#00B4DD
      autocmd ColorScheme * highlight WhichKeySeparator ctermfg=DARKBLUE guifg=#6D88FF
      autocmd ColorScheme * highlight WhichKeyGroup ctermfg=MAGENTA guifg=#B14BFF
      autocmd ColorScheme * highlight WhichKeyDesc ctermfg=GREEN guifg=#00FFB3
    augroup END
  ]])

  -- Re-Apply colorscheme
  GCmd.colorscheme(_G.colorscheme)
end
