vim.api.nvim_create_autocmd({ "BufReadPre" }, {
		pattern = "*",
		callback = function()
			local _max = 2 * 1024 * 1024;
			local _check = vim.fn.expand("<afile>");
			local _ok, _stats = pcall(vim.loop.fs_stat, _check);

			if _ok and _stats and _stats.size > _max then
				vim.opt_local.swapfile = false
				vim.opt_local.undofile = false
				vim.opt_local.bufhidden = "unload"
				vim.opt_local.foldmethod = "manual"
				vim.opt_local.syntax = "off"
				pcall(vim.cmd, "TSBufDisable highlight")
			end
		end,
	}
)
