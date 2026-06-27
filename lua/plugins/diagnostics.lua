return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		keys = {
			{ "<leader>ld", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
			{ "<leader>lD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
			{ "<leader>ls", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Document symbols" },
			{ "<leader>ll", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP locations" },
			{ "<leader>lq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
			{ "<leader>lL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
		},
	},
}
