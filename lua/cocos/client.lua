local M = {}

M.config = {
  mcp_url = "http://localhost:9528/mcp",
  timeout = 5000,
}

local req_id = 0

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

--- Make generic JSON-RPC MCP tool call
--- @param tool_name string
--- @param args table
--- @param callback fun(err: string|nil, result: any)
function M.call_tool(tool_name, args, callback)
  req_id = req_id + 1
  local payload = vim.json.encode({
    jsonrpc = "2.0",
    id = req_id,
    method = "tools/call",
    params = {
      name = tool_name,
      arguments = args or {},
    },
  })

  local cmd = {
    "curl.exe",
    "-s",
    "-X", "POST",
    M.config.mcp_url,
    "-H", "Content-Type: application/json",
    "-H", "Accept: application/json, text/event-stream",
    "--data-binary", "@-",
  }

  vim.system(cmd, {
    stdin = payload,
    text = true,
    timeout = M.config.timeout,
  }, function(obj)
    vim.schedule(function()
      if obj.code ~= 0 then
        callback("curl error (exit " .. obj.code .. "): " .. (obj.stderr or ""), nil)
        return
      end

      local ok, resp = pcall(vim.json.decode, obj.stdout)
      if not ok or not resp then
        callback("Failed to parse JSON response: " .. tostring(obj.stdout), nil)
        return
      end

      if resp.error then
        callback("MCP Error " .. tostring(resp.error.code) .. ": " .. tostring(resp.error.message), nil)
        return
      end

      -- Extract data from MCP result structure
      local res = resp.result
      if res and res.structuredContent and res.structuredContent.result then
        local inner = res.structuredContent.result
        if inner.code and inner.code ~= 200 and inner.reason then
          callback("Scene Error: " .. inner.reason, nil)
          return
        end
        callback(nil, inner.data)
        return
      end

      if res and res.content and res.content[1] and res.content[1].text then
        local tok, text_json = pcall(vim.json.decode, res.content[1].text)
        if tok and text_json and text_json.result then
          local inner = text_json.result
          if inner.code and inner.code ~= 200 and inner.reason then
            callback("Scene Error: " .. inner.reason, nil)
            return
          end
          callback(nil, inner.data)
          return
        end
        callback(nil, res.content[1].text)
        return
      end

      callback(nil, res)
    end)
  end)
end

--- Query a specific node
--- @param path string
--- @param callback fun(err: string|nil, node: any)
function M.query_node(path, callback)
  M.call_tool("scene-query-node", {
    options = {
      path = path,
      includeChildren = true,
      includeComponents = true,
    },
  }, callback)
end

--- Recursively fetch full scene tree starting from root "/"
--- @param callback fun(err: string|nil, root: any)
function M.query_full_tree(callback)
  M.query_node("/", function(err, root)
    if err then
      callback(err, nil)
      return
    end
    if not root then
      callback("Root node not found", nil)
      return
    end

    local function populate_children(parent, done)
      if not parent.children or #parent.children == 0 then
        done()
        return
      end

      local total = #parent.children
      local pending = total
      local detailed_children = {}

      for i, child_stub in ipairs(parent.children) do
        local child_path = child_stub.path or child_stub.name
        M.query_node(child_path, function(ch_err, detailed_child)
          pending = pending - 1
          if not ch_err and detailed_child then
            detailed_children[i] = detailed_child
            populate_children(detailed_child, function()
              if pending == 0 then
                parent.children = detailed_children
                done()
              end
            end)
          else
            detailed_children[i] = child_stub
            if pending == 0 then
              parent.children = detailed_children
              done()
            end
          end
        end)
      end
    end

    populate_children(root, function()
      callback(nil, root)
    end)
  end)
end

--- Update node properties (e.g. active, name, transform)
--- @param path string
--- @param properties table
--- @param callback fun(err: string|nil, result: any)
function M.update_node(path, properties, callback)
  M.call_tool("scene-update-node", {
    options = {
      path = path,
      properties = properties,
    },
  }, callback)
end

--- Rename node
--- @param path string
--- @param new_name string
--- @param callback fun(err: string|nil, result: any)
function M.rename_node(path, new_name, callback)
  M.call_tool("scene-update-node", {
    options = {
      path = path,
      name = new_name,
    },
  }, callback)
end

--- Delete node
--- @param path string
--- @param callback fun(err: string|nil, result: any)
function M.delete_node(path, callback)
  M.call_tool("scene-delete-node", {
    options = {
      path = path,
    },
  }, callback)
end

--- Create node by type
--- @param parent_path string
--- @param node_type string
--- @param name string|nil
--- @param callback fun(err: string|nil, result: any)
function M.create_node(parent_path, node_type, name, callback)
  M.call_tool("scene-create-node-by-type", {
    options = {
      path = parent_path,
      nodeType = node_type or "Empty",
      name = name,
    },
  }, callback)
end

--- Save active scene
--- @param callback fun(err: string|nil, result: any)
function M.save_scene(callback)
  M.call_tool("scene-save", {}, callback)
end

--- Build project
--- @param platform string|nil e.g. "web-mobile"
--- @param callback fun(err: string|nil, result: any)
function M.build_project(platform, callback)
  M.call_tool("builder-build", {
    platform = platform or "web-mobile",
  }, callback)
end

--- Query currently opened scene info
--- @param callback fun(err: string|nil, result: any)
function M.query_current_scene(callback)
  M.call_tool("scene-query-current", {}, callback)
end

return M
