

--local prj = require("neoproj")
--
--if prj ~= nil then
--
--    prj.setup {
--        project_path = "~projects",
--    }
--
--    vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
--        callback = function ()
--            if GGlobal.project_root ~= nil then
--                prj.save_session()
--            end
--        end
--    })
--
--end
