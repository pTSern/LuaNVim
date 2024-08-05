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

