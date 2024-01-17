vim.api.nvim_exec([[
  autocmd FileType cs nmap <buffer> <leader>gd <Plug>(omnisharp_go_to_definition)
]], false)

vim.api.nvim_exec([[
  autocmd FileType cs nmap <buffer> <leader>rn <Plug>(omnisharp_rename)
]], false)

vim.api.nvim_exec([[
  autocmd FileType cs nmap <buffer> <leader>f :OmniSharpCodeFormart<CR>
]], false)

vim.api.nvim_exec([[
  autocmd FileType cs vmap <buffer> <leader>f :OmniSharpCodeFormart<CR>
]], false)
