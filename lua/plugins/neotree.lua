return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	cmd = "Neotree", -- chỉ load khi dùng lệnh :Neotree
	keys = {
		{ "<leader>v", "<cmd>Neotree toggle left<cr>", desc = "Toggle Neo-tree" },
		{ "<leader>q", "<cmd>Neotree reveal<cr>", desc = "Close buffer and focus Neo-tree" }	
	},

	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			filesystem = {
				follow_current_file = { enabled = true },
				hijack_netrw_behavior = "open_default",
			},
			window = {
				width = 30,
				mappings = {
					["<space>"] = "none",
				},
			},
		})
	end,
}
