GKeymap.set('n', "<Leader>T", ":TransparentToggle<CR>", GDfgConfig)

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

                "WhichKey",
                "WhichKeyNormal",
                "WhichKeyBorder",

                "Whichkey",
                "WhichkeyNormal",
                "WhichkeyBorder",
            },
            exclude_groups = {'CursorLine', 'CursorLineNr'}
        })
