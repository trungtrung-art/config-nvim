return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			need = 1,
			branch = true,
		},
		keys = {
			{
				"<leader>ss",
				function()
					require("persistence").load()
				end,
				desc = "Restore session for cwd",
			},
			{
				"<leader>sS",
				function()
					require("persistence").select()
				end,
				desc = "Select session",
			},
			{
				"<leader>sl",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore last session",
			},
			{
				"<leader>sd",
				function()
					require("persistence").stop()
				end,
				desc = "Stop session saving",
			},
		},
	},
}
