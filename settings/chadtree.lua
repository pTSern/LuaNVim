local keymap = vim.keymap

keymap.set('n', '<M-1>', ':CHADopen<CR>', { silent = true })
keymap.set('n', '<F1>', ':CHADopen<CR>', { silent = true })
keymap.set('x', '<F1>', '<ESC>:CHADopen<CR>', { silent = true })
keymap.set('i', '<F1>', '<ESC>:CHADopen<CR>', { silent = true })

local function chadtree_zip_unzip()
    local clipboard_before = vim.fn.getreg('+')
    
    if CHAD and CHAD.Copy_basename then
        CHAD.Copy_basename({false})
    else
        vim.api.nvim_feedkeys("y", "x", true)
    end
    
    local raw_paths = vim.trim(vim.fn.getreg('+'))
    vim.fn.setreg('+', clipboard_before)
    
    if raw_paths == "" then
        print("[Notify]: No file or folder selected in CHADTree")
        return
    end

    local paths = {}
    for p in raw_paths:gmatch("[^\r\n]+") do
        table.insert(paths, p:gsub('\\', '/'))
    end

    if #paths == 0 then return end

    local cmd
    if #paths == 1 then
        local path = paths[1]
        local is_zip = path:match("%.zip$") ~= nil
        if is_zip then
            local dest = path:gsub("%.zip$", "")
            cmd = string.format("Expand-Archive -Path %s -DestinationPath %s -Force", vim.fn.shellescape(path), vim.fn.shellescape(dest))
            print("[Notify]: Extracting " .. vim.fn.fnamemodify(path, ":t") .. "...")
        else
            local dest = path .. ".zip"
            cmd = string.format("Compress-Archive -Path %s -DestinationPath %s -Force", vim.fn.shellescape(path), vim.fn.shellescape(dest))
            print("[Notify]: Compressing " .. vim.fn.fnamemodify(path, ":t") .. "...")
        end
    else
        -- Compress multiple selected files/folders
        local path_escaped = {}
        for _, p in ipairs(paths) do
            table.insert(path_escaped, vim.fn.shellescape(p))
        end
        local dest = paths[1] .. "_archive.zip"
        cmd = string.format("Compress-Archive -Path %s -DestinationPath %s -Force", table.concat(path_escaped, ", "), vim.fn.shellescape(dest))
        print("[Notify]: Compressing " .. #paths .. " items...")
    end

    vim.fn.jobstart({"powershell", "-NoProfile", "-Command", cmd}, {
        on_exit = function(_, code)
            if code == 0 then
                print("[Notify]: Operation completed successfully!")
                if CHAD and CHAD.Refresh then
                    CHAD.Refresh({})
                else
                    vim.api.nvim_feedkeys("<C-r>", "x", true)
                end
            else
                print("[Notify]: Operation failed with code " .. code)
            end
        end
    })
end

-- Enable horizontal cursor line highlighter and set buffer mappings when focusing CHADTree
local group = vim.api.nvim_create_augroup("CHADTreeConfig", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    group = group,
    pattern = "*",
    callback = function(ev)
        if vim.bo[ev.buf].filetype == "CHADTree" then
            vim.wo.cursorline = true
            -- Map 'z' in normal mode to zip/unzip the selected node(s)
            vim.keymap.set('n', 'z', chadtree_zip_unzip, { buffer = ev.buf, silent = true, desc = "Zip / Unzip selected item(s)" })
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
    group = group,
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "CHADTree" then
            vim.wo.cursorline = false
        end
    end,
})
