local client = require("cocos.client")
local tree = require("cocos.tree")
local inspector = require("cocos.inspector")

local M = {}

M.win = nil
M.buf = nil
M.timer = nil

M.config = {
  sidebar_width = 36,
  sidebar_position = "left", -- "left" or "right"
  auto_refresh = true,
  refresh_interval = 3000,
}

--- Setup UI configuration
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

--- Define syntax highlight groups
local function setup_highlights()
  vim.api.nvim_set_hl(0, "CocosSceneRoot", { fg = "#7aa2f7", bold = true, default = true })
  vim.api.nvim_set_hl(0, "CocosNodeActive", { fg = "#c0caf5", default = true })
  vim.api.nvim_set_hl(0, "CocosNodeInactive", { fg = "#565f89", italic = true, default = true })
  vim.api.nvim_set_hl(0, "CocosFoldArrow", { fg = "#e0af68", default = true })
  vim.api.nvim_set_hl(0, "CocosScriptTag", { fg = "#9ece6a", italic = true, default = true })
  vim.api.nvim_set_hl(0, "CocosIcon", { fg = "#bb9af7", default = true })
end

--- Apply syntax highlights to lines
local function apply_highlights(buf)
  local ns = vim.api.nvim_create_namespace("cocos_hierarchy")
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  for line_idx, row in ipairs(tree.flat_rows) do
    local line_str = row.line_str
    local l_0 = line_idx - 1

    -- Highlight scene root or node
    if row.node.path == "/" then
      vim.api.nvim_buf_add_highlight(buf, ns, "CocosSceneRoot", l_0, 0, -1)
    elseif not row.is_active then
      vim.api.nvim_buf_add_highlight(buf, ns, "CocosNodeInactive", l_0, 0, -1)
    else
      vim.api.nvim_buf_add_highlight(buf, ns, "CocosNodeActive", l_0, 0, -1)
    end

    -- Highlight custom script tag
    local s_start, s_end = line_str:find("<.-%.ts>")
    if s_start and s_end then
      vim.api.nvim_buf_add_highlight(buf, ns, "CocosScriptTag", l_0, s_start - 1, s_end)
    end
  end
end

--- Refresh tree data from MCP daemon and re-render buffer
--- @param keep_cursor boolean|nil
function M.refresh(keep_cursor)
  client.query_full_tree(function(err, root)
    if err then
      vim.notify("[Cocos] Error querying tree: " .. tostring(err), vim.log.levels.WARN)
      return
    end

    if not root then return end

    local cur_cursor = nil
    if keep_cursor and M.win and vim.api.nvim_win_is_valid(M.win) then
      cur_cursor = vim.api.nvim_win_get_cursor(M.win)
    end

    tree.set_root(root)

    if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
      local lines = {}
      for _, r in ipairs(tree.flat_rows) do
        table.insert(lines, r.line_str)
      end

      vim.bo[M.buf].modifiable = true
      vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, lines)
      vim.bo[M.buf].modifiable = false

      apply_highlights(M.buf)

      if cur_cursor and M.win and vim.api.nvim_win_is_valid(M.win) then
        local max_line = #tree.flat_rows
        local target_line = math.min(cur_cursor[1], max_line > 0 and max_line or 1)
        pcall(vim.api.nvim_win_set_cursor, M.win, { target_line, cur_cursor[2] })
      end
    end
  end)
end

--- Go to script file for the node under cursor
local function jump_to_script()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local row = tree.get_row(line)
  if not row then return end

  local script_name = row.custom_script
  if not script_name then
    vim.notify("[Cocos] No user TypeScript script attached to node: " .. row.display_name, vim.log.levels.INFO)
    return
  end

  -- Search workspace for ScriptName.ts
  local target_file = script_name .. ".ts"
  local cwd = vim.fn.getcwd()
  local matches = vim.fs.find(target_file, { path = cwd, type = "file", limit = 1 })

  if #matches == 0 then
    -- Also try case-insensitive or assets/scripts/
    local assets_matches = vim.fs.find(function(name)
      return name:lower() == target_file:lower()
    end, { path = cwd, type = "file", limit = 1 })
    if #assets_matches > 0 then
      matches = assets_matches
    end
  end

  if #matches > 0 then
    local path = matches[1]
    -- Find a suitable window to open the file (avoid replacing hierarchy sidebar)
    local target_win = nil
    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if w ~= M.win then
        target_win = w
        break
      end
    end

    if target_win then
      vim.api.nvim_set_current_win(target_win)
      vim.cmd("edit " .. vim.fn.fnameescape(path))
    else
      vim.cmd("wincmd p")
      vim.cmd("edit " .. vim.fn.fnameescape(path))
    end
    vim.notify("[Cocos] Opened " .. path, vim.log.levels.INFO)
  else
    vim.notify("[Cocos] Could not find script file: " .. target_file, vim.log.levels.WARN)
  end
end

--- Toggle active property of node under cursor
local function toggle_active()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local row = tree.get_row(line)
  if not row or not row.node then return end

  local new_active = not row.is_active
  client.update_node(row.node.path, { active = new_active }, function(err)
    if err then
      vim.notify("[Cocos] Failed to toggle active: " .. tostring(err), vim.log.levels.ERROR)
    else
      vim.notify(string.format("[Cocos] %s active set to %s", row.display_name, tostring(new_active)), vim.log.levels.INFO)
      M.refresh(true)
    end
  end)
end

--- Rename node under cursor
local function rename_node()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local row = tree.get_row(line)
  if not row or not row.node or row.node.path == "/" then
    vim.notify("[Cocos] Cannot rename root scene", vim.log.levels.WARN)
    return
  end

  vim.ui.input({ prompt = "New name for " .. row.display_name .. ": ", default = row.display_name }, function(input)
    if not input or input == "" or input == row.display_name then return end
    client.rename_node(row.node.path, input, function(err)
      if err then
        vim.notify("[Cocos] Rename error: " .. tostring(err), vim.log.levels.ERROR)
      else
        vim.notify("[Cocos] Node renamed to: " .. input, vim.log.levels.INFO)
        M.refresh(true)
      end
    end)
  end)
end

--- Delete node under cursor
local function delete_node()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local row = tree.get_row(line)
  if not row or not row.node or row.node.path == "/" then
    vim.notify("[Cocos] Cannot delete root scene", vim.log.levels.WARN)
    return
  end

  vim.ui.select({ "Yes, delete", "No, cancel" }, {
    prompt = "Delete node '" .. row.display_name .. "'?",
  }, function(choice)
    if choice == "Yes, delete" then
      client.delete_node(row.node.path, function(err)
        if err then
          vim.notify("[Cocos] Delete error: " .. tostring(err), vim.log.levels.ERROR)
        else
          vim.notify("[Cocos] Deleted node: " .. row.display_name, vim.log.levels.INFO)
          M.refresh(false)
        end
      end)
    end
  end)
end

--- Add child node under cursor
local function add_child_node()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local row = tree.get_row(line)
  local parent_path = (row and row.node) and row.node.path or "/"

  local types = { "Empty", "2D/Sprite", "Camera", "Canvas", "3D/Cube", "3D/Sphere", "Light/Directional" }
  vim.ui.select(types, { prompt = "Select Node Type to create under " .. parent_path .. ":" }, function(selected_type)
    if not selected_type then return end
    vim.ui.input({ prompt = "Enter node name (optional): " }, function(node_name)
      local name_arg = (node_name and node_name ~= "") and node_name or nil
      client.create_node(parent_path, selected_type, name_arg, function(err)
        if err then
          vim.notify("[Cocos] Create node error: " .. tostring(err), vim.log.levels.ERROR)
        else
          vim.notify("[Cocos] Created node under: " .. parent_path, vim.log.levels.INFO)
          tree.expanded_paths[parent_path] = true
          M.refresh(true)
        end
      end)
    end)
  end)
end

--- Save scene
local function save_scene()
  client.save_scene(function(err)
    if err then
      vim.notify("[Cocos] Save scene error: " .. tostring(err), vim.log.levels.ERROR)
    else
      vim.notify("[Cocos] Scene saved successfully!", vim.log.levels.INFO)
    end
  end)
end

--- Run preview scene in browser
local function run_preview_scene()
  local url = "http://localhost:9527/"
  if tree.root_node and tree.root_node.name then
    local scene_name = tree.root_node.name
    url = string.format("http://localhost:9527/?scene=db://assets/scene/%s.scene", scene_name)
  end

  vim.notify("[Cocos] Opening Preview: " .. url, vim.log.levels.INFO)
  if vim.ui.open then
    vim.ui.open(url)
  else
    vim.fn.jobstart({ "cmd.exe", "/c", "start", url }, { detach = true })
  end
end

--- Build project
local function run_build_project()
  vim.ui.select({ "web-mobile", "web-desktop" }, {
    prompt = "Select Build Platform [b]:",
  }, function(platform)
    if not platform then return end
    vim.notify("[Cocos] Building project for " .. platform .. "... Please wait.", vim.log.levels.INFO)
    client.build_project(platform, function(err, result)
      if err then
        vim.notify("[Cocos] Build error: " .. tostring(err), vim.log.levels.ERROR)
      else
        vim.notify("[Cocos] Build SUCCESS for " .. platform .. "! Output in build/" .. platform, vim.log.levels.INFO)
      end
    end)
  end)
end

--- Attach keymaps to hierarchy buffer
local function setup_buffer_keymaps(buf)
  -- Turn off every base keybind on this buffer:
  -- Trap all unused keys to <Nop> with nowait = true
  local trap_keys = {
    "c", "e", "f", "h", "i", "l", "m", "n", "t", "u", "v", "w", "x", "y", "z",
    "A", "B", "C", "D", "F", "H", "I", "J", "L", "M", "N", "O", "P", "Q", "S", "T", "U", "V", "X", "Y", "Z",
    "<C-v>", "<C-r>", "<C-a>", "<C-x>",
  }
  for _, k in ipairs(trap_keys) do
    vim.keymap.set({ "n", "v" }, k, "<Nop>", { buffer = buf, nowait = true, silent = true })
  end

  local map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = buf, nowait = true, silent = true, desc = desc })
  end

  -- Close / Toggle
  map("<M-2>", function() M.close() end, "Close Cocos Hierarchy")
  map("<A-2>", function() M.close() end, "Close Cocos Hierarchy")
  map("q", function() M.close() end, "Close Cocos Hierarchy")

  -- Preview & Build actions
  map("p", run_preview_scene, "Run Preview Scene")
  map("b", run_build_project, "Build Project")

  -- Toggle fold
  map("<CR>", function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    if tree.toggle_fold(line) then
      local lines = {}
      for _, r in ipairs(tree.flat_rows) do
        table.insert(lines, r.line_str)
      end
      vim.bo[buf].modifiable = true
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.bo[buf].modifiable = false
      apply_highlights(buf)
    end
  end, "Toggle Fold")

  map("o", function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    if tree.toggle_fold(line) then
      local lines = {}
      for _, r in ipairs(tree.flat_rows) do
        table.insert(lines, r.line_str)
      end
      vim.bo[buf].modifiable = true
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.bo[buf].modifiable = false
      apply_highlights(buf)
    end
  end, "Toggle Fold")

  -- Go to Script
  map("gd", jump_to_script, "Go to Attached Script")
  map("<C-]>", jump_to_script, "Go to Attached Script")

  -- Toggle active
  map("<Space>", toggle_active, "Toggle Node Active/Visible")

  -- Inspector
  map("K", function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local row = tree.get_row(line)
    if row and row.node then inspector.open(row.node) end
  end, "Open Node Inspector")

  -- Node CRUD
  map("r", rename_node, "Rename Node")
  map("d", delete_node, "Delete Node")
  map("dd", delete_node, "Delete Node")
  map("a", add_child_node, "Add Child Node")
  map("s", save_scene, "Save Active Scene")

  -- Tree controls
  map("R", function() M.refresh(true) end, "Refresh Hierarchy")
  map("E", function() tree.expand_all(); M.refresh(true) end, "Expand All")
  map("W", function() tree.collapse_all(); M.refresh(true) end, "Collapse All")
end

--- Start auto-refresh polling timer
local function start_auto_refresh()
  if not M.config.auto_refresh then return end
  if M.timer then return end

  local timer = vim.uv.new_timer()
  timer:start(M.config.refresh_interval, M.config.refresh_interval, vim.schedule_wrap(function()
    if M.buf and vim.api.nvim_buf_is_valid(M.buf) and M.win and vim.api.nvim_win_is_valid(M.win) then
      M.refresh(true)
    else
      M.stop_auto_refresh()
    end
  end))
  M.timer = timer
end

--- Stop auto-refresh timer
function M.stop_auto_refresh()
  if M.timer then
    M.timer:stop()
    M.timer:close()
    M.timer = nil
  end
end

--- Open or toggle Cocos Hierarchy sidebar window
function M.toggle()
  if M.win and vim.api.nvim_win_is_valid(M.win) then
    M.close()
  else
    M.open()
  end
end

--- Open Cocos Hierarchy sidebar window
function M.open()
  setup_highlights()

  if M.win and vim.api.nvim_win_is_valid(M.win) then
    vim.api.nvim_set_current_win(M.win)
    return
  end

  -- Create scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.api.nvim_buf_set_name(buf, "Cocos Hierarchy")

  -- Open split window on chosen side
  local split_cmd = M.config.sidebar_position == "right" and "botright vertical split" or "topleft vertical split"
  vim.cmd(split_cmd)
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_win_set_width(win, M.config.sidebar_width)

  -- Window options
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].wrap = false
  vim.wo[win].spell = false
  vim.wo[win].cursorline = true
  vim.wo[win].winfixwidth = true

  M.buf = buf
  M.win = win

  setup_buffer_keymaps(buf)
  M.refresh(false)
  start_auto_refresh()
end

--- Close sidebar window
function M.close()
  M.stop_auto_refresh()
  if M.win and vim.api.nvim_win_is_valid(M.win) then
    vim.api.nvim_win_close(M.win, true)
    M.win = nil
  end
  if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
    pcall(vim.api.nvim_buf_delete, M.buf, { force = true })
    M.buf = nil
  end
end

return M
