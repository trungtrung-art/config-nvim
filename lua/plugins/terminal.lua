return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 15,
				open_mapping = [[<c-\>]],
				direction = "horizontal",
				shade_terminals = true,
				start_in_insert = true,
				persist_size = true,
				close_on_exit = true,
				float_opts = {
					border = "curved",
				},
			})

			local function toggle_term(opts)
				local count = vim.v.count1
				local command = ("%dToggleTerm direction=%s"):format(count, opts.direction)

				if opts.size then
					command = ("%s size=%d"):format(command, opts.size)
				end

				vim.cmd(command)
			end

			vim.keymap.set("n", "<leader>tt", function()
				toggle_term({ direction = "horizontal" })
			end, { desc = "Toggle numbered horizontal terminal" })

			vim.keymap.set("n", "<leader>tf", function()
				toggle_term({ direction = "float" })
			end, { desc = "Toggle numbered floating terminal" })

			vim.keymap.set("n", "<leader>tv", function()
				toggle_term({ direction = "vertical", size = 80 })
			end, { desc = "Toggle numbered vertical terminal" })
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
		config = function()
			vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate left" })
			vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate down" })
			vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate up" })
			vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate right" })
		end,
	},
}
