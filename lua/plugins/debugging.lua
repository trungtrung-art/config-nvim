local function mason_bin(command)
	local extension = vim.fn.has("win32") == 1 and ".cmd" or ""
	local path = vim.fn.stdpath("data") .. "/mason/bin/" .. command .. extension

	if vim.fn.executable(path) == 1 then
		return path
	end

	return command
end

local function js_debug_configurations()
	return {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch current file",
			program = "${file}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
			console = "integratedTerminal",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to Node process",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch Chrome against localhost",
			url = function()
				return vim.fn.input("URL: ", "http://localhost:3000")
			end,
			webRoot = "${workspaceFolder}",
			sourceMaps = true,
		},
	}
end

return {
	{
		"mfussenegger/nvim-dap",
		cmd = {
			"DapContinue",
			"DapDisconnect",
			"DapNew",
			"DapPause",
			"DapRestartFrame",
			"DapStepInto",
			"DapStepOut",
			"DapStepOver",
			"DapTerminate",
			"DapToggleBreakpoint",
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Conditional breakpoint",
			},
			{
				"<leader>dL",
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				desc = "Log point",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Debug continue/start",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Debug step over",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Debug step into",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "Debug step out",
			},
			{
				"<leader>dp",
				function()
					require("dap").pause()
				end,
				desc = "Debug pause",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Debug terminate",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Debug run last",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "Debug REPL",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle debug UI",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				mode = { "n", "v" },
				desc = "Debug eval",
			},
		},
		dependencies = {
			"mxsdev/nvim-dap-vscode-js",
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
			},
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("nvim-dap-virtual-text").setup({
				commented = true,
			})

			dapui.setup()

			vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DapStopped", { text = ">", texthl = "DiagnosticSignHint" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "DiagnosticSignError" })

			require("dap-vscode-js").setup({
				debugger_cmd = { mason_bin("js-debug-adapter") },
				adapters = { "pwa-node", "pwa-chrome" },
			})

			for _, language in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
				dap.configurations[language] = js_debug_configurations()
			end

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
