return {
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "^4.0.0",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash jump",
			},
			{
				"<leader>S",
				mode = { "n", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = "o",
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<C-s>",
				mode = "c",
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
}
