-- Run from the config root: nvim --headless -u NONE -i NONE -l tests/diagnostic_signs.lua
local function verify()
    dofile('settings/diagnostic.lua')

    local config = vim.diagnostic.config()
    assert(config.virtual_text == true, 'virtual text must remain enabled')
    assert(config.underline == true, 'underlines must remain enabled')
    assert(config.update_in_insert == true, 'insert-mode updates must remain enabled')
    assert(config.severity_sort == false, 'severity sorting must remain disabled')

    local severity = vim.diagnostic.severity
    local expected = {
        [severity.ERROR] = { text = '󰅚 ', highlight = 'DiagnosticSignError' },
        [severity.WARN] = { text = '󰀪 ', highlight = 'DiagnosticSignWarn' },
        [severity.INFO] = { text = ' ', highlight = 'DiagnosticSignInfo' },
        [severity.HINT] = { text = '󰌶 ', highlight = 'DiagnosticSignHint' },
    }

    vim.api.nvim_buf_set_lines(0, 0, -1, false, { 'error', 'warning', 'info', 'unused value' })
    local namespace = vim.api.nvim_create_namespace('diagnostic-sign-regression')
    local diagnostics = {}
    for level in pairs(expected) do
        diagnostics[#diagnostics + 1] = {
            lnum = level - 1,
            col = 0,
            severity = level,
            message = 'Diagnostic sign regression test',
        }
    end
    vim.diagnostic.set(namespace, 0, diagnostics)

    local sign_namespace = vim.diagnostic.get_namespace(namespace).user_data.sign_ns
    assert(sign_namespace, 'diagnostic signs were not rendered')
    local marks = vim.api.nvim_buf_get_extmarks(0, sign_namespace, 0, -1, { details = true })
    assert(#marks == 4, 'expected one rendered sign for each severity')
    for _, mark in ipairs(marks) do
        local icon = expected[mark[2] + 1]
        local details = mark[4]
        assert(vim.trim(details.sign_text) == vim.trim(icon.text), 'wrong icon: ' .. details.sign_text)
        assert(details.sign_hl_group == icon.highlight, 'wrong sign highlight')
        assert(details.number_hl_group == icon.highlight, 'wrong line-number highlight')
        assert(not details.line_hl_group or details.line_hl_group == '', 'unexpected whole-line highlight')
    end

    local lsp_config = table.concat(vim.fn.readfile('settings/lsp.lua'), '\n')
    assert(lsp_config:find("dofile(g_root .. 'settings/diagnostic.lua')", 1, true),
        'LSP setup must load the diagnostic configuration')
    assert(not lsp_config:find('sign_define', 1, true), 'legacy diagnostic sign definitions remain')
end

local ok, err = pcall(verify)
if not ok then
    io.stderr:write(tostring(err) .. '\n')
    vim.cmd('cquit 1')
end
print('PASS: all four diagnostic icons, highlights, options, and LSP wiring')
vim.cmd('qa!')
