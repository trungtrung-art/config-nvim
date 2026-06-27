return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					component_separators = "",
					section_separators = "",
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"famiu/bufdelete.nvim",
		},
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup({
				options = {
					mode = "buffers",
					close_command = "Bdelete! %d",
					right_mouse_command = "Bdelete! %d",
					diagnostics = "nvim_lsp",
					separator_style = "thin",
					show_buffer_close_icons = true,
					show_close_icon = false,
					always_show_bufferline = true,
					offsets = {
						{
							filetype = "neo-tree",
							text = "Explorer",
							highlight = "Directory",
							separator = true,
						},
					},
				},
			})

			vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
			vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
			vim.keymap.set("n", "<leader>x", "<cmd>Bdelete<cr>", { desc = "Close current buffer" })
			vim.keymap.set("n", "<leader>X", "<cmd>Bdelete!<cr>", { desc = "Force close current buffer" })
			vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })
			vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
}
