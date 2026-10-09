local client = require("cocos.client")
local ui = require("cocos.ui")

local M = {}

--- Setup cocos.nvim options
--- @param opts table|nil
function M.setup(opts)
  opts = opts or {}
  client.setup({
    mcp_url = opts.mcp_url or "http://localhost:9528/mcp",
    timeout = opts.timeout or 5000,
  })

  ui.setup({
    sidebar_width = opts.sidebar_width or 36,
    sidebar_position = opts.sidebar_position or "left",
    auto_refresh = opts.auto_refresh ~= false,
    refresh_interval = opts.refresh_interval or 3000,
  })

  -- Register user commands
  vim.api.nvim_create_user_command("CocosHierarchy", function() M.toggle() end, { desc = "Toggle Cocos Scene Hierarchy Sidebar" })
  vim.api.nvim_create_user_command("CocosHeirchary", function() M.toggle() end, { desc = "Toggle Cocos Scene Hierarchy Sidebar (Alias)" })
  vim.api.nvim_create_user_command("CocosOpen", function() M.open() end, { desc = "Open Cocos Scene Hierarchy Sidebar" })
  vim.api.nvim_create_user_command("CocosClose", function() M.close() end, { desc = "Close Cocos Scene Hierarchy Sidebar" })
  vim.api.nvim_create_user_command("CocosRefresh", function() M.refresh() end, { desc = "Refresh Cocos Scene Hierarchy" })
  vim.api.nvim_create_user_command("CocosSave", function() M.save() end, { desc = "Save Cocos Scene" })
end

--- Open hierarchy sidebar
function M.open()
  ui.open()
end

--- Close hierarchy sidebar
function M.close()
  ui.close()
end

--- Toggle hierarchy sidebar
function M.toggle()
  ui.toggle()
end

--- Refresh hierarchy
function M.refresh()
  ui.refresh(true)
end

--- Save active scene
function M.save()
  client.save_scene(function(err)
    if err then
      vim.notify("[Cocos] Save scene error: " .. tostring(err), vim.log.levels.ERROR)
    else
      vim.notify("[Cocos] Scene saved successfully!", vim.log.levels.INFO)
    end
  end)
end

return M
