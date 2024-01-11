g_keymap.set('n', "<Leader>T", ":TransparentToggle<CR>", g_default_opts)

require("transparent").setup({
            extra_groups = { -- table/string: additional groups that should be cleared
                "BufferLineTabClose",
                "BufferlineBufferSelected",
                "BufferLineFill",
                "BufferLineBackground",
                "BufferLineSeparator",
                "BufferLineIndicatorSelected",

                "IndentBlanklineChar",

                -- make floating windows transparent
                "LspFloatWinNormal",
                "Normal",
                "NormalFloat",
                "FloatBorder",
                "TelescopeNormal",
                "TelescopeBorder",
                "TelescopePromptBorder",
                "SagaBorder",
                "SagaNormal",
            },
            exclude_groups = {'CursorLine', 'CursorLineNr'}
        })
