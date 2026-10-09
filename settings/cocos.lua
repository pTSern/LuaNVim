-- cocos.nvim integration: Live Scene Hierarchy & Hooking System
local ok, cocos = pcall(require, "cocos")
if ok then
  cocos.setup({
    mcp_url = "http://localhost:9528/mcp",
    sidebar_width = 36,
    sidebar_position = "left",
    auto_refresh = false,
  })

  -- Toggle Cocos Hierarchy with M-2 / A-2
  vim.keymap.set("n", "<M-2>", "<cmd>CocosHierarchy<CR>", { desc = "Toggle Cocos Hierarchy", silent = true })
  vim.keymap.set("n", "<A-2>", "<cmd>CocosHierarchy<CR>", { desc = "Toggle Cocos Hierarchy", silent = true })

  -- Leader keybindings
  vim.keymap.set("n", "<leader>ch", "<cmd>CocosHierarchy<CR>", { desc = "Cocos Scene Hierarchy", silent = true })
  vim.keymap.set("n", "<leader>cs", "<cmd>CocosSave<CR>", { desc = "Cocos Save Scene", silent = true })
  vim.keymap.set("n", "<leader>cr", "<cmd>CocosRefresh<CR>", { desc = "Cocos Refresh Scene", silent = true })
end
