local function neotest()
	return require("neotest")
end

local function current_file()
	return vim.fn.expand("%")
end

local function current_cwd()
	return vim.uv.cwd() or vim.fn.getcwd()
end

local function filter_test_dir(name)
	return not vim.tbl_contains({
		".git",
		"build",
		"coverage",
		"dist",
		"node_modules",
		"out",
	}, name)
end

return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
			"marilari88/neotest-vitest",
		},
		keys = {
			{
				"<leader>nn",
				function()
					neotest().run.run()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>nf",
				function()
					neotest().run.run(current_file())
				end,
				desc = "Run current test file",
			},
			{
				"<leader>nA",
				function()
					neotest().run.run(current_cwd())
				end,
				desc = "Run all tests in cwd",
			},
			{
				"<leader>nl",
				function()
					neotest().run.run_last()
				end,
				desc = "Run last test",
			},
			{
				"<leader>nd",
				function()
					neotest().run.run({ strategy = "dap" })
				end,
				desc = "Debug nearest test",
			},
			{
				"<leader>ns",
				function()
					neotest().summary.toggle()
				end,
				desc = "Toggle test summary",
			},
			{
				"<leader>no",
				function()
					neotest().output.open({ enter = true, auto_close = true })
				end,
				desc = "Open test output",
			},
			{
				"<leader>nO",
				function()
					neotest().output_panel.toggle()
				end,
				desc = "Toggle test output panel",
			},
			{
				"<leader>nx",
				function()
					neotest().run.stop()
				end,
				desc = "Stop nearest test",
			},
			{
				"<leader>nw",
				function()
					neotest().watch.toggle(current_file())
				end,
				desc = "Toggle watch current file",
			},
		},
		config = function()
			neotest().setup({
				adapters = {
					require("neotest-jest")({
						jest_test_discovery = false,
					}),
					require("neotest-vitest")({
						filter_dir = function(name)
							return filter_test_dir(name)
						end,
					}),
				},
				consumers = {},
				discovery = {
					enabled = true,
				},
				floating = {
					border = "rounded",
				},
				quickfix = {
					enabled = true,
					open = false,
				},
				status = {
					enabled = true,
					signs = true,
					virtual_text = false,
				},
				output = {
					enabled = true,
					open_on_run = false,
				},
				output_panel = {
					enabled = true,
					open = "botright split | resize 15",
				},
				summary = {
					enabled = true,
					follow = true,
				},
			})
		end,
	},
}
