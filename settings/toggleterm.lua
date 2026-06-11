local toggleterm = require("toggleterm")

toggleterm.setup({
  size = 20,
  open_mapping = [[<F8>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  persist_mode = false,
  direction = 'float',
  close_on_exit = true,
  auto_scroll = true,
  shell = vim.o.shell,
  float_opts = {
    border = 'curved',
    winblend = 3,
  }
})

-- Function to update window title and footer manually
local function update_terminal_ui(term)
    if not term then return end
    local terms = require("toggleterm.terminal").get_all()
    
    table.sort(terms, function(a, b) return a.id < b.id end)
    
    local display_idx = 1
    for i, t in ipairs(terms) do
        if t.id == term.id then
            display_idx = i
            break
        end
    end

    local title = string.format(" [ Terminal %d/%d ] ", display_idx, #terms)
    
    -- Mode detection
    local m = vim.api.nvim_get_mode().mode
    local current_mode = " TERMINAL "
    if m == 'n' or m == 'nt' then
        current_mode = " NORMAL "
    elseif m == 'i' or m == 't' then
        current_mode = " INSERT "
    elseif m:find('v') or m:find('V') or m == '' then
        current_mode = " VISUAL "
    end
    
    -- Special label for exclusive terminal
    if vim.b[term.bufnr] and vim.b[term.bufnr].is_exclusive then
        title = " [ EXCLUSIVE SHELL ] "
        current_mode = " STANDALONE "
    end

    local footer = string.format(" %s ", current_mode)

    if term.window and vim.api.nvim_win_is_valid(term.window) then
        pcall(vim.api.nvim_win_set_config, term.window, { 
            title = title, 
            title_pos = "center",
            footer = footer,
            footer_pos = "center"
        })
    end
end

-- Helper to find the next available terminal ID and open it
local function open_new_terminal()
  local terminals = require("toggleterm.terminal").get_all()
  local max_id = 0
  for _, term in ipairs(terminals) do
    if term.id > max_id then
      max_id = term.id
    end
  end
  vim.cmd((max_id + 1) .. "ToggleTerm")
end

-- Generic switch function
local function switch_to_term(id, force_mode)
    vim.cmd(id .. "ToggleTerm")
    if force_mode == 'n' then
        vim.cmd("stopinsert")
    elseif force_mode == 'i' then
        vim.cmd("startinsert")
    end
    
    vim.defer_fn(function()
        local term = require("toggleterm.terminal").get(id)
        update_terminal_ui(term)
    end, 20)
end

-- Navigation logic
local function goto_term_relative(delta, force_mode)
    local terms = require("toggleterm.terminal").get_all()
    if #terms <= 1 then return end
    table.sort(terms, function(a, b) return a.id < b.id end)
    local current_id = require("toggleterm.terminal").get_focused_id()
    if not current_id then return end
    
    local next_idx = 1
    for i, term in ipairs(terms) do
        if term.id == current_id then
            next_idx = i + delta
            if next_idx > #terms then next_idx = 1 end
            if next_idx < 1 then next_idx = #terms end
            break
        end
    end
    
    vim.cmd(current_id .. "ToggleTerm")
    switch_to_term(terms[next_idx].id, force_mode)
end

local function goto_term_index(idx, force_mode)
    local terms = require("toggleterm.terminal").get_all()
    if idx > #terms or idx < 1 then return end
    table.sort(terms, function(a, b) return a.id < b.id end)
    local current_id = require("toggleterm.terminal").get_focused_id()
    if current_id then
        vim.cmd(current_id .. "ToggleTerm")
    end
    switch_to_term(terms[idx].id, force_mode)
end

local function kill_current_terminal()
    local current_id = require("toggleterm.terminal").get_focused_id()
    if not current_id then return end
    local term = require("toggleterm.terminal").get(current_id)
    if term then
        local terms = require("toggleterm.terminal").get_all()
        if #terms <= 1 then
            term:shutdown()
            vim.cmd("ToggleTerm")
        else
            goto_term_relative(-1, nil)
            term:shutdown()
        end
    end
end

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  
  -- Check if this is the exclusive terminal
  if vim.b.is_exclusive then
    -- In exclusive mode, only F8 can hide the window
    -- We DON'T map esc or jk, so they go to the shell
    return 
  end

  -- Navigation
  vim.keymap.set('t', '<S-Right>', function() goto_term_relative(1, 'i') end, opts)
  vim.keymap.set('t', '<S-Left>', function() goto_term_relative(-1, 'i') end, opts)
  vim.keymap.set('n', '<Tab>j', function() goto_term_relative(-1, nil) end, opts)
  vim.keymap.set('n', '<Tab>k', function() goto_term_relative(1, nil) end, opts)
  for i = 1, 9 do
    vim.keymap.set('n', '<Tab>' .. i, function() goto_term_index(i, nil) end, opts)
  end

  -- Escape
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  
  -- Window navigation
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

  -- Creation
  vim.keymap.set('t', '<C-t>', open_new_terminal, opts)
  vim.keymap.set('n', '<C-t>', open_new_terminal, opts)
  
  -- Kill
  vim.keymap.set('n', 'Q', kill_current_terminal, opts)
end

-- Auto-commands
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function(ev)
        _G.set_terminal_keymaps()
        vim.defer_fn(function()
            local current_id = require("toggleterm.terminal").get_focused_id()
            if current_id then
                update_terminal_ui(require("toggleterm.terminal").get(current_id))
            end
        end, 50)
    end
})

vim.api.nvim_create_autocmd({"ModeChanged"}, {
    callback = function()
        local current_id = require("toggleterm.terminal").get_focused_id()
        if current_id then
            update_terminal_ui(require("toggleterm.terminal").get(current_id))
        end
    end
})

-- Custom terminals
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

-- EXCLUSIVE TERMINAL
local exclusive_term = Terminal:new({
    cmd = vim.o.shell,
    hidden = true,
    direction = "float",
    on_open = function(term)
        vim.b[term.bufnr].is_exclusive = true
        vim.cmd("startinsert!")
    end,
})

function _G.exclusive_terminal_toggle()
  exclusive_term:toggle()
end

GKeymap.set("n", "<leader>lg", "<cmd>lua _G.lazygit_toggle()<CR>", GQuickOpt("[L]azy[G]it Toggle"))
GKeymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", GQuickOpt("[T]oggle [T]erminal"))
GKeymap.set("n", "<F8>", "<cmd>ToggleTerm<CR>", GDfgConfig)
GKeymap.set("i", "<F8>", "<esc><cmd>ToggleTerm<CR>", GDfgConfig)
GKeymap.set("t", "<F8>", [[<C-\><C-n><cmd>ToggleTerm<CR>]], GDfgConfig)

-- Exclusive Terminal Keybind (Ctrl+Shift+T)
GKeymap.set({"n", "i", "t"}, "<C-S-T>", "<cmd>lua _G.exclusive_terminal_toggle()<CR>", GQuickOpt("Toggle [Exclusive] Shell"))

GKeymap.set("n", "<Leader><Leader>t", open_new_terminal, GQuickOpt("Open [ ] New [T]erminal"))
GKeymap.set("n", "<Leader><Leader>n", function() goto_term_relative(1, nil) end, GQuickOpt("Next [ ] Terminal [N]ext"))
GKeymap.set("n", "<Leader><Leader>p", function() goto_term_relative(-1, nil) end, GQuickOpt("Prev [ ] Terminal [P]rev"))
