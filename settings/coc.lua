
GOpts.backup = false
GOpts.writebackup = false

GOpts.updatetime = 100

GOpts.signcolumn = 'yes'

GKeymap.set('i', '<TAB>',
  'v:lua.TabCompletion()', { expr = true, noremap = true, silent = true }
)

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local keyset = GKeymap.set
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", GQuickOpt(''))
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", GQuickOpt(''))

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", GQuickOpt('[G]oto [D]efinition'))
keyset("n", "gy", "<Plug>(coc-type-definition)", GQuickOpt('[G]oto t[Y]pe definition'))
keyset("n", "gi", "<Plug>(coc-implementation)", GQuickOpt('[G]oto [I]mpletation'))
keyset("n", "gr", "<Plug>(coc-references)", GQuickOpt('[G]oto [R]eferences'))


-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "<Leader>k", '<CMD>lua _G.show_docs()<CR>', GQuickOpt('[k] Show docs'))


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", GQuickOpt('[R]e[N]ame'))


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", GQuickOpt('[F]ormat selected code'))
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", GQuickOpt('[F]ormat selected code'))


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>ca", "<Plug>(coc-codeaction-selected)", GQuickOpt('[C]ode [A]ction selected'))
keyset("n", "<leader>ca", "<Plug>(coc-codeaction-selected)", GQuickOpt('[C]ode [A]ction selected'))

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", GQuickOpt('Code [A]ction [C]ursor'))
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", GQuickOpt('Code [A]ction [S]ource'))
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", GQuickOpt('Code [Q]ick [F]ix'))
keyset("n", "<M-CR>", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", GQuickOpt('Code [R]efactor [E]'))
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", GQuickOpt('Code [R]efactor selected'))
keyset("n", "<leader>rs", "<Plug>(coc-codeaction-refactor-selected)", GQuickOpt('Code [R]efactor [S]elected'))

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", GQuickOpt('[C]ode [L]ens action'))


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "<Leader>cif", "<Plug>(coc-funcobj-i)", GQuickOpt('[C]ode [I] [F]'))
keyset("o", "<Leader>cif", "<Plug>(coc-funcobj-i)", GQuickOpt('[C]ode [I] [F]'))
keyset("x", "<Leader>caf", "<Plug>(coc-funcobj-a)", GQuickOpt('[C]ode [A] [F]'))
keyset("o", "<Leader>caf", "<Plug>(coc-funcobj-a)", GQuickOpt('[C]ode [A] [F]'))
keyset("x", "<Leader>cic", "<Plug>(coc-classobj-i)", GQuickOpt('[C]ode [I] [C]'))
keyset("o", "<Leader>cic", "<Plug>(coc-classobj-i)", GQuickOpt('[C]ode [I] [C]'))
keyset("x", "<Leader>cac", "<Plug>(coc-classobj-a)", GQuickOpt('[C]ode [A] [C]'))
keyset("o", "<Leader>cac", "<Plug>(coc-classobj-a)", GQuickOpt('[C]ode [A] [C]'))


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
-- g_opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<Leader>cla", ":<C-u>CocList diagnostics<cr>", GQuickOpt('[C]oc [L]isting [A]ll diagnostics'))
-- Manage extensions
keyset("n", "<Leader>cle", ":<C-u>CocList extensions<cr>", GQuickOpt('[C]oc [L]isting all [E]xtensions'))
-- Show commands
keyset("n", "<Leader>clc", ":<C-u>CocList commands<cr>", GQuickOpt('[C]oc [L]isting all [C]ommands'))
-- Find symbol of current document
keyset("n", "<Leader>clf", ":<C-u>CocList outline<cr>", GQuickOpt('[C]oc [L]ist [F]ind symbol of current document'))
-- Search workspace symbols
keyset("n", "<Leader>cls", ":<C-u>CocList -I symbols<cr>", GQuickOpt('[C]oc [L]ist [S]earch workspace symbols'))
-- Do default action for next item
keyset("n", "<Leader>cln", ":<C-u>CocNext<cr>", GQuickOpt('[C]oc [L]ist do [N]ext action'))
-- Do default action for previous item
keyset("n", "<Leader>clp", ":<C-u>CocPrev<cr>", GQuickOpt('[C]oc [L]ist do [P]revious action'))
-- Resume latest coc list
keyset("n", "<Leader>clr", ":<C-u>CocListResume<cr>", GQuickOpt('[C]oc [L]ist [R]esume lastes'))

