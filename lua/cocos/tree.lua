local M = {}

M.expanded_paths = {
  ["/"] = true,
  ["Canvas"] = true,
}

M.flat_rows = {}
M.root_node = nil

--- Detect appropriate icon for node based on name and components
--- @param node table
--- @return string icon, string comp_summary
function M.get_node_icon(node)
  if node.path == "/" then
    return "󰙵", "Scene"
  end

  local comps = node.components or {}
  local comp_names = {}
  local has_canvas = false
  local has_camera = false
  local has_graphics = false
  local has_sprite = false
  local has_label = false
  local custom_script = nil

  for _, c in ipairs(comps) do
    local ctype = c.type or c.name or ""
    table.insert(comp_names, ctype)
    if ctype:find("Canvas") then has_canvas = true end
    if ctype:find("Camera") then has_camera = true end
    if ctype:find("Graphics") then has_graphics = true end
    if ctype:find("Sprite") then has_sprite = true end
    if ctype:find("Label") then has_label = true end
    if not ctype:find("^cc%.") and not ctype:find("^sp%.") and not ctype:find("^dragonBones%.") then
      custom_script = ctype
    end
  end

  if has_canvas then
    return "󰹑", table.concat(comp_names, ", ")
  elseif has_camera then
    return "󰄀", table.concat(comp_names, ", ")
  elseif has_graphics then
    return "󱁤", table.concat(comp_names, ", ")
  elseif has_sprite then
    return "", table.concat(comp_names, ", ")
  elseif has_label then
    return "󰈙", table.concat(comp_names, ", ")
  elseif custom_script then
    return "󰓹", table.concat(comp_names, ", ")
  elseif #comps > 0 then
    return "󰅪", table.concat(comp_names, ", ")
  else
    return "", ""
  end
end

--- Get primary user script name on node (if any)
--- @param node table
--- @return string|nil
function M.get_custom_script_name(node)
  local comps = node.components or {}
  for _, c in ipairs(comps) do
    local ctype = c.type or c.name or ""
    if not ctype:find("^cc%.") and not ctype:find("^sp%.") and not ctype:find("^dragonBones%.") then
      return ctype
    end
  end
  return nil
end

--- Rebuild flat_rows array from root_node AST respecting expanded_paths
function M.rebuild_flat_rows()
  M.flat_rows = {}
  if not M.root_node then return end

  local function traverse(node, depth)
    local has_children = node.children and #node.children > 0
    local is_expanded = M.expanded_paths[node.path or node.name] == true

    local icon, comp_summary = M.get_node_icon(node)
    local arrow = "  "
    if has_children then
      arrow = is_expanded and "▾ " or "▸ "
    end

    local indent = string.rep("  ", depth)
    local active_tag = ""
    local is_active = true
    if node.properties and node.properties.active ~= nil then
      is_active = node.properties.active
      active_tag = is_active and " [👁]" or " [󰈈 off]"
    end

    local display_name = node.name or node.nodeId or "Node"
    local script_tag = ""
    local custom_script = M.get_custom_script_name(node)
    if custom_script then
      script_tag = " <" .. custom_script .. ".ts>"
    end

    local line_str = string.format("%s%s%s %s%s%s", indent, arrow, icon, display_name, active_tag, script_tag)

    local row = {
      node = node,
      depth = depth,
      has_children = has_children,
      is_expanded = is_expanded,
      line_str = line_str,
      display_name = display_name,
      custom_script = custom_script,
      is_active = is_active,
      comp_summary = comp_summary,
    }

    table.insert(M.flat_rows, row)

    if has_children and is_expanded then
      for _, child in ipairs(node.children) do
        traverse(child, depth + 1)
      end
    end
  end

  traverse(M.root_node, 0)
end

--- Set new root node AST and update flat rows
--- @param root table
function M.set_root(root)
  M.root_node = root
  M.rebuild_flat_rows()
end

--- Toggle fold at row index (1-indexed)
--- @param row_idx number
--- @return boolean success
function M.toggle_fold(row_idx)
  local row = M.flat_rows[row_idx]
  if not row or not row.has_children then return false end
  local path = row.node.path or row.node.name
  M.expanded_paths[path] = not M.expanded_paths[path]
  M.rebuild_flat_rows()
  return true
end

--- Expand all nodes
function M.expand_all()
  local function expand(node)
    if node.path then M.expanded_paths[node.path] = true end
    for _, ch in ipairs(node.children or {}) do
      expand(ch)
    end
  end
  if M.root_node then expand(M.root_node) end
  M.rebuild_flat_rows()
end

--- Collapse all nodes (except root)
function M.collapse_all()
  M.expanded_paths = { ["/"] = true }
  M.rebuild_flat_rows()
end

--- Get row at 1-indexed line
--- @param line_idx number
--- @return table|nil
function M.get_row(line_idx)
  return M.flat_rows[line_idx]
end

return M
