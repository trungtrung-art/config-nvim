return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			local Terminal = require("toggleterm.terminal").Terminal

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

				command = ("%s dir=%s"):format(command, vim.fn.fnameescape(vim.fn.getcwd()))
				vim.cmd(command)
			end

			local function git_root()
				local result = vim.fn.systemlist({ "git", "-C", vim.fn.getcwd(), "rev-parse", "--show-toplevel" })
				if vim.v.shell_error == 0 and result[1] then
					return result[1]
				end

				return vim.fn.getcwd()
			end

			local command_terms = {}

			local function command_term(command)
				local executable = vim.split(command, "%s+")[1]
				if vim.fn.executable(executable) ~= 1 then
					vim.notify(("Missing `%s` in PATH"):format(executable), vim.log.levels.WARN)
					return
				end

				local root = git_root()
				local key = command .. root
				command_terms[key] = command_terms[key]
					or Terminal:new({
						cmd = command,
						dir = root,
						direction = "float",
						close_on_exit = false,
						hidden = true,
					})
				command_terms[key]:toggle()
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

			vim.keymap.set("n", "<leader>ac", function()
				command_term("claude")
			end, { desc = "Open Claude in project root" })

			vim.keymap.set("n", "<leader>aC", function()
				command_term("claude --continue")
			end, { desc = "Continue Claude in project root" })

			vim.keymap.set("n", "<leader>ax", function()
				command_term("codex")
			end, { desc = "Open Codex in project root" })

			vim.keymap.set("n", "<leader>aX", function()
				command_term("codex resume")
			end, { desc = "Resume Codex in project root" })
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
