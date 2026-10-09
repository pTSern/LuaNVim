if vim.g.loaded_cocos_nvim then
  return
end
vim.g.loaded_cocos_nvim = 1

local cocos = require("cocos")

vim.api.nvim_create_user_command("CocosHierarchy", function()
  cocos.toggle()
end, { desc = "Toggle Cocos Scene Hierarchy Sidebar" })

vim.api.nvim_create_user_command("CocosHeirchary", function()
  cocos.toggle()
end, { desc = "Toggle Cocos Scene Hierarchy Sidebar (Alias)" })

vim.api.nvim_create_user_command("CocosOpen", function()
  cocos.open()
end, { desc = "Open Cocos Scene Hierarchy Sidebar" })

vim.api.nvim_create_user_command("CocosClose", function()
  cocos.close()
end, { desc = "Close Cocos Scene Hierarchy Sidebar" })

vim.api.nvim_create_user_command("CocosRefresh", function()
  cocos.refresh()
end, { desc = "Refresh Cocos Scene Hierarchy" })

vim.api.nvim_create_user_command("CocosSave", function()
  cocos.save()
end, { desc = "Save Cocos Scene" })
