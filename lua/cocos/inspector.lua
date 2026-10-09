local M = {}

M.win = nil
M.buf = nil

--- Open floating inspector for a node
--- @param node table
function M.open(node)
  if not node then return end

  -- If already open, close old window
  if M.win and vim.api.nvim_win_is_valid(M.win) then
    vim.api.nvim_win_close(M.win, true)
  end

  local lines = {}
  table.insert(lines, "  󰅪 Cocos Node Inspector")
  table.insert(lines, "  " .. string.rep("─", 44))
  table.insert(lines, string.format("  Name:     %s", node.name or "Unnamed"))
  table.insert(lines, string.format("  Path:     %s", node.path or "/"))
  table.insert(lines, string.format("  Node ID:  %s", node.nodeId or "-"))

  local props = node.properties or {}
  local is_active = props.active ~= false
  table.insert(lines, string.format("  Active:   %s", is_active and "● YES" or "○ NO"))
  table.insert(lines, string.format("  Layer:    %s", tostring(props.layer or 0)))

  table.insert(lines, "")
  table.insert(lines, "  󰚥 Transform:")
  local pos = props.position or { x = 0, y = 0, z = 0 }
  local rot = props.rotation or { x = 0, y = 0, z = 0 }
  local scl = props.scale or { x = 1, y = 1, z = 1 }

  table.insert(lines, string.format("    Position: (%.2f, %.2f, %.2f)", pos.x or 0, pos.y or 0, pos.z or 0))
  table.insert(lines, string.format("    Rotation: (%.2f, %.2f, %.2f)", rot.x or 0, rot.y or 0, rot.z or 0))
  table.insert(lines, string.format("    Scale:    (%.2f, %.2f, %.2f)", scl.x or 1, scl.y or 1, scl.z or 1))

  table.insert(lines, "")
  local comps = node.components or {}
  table.insert(lines, string.format("  󰘳 Components (%d):", #comps))
  if #comps == 0 then
    table.insert(lines, "    (none)")
  else
    for i, c in ipairs(comps) do
      local ctype = c.type or c.cid or c.name or "Component"
      local enabled_str = (c.enabled ~= false) and "enabled" or "disabled"
      table.insert(lines, string.format("    [%d] %s (%s)", i, ctype, enabled_str))
      if c.uuid then
        table.insert(lines, string.format("        uuid: %s", c.uuid))
      end
    end
  end

  table.insert(lines, "")
  table.insert(lines, "  [q / Esc] Close")

  -- Calculate width and height
  local max_len = 50
  for _, l in ipairs(lines) do
    if #l > max_len then max_len = #l end
  end
  local width = math.min(max_len + 4, vim.o.columns - 10)
  local height = math.min(#lines, vim.o.lines - 6)

  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    border = "rounded",
    title = " Cocos Inspector ",
    title_pos = "center",
    style = "minimal",
  })

  M.buf = buf
  M.win = win

  -- Keybindings to close
  local close_fn = function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  vim.keymap.set("n", "q", close_fn, { buffer = buf, nowait = true, silent = true })
  vim.keymap.set("n", "<Esc>", close_fn, { buffer = buf, nowait = true, silent = true })
end

return M
