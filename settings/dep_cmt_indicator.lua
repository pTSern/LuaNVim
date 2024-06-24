
-- Define a custom highlight group with a strike-through effect
--vim.cmd [[
--  highlight DeprecatedComment gui=strikethrough
--]]
--
---- Apply the custom highlight to comments containing @deprecated
--vim.cmd [[
--  autocmd Syntax * syntax match DeprecatedComment /\/\/\s*@deprecated.*/ contains=@Spell
--  autocmd Syntax * syntax match DeprecatedComment /\/\*\s*@deprecated.*\*\// contains=@Spell
--]]

vim.api.nvim_set_hl(1, '@lsp.mod.deprecated', {gui=strikethrough})
