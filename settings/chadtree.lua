local keymap = vim.keymap

keymap.set('n', '<M-1>', ':CHADopen<CR>', { silent = true })
keymap.set('n', '<F1>', ':CHADopen<CR>', { silent = true })
keymap.set('x', '<F1>', '<ESC>:CHADopen<CR>', { silent = true })
keymap.set('i', '<F1>', '<ESC>:CHADopen<CR>', { silent = true })

local function chadtree_zip()
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
        local normalized = p:gsub('\\', '/')
        table.insert(paths, normalized)
    end

    if #paths == 0 then return end

    -- Determine default zip name
    local default_name = "archive.zip"
    local base_dir = ""
    if #paths == 1 then
        local p = paths[1]
        base_dir = vim.fn.fnamemodify(p, ":h") .. "/"
        local name = vim.fn.fnamemodify(p, ":t")
        default_name = name .. ".zip"
    else
        base_dir = vim.fn.fnamemodify(paths[1], ":h") .. "/"
    end

    -- Ask user for zip file name
    vim.ui.input({ prompt = "Zip Archive Name: ", default = default_name }, function(input)
        if not input or vim.trim(input) == "" then
            print("[Notify]: Zip operation canceled")
            return
        end

        local zip_name = vim.trim(input)
        if not zip_name:match("%.zip$") then
            zip_name = zip_name .. ".zip"
        end

        -- Ensure absolute path for destination
        local dest_path = zip_name
        if not (zip_name:match("^%a:") or zip_name:match("^/")) then
            dest_path = base_dir .. zip_name
        end

        -- Escape all paths for PowerShell
        local path_escaped = {}
        for _, p in ipairs(paths) do
            table.insert(path_escaped, vim.fn.shellescape(p))
        end

        local cmd = string.format("Compress-Archive -Path %s -DestinationPath %s -Force", table.concat(path_escaped, ", "), vim.fn.shellescape(dest_path))
        print("[Notify]: Creating zip archive " .. vim.fn.fnamemodify(dest_path, ":t") .. "...")

        vim.fn.jobstart({"powershell", "-NoProfile", "-Command", cmd}, {
            on_exit = function(_, code)
                if code == 0 then
                    print("[Notify]: Zip completed successfully!")
                    if CHAD and CHAD.Refresh then
                        CHAD.Refresh({})
                    else
                        vim.api.nvim_feedkeys("<C-r>", "x", true)
                    end
                else
                    print("[Notify]: Zip failed with code " .. code)
                end
            end
        })
    end)
end

local function chadtree_unzip()
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
        local normalized = p:gsub('\\', '/')
        table.insert(paths, normalized)
    end

    if #paths == 0 then return end

    local cmd_parts = {}
    local zip_files = {}

    for _, p in ipairs(paths) do
        if p:match("%.zip$") then
            local dest = p:gsub("%.zip$", "")
            local cmd_part = string.format("Expand-Archive -Path %s -DestinationPath %s -Force", vim.fn.shellescape(p), vim.fn.shellescape(dest))
            table.insert(cmd_parts, cmd_part)
            table.insert(zip_files, vim.fn.fnamemodify(p, ":t"))
        end
    end

    if #cmd_parts == 0 then
        print("[Notify]: No .zip files selected")
        return
    end

    local cmd = table.concat(cmd_parts, "; ")
    print("[Notify]: Extracting " .. table.concat(zip_files, ", ") .. "...")

    vim.fn.jobstart({"powershell", "-NoProfile", "-Command", cmd}, {
        on_exit = function(_, code)
            if code == 0 then
                print("[Notify]: Unzip completed successfully!")
                if CHAD and CHAD.Refresh then
                    CHAD.Refresh({})
                else
                    vim.api.nvim_feedkeys("<C-r>", "x", true)
                end
            else
                print("[Notify]: Unzip failed with code " .. code)
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
            -- Map 'z' to zip/compress selected item(s)
            vim.keymap.set('n', 'z', chadtree_zip, { buffer = ev.buf, silent = true, desc = "Zip selected item(s)" })
            -- Map 'Z' to unzip/extract selected item(s)
            vim.keymap.set('n', 'Z', chadtree_unzip, { buffer = ev.buf, silent = true, desc = "Unzip selected zip file(s)" })
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
