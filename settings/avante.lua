
local qkn = _G.qnmap

require('avante').setup {
    windows = {
        wrap = true,
        width = 90,
        input = {
            prefix = "> ",
            height = 13,
        },
        edit = {
            border = "rounded",
            start_insert = true
        },
        ask = {
            floating = true,
            start_insert = true,
            border = "rounded",
            focus_on_apply = "ours"
        }
    }
}

qkn('<Leader>ac', [[:AvanteToggle<CR>]], "[A]vante [C]hat")
