return {
	{
		"git-root-keymaps",
		dir = vim.fn.stdpath("config"),
		lazy = false,
		config = function()
			local function change_to_git_root()
				local file_dir = vim.fn.expand("%:p:h")
				if file_dir == "" then
					file_dir = vim.fn.getcwd()
				end

				local result = vim.fn.systemlist({ "git", "-C", file_dir, "rev-parse", "--show-toplevel" })
				if vim.v.shell_error ~= 0 or not result[1] then
					vim.notify("Khong tim thay Git repo tu: " .. file_dir, vim.log.levels.WARN)
					return
				end

				vim.cmd.cd(vim.fn.fnameescape(result[1]))
				vim.notify("cwd: " .. vim.fn.getcwd())
			end

			vim.keymap.set("n", "<leader>gc", change_to_git_root, { desc = "Cd to current git root" })
			vim.keymap.set("n", "<leader>gw", function()
				vim.notify("cwd: " .. vim.fn.getcwd())
			end, { desc = "Show current cwd" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = false,
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local opts = { buffer = bufnr }

				vim.keymap.set("n", "]h", gs.next_hunk, opts)
				vim.keymap.set("n", "[h", gs.prev_hunk, opts)
				vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
				vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
				vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
				vim.keymap.set("n", "<leader>hb", gs.blame_line, opts)
			end,
		},
	},
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open git diff view" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current file history" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo file history" },
			{ "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
		},
	},
	{
		"isakbm/gitgraph.nvim",
		dependencies = { "sindrets/diffview.nvim" },
		opts = {
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			format = {
				timestamp = "%Y-%m-%d %H:%M",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			hooks = {
				on_select_commit = function(commit)
					vim.cmd("DiffviewOpen " .. commit.hash .. "^!")
				end,
				on_select_range_commit = function(from, to)
					vim.cmd("DiffviewOpen " .. from.hash .. ".." .. to.hash)
				end,
			},
		},
		keys = {
			{
				"<leader>gg",
				function()
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end,
				desc = "Open git graph",
			},
		},
	},
}
