function generate_uuid()
    math.randomseed(os.time())
    local random = math.random
    local template = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

    return string.gsub(
        template, "x", function()
            local v = random(0, 0xf)      -- v is a decimal number 0 to 15

            return string.format("%x", v) --formatted as a hex number
        end)
end

function is_function(callback)
    return type(callback) == "function"
end

function notify(message)
    print('[Notify]: ' .. message)
end

-- Declare global variable named: `pTS`
pTS = {
    cursor =
    {
        column = false,
        line = true
    },
    wrap = false
}

-- Declare based class

Based = {}

function Based:new() -- Constructor
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function toggle(checker, global_cb, true_cb, false_cb)
    if is_function(true_cb) and is_function(false_cb) then
        if is_function(global_cb) then global_cb() end

        if checker then
            true_cb()
        else
            false_cb()
        end
    else
        print("[Notify]: Invalid function at `toggle(...)`")
    end
end

-- Define a function to toggle the cursor column
function toggle_cursor_column()
    pTS.cursor.column = not pTS.cursor.column

    if pTS.cursor.column then
        GWo.cursorcolumn = true
        print("[Notify]: Turn on CursorColumn")
    else
        GWo.cursorcolumn = false
        print("[Notify]: Turn off CursorColumn")
    end
end
-- Create a key mapping to call the function when pressing <Leader>fc

GKeymap.set('n', '<Leader><Leader>c', [[:lua toggle(pTS.cursor.column, function() pTS.cursor.column = not pTS.cursor.column end, function() vim.wo.cursorcolumn = false notify('Cursor coloumn: OFF') end, function() vim.wo.cursorcolumn = true notify('Cursor coloumn: ON') end)<CR>]], GQuickOpt('[ ] Toggle cursor [C]oloumn'))
GKeymap.set('n', '<Leader><Leader>l', [[:lua toggle(pTS.cursor.line, function() pTS.cursor.line = not pTS.cursor.line end, function() vim.wo.cursorline = false notify('Cursor line: OFF') end, function() vim.wo.cursorline = true notify('Cursor line: ON') end)<CR>]], GQuickOpt('[ ] Toggle cursor [L]ine'))
GKeymap.set('n', '<Leader><Leader>w', [[:lua toggle(pTS.wrap, function() pTS.wrap = not pTS.wrap end, function() GOpts.wrap = false notify('Wrap line mode: OFF') end, function() GOpts.wrap = true notify('Wrap line mode: ON') end)<CR>]], GQuickOpt('[ ] Toggle [W]rap line mode'))

_G.qnmap('<Leader>qg', '<ESC>ipublic<ESC>', '[Q]uick [G]lobal (public) key' )
_G.qnmap('<Leader>qm', '<ESC>iprotected<ESC>', '[Q]uick [M]ember (protected) key' )
_G.qnmap('<Leader>qp', '<ESC>iprivate<ESC>', '[Q]uick [P]rivate key' )

_G.qnmap('<Leader><Leader>cp', '<ESC>i@property()<ESC>i', '[C]ocos Creator [P]roperty key' )

local function insert_cocos_component()
    local org_buf = vim.api.nvim_get_current_buf()
    local org_win = vim.api.nvim_get_current_win()
    local cursor_pos = vim.api.nvim_win_get_cursor(org_win)
    local row, col = cursor_pos[1], cursor_pos[2]

    -- Create scratch buffer for the popup input
    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.bo[buf].filetype = "cocos_input"

    -- Calculate size and position to center the popup
    local width = 50
    local height = 1
    local editor_width = vim.o.columns
    local editor_height = vim.o.lines

    local win_row = math.floor((editor_height - height) / 2) - 1
    local win_col = math.floor((editor_width - width) / 2)

    local opts = {
        relative = "editor",
        width = width,
        height = height,
        row = win_row,
        col = win_col,
        style = "minimal",
        border = "rounded",
        title = " Create Cocos Component ",
        title_pos = "center",
    }

    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Show placeholder virtual text using extmark
    local ns = vim.api.nvim_create_namespace("cocos_placeholder")
    local function update_placeholder()
        if not vim.api.nvim_buf_is_valid(buf) then return end
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
        if #lines == 1 and lines[1] == "" then
            vim.api.nvim_buf_set_extmark(buf, ns, 0, 0, {
                virt_text = { { "what do u want ...", "Comment" } },
                virt_text_pos = "overlay",
            })
        end
    end

    update_placeholder()

    -- Set up autocommands to update placeholder on text change
    local group = vim.api.nvim_create_augroup("CocosPlaceholder_" .. buf, { clear = true })
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
        group = group,
        buffer = buf,
        callback = update_placeholder,
    })

    -- Function to close the input window cleanly
    local function close_win()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end

    -- Function to submit the name and generate code
    local function submit()
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local name = vim.trim(lines[1] or "")
        close_win()

        if name == "" then
            vim.notify("Component name cannot be empty", vim.log.levels.WARN)
            return
        end

        -- Generate code with name replaced
        local generated = {
            "import { _decorator, Component } from 'cc';",
            "",
            "const { ccclass, property } = _decorator;",
            "",
            string.format("@ccclass('%s')", name),
            string.format("export class %s extends Component {", name),
            "    ",
            "}"
        }

        -- Replace the current line in the original buffer with the generated code
        if vim.api.nvim_buf_is_valid(org_buf) then
            vim.api.nvim_buf_set_lines(org_buf, row - 1, row, false, generated)

            -- Switch back to original window and position cursor
            if vim.api.nvim_win_is_valid(org_win) then
                vim.api.nvim_set_current_win(org_win)
                -- The cursor should go to the line with 4 spaces (7th line of generated block)
                local target_line = row - 1 + 7
                vim.api.nvim_win_set_cursor(org_win, { target_line, 4 })
                vim.cmd("startinsert!")
            end
        end
    end

    -- Map Enter to submit in both insert and normal mode inside the popup
    vim.keymap.set("i", "<CR>", submit, { buffer = buf, silent = true, noremap = true })
    vim.keymap.set("n", "<CR>", submit, { buffer = buf, silent = true, noremap = true })

    -- Map Escape/C-c to close window in both insert and normal mode inside the popup
    vim.keymap.set("i", "<Esc>", close_win, { buffer = buf, silent = true, noremap = true })
    vim.keymap.set("n", "<Esc>", close_win, { buffer = buf, silent = true, noremap = true })
    vim.keymap.set("i", "<C-c>", close_win, { buffer = buf, silent = true, noremap = true })
    vim.keymap.set("n", "<C-c>", close_win, { buffer = buf, silent = true, noremap = true })

    -- Start in insert mode right away
    vim.cmd("startinsert")
end

local function rename_word_popup()
    local org_buf = vim.api.nvim_get_current_buf()
    local org_win = vim.api.nvim_get_current_win()

    -- Create scratch buffer for the popup input
    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.bo[buf].filetype = "rename_input"

    -- Calculate options for popup window positioned above the cursor
    local opts = {
        relative = "cursor",
        width = 30,
        height = 1,
        row = -3,
        col = 0,
        style = "minimal",
        border = "rounded",
        title = " Rename ",
        title_pos = "center",
    }

    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Function to close the window cleanly
    local function close_win()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end

    -- Function to submit the rename
    local function submit()
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local input_val = vim.trim(lines[1] or "")
        close_win()

        if input_val == "" then
            return
        end

        -- Focus back the original window to perform the search & replace
        if vim.api.nvim_win_is_valid(org_win) then
            vim.api.nvim_set_current_win(org_win)
        end

        -- Back to normal mode (stopinsert)
        vim.cmd("stopinsert")

        -- Call * to highlight the word all over current file
        vim.cmd("normal! *")

        -- Call command :%s//the_input_value_user_just_puted_inside_the_popup and hit enter
        vim.cmd("%s//" .. input_val)
    end

    -- Map Enter to submit in insert and normal modes inside the popup buffer
    vim.keymap.set("i", "<CR>", submit, { buffer = buf, silent = true, noremap = true })
    vim.keymap.set("n", "<CR>", submit, { buffer = buf, silent = true, noremap = true })

    -- Map Escape to close the window in insert and normal modes inside the popup buffer
    vim.keymap.set("i", "<Esc>", close_win, { buffer = buf, silent = true, noremap = true })
    vim.keymap.set("n", "<Esc>", close_win, { buffer = buf, silent = true, noremap = true })

    -- Also handle Ctrl-C as Escape/close window just to be user-friendly
    vim.keymap.set("i", "<C-c>", close_win, { buffer = buf, silent = true, noremap = true })
    vim.keymap.set("n", "<C-c>", close_win, { buffer = buf, silent = true, noremap = true })

    -- Focus cursor on that popup buffer and stand in insert mode
    vim.cmd("startinsert")
end

_G.qnmap('<Leader>ri', rename_word_popup, 'Rename word under cursor via popup')

_G.qnmap('<leader>fa', insert_cocos_component, 'Create Cocos Creator Component')
_G.qimap('<C-CR>', insert_cocos_component, 'Create Cocos Creator Component')
_G.qimap('<C-Enter>', insert_cocos_component, 'Create Cocos Creator Component')
