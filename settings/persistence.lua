require("persistence").setup()

-- Restore session
GKeymap.set("n", "<leader>qs", function() require("persistence").load() end, GQuickOpt("[Q]uick [S]ession Restore"))
-- Select session to restore
GKeymap.set("n", "<leader>qS", function() require("persistence").select() end, GQuickOpt("[Q]uick [S]elect Session"))
-- Restore last session
GKeymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, GQuickOpt("[Q]uick [L]ast Session"))
-- Stop saving session
GKeymap.set("n", "<leader>qd", function() require("persistence").stop() end, GQuickOpt("[Q]uick [D]isable Session Saving"))
