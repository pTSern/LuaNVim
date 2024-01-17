vim.g.ale_linters = {
    cs = {'OmniSharp'},
    javascript = {'flow-language-server'}
}

vim.b.ale_linters = {'cs', 'flow-language-server'}

vim.g.ale_echo_msg_error_str = '➤'
vim.g.ale_echo_msg_warning_str = '↺'
vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
vim.g.ale_sign_error = '➤'
vim.g.ale_sign_warning = '↺'
