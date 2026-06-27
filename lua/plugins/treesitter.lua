return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				-- auto install
				auto_install = true,
				-- add language you want to highlight in code
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"go",
					"gomod",
					"gowork",
					"gosum",
					"java",
					"json",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")

			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@function.outer"] = "V",
						["@class.outer"] = "V",
					},
					include_surrounding_whitespace = false,
				},
				move = {
					set_jumps = true,
				},
			})

			vim.keymap.set({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer", "textobjects")
			end, { desc = "Around function" })

			vim.keymap.set({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner", "textobjects")
			end, { desc = "Inside function" })

			vim.keymap.set({ "x", "o" }, "ac", function()
				select.select_textobject("@class.outer", "textobjects")
			end, { desc = "Around class" })

			vim.keymap.set({ "x", "o" }, "ic", function()
				select.select_textobject("@class.inner", "textobjects")
			end, { desc = "Inside class" })

			vim.keymap.set({ "n", "x", "o" }, "]m", function()
				move.goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function start" })

			vim.keymap.set({ "n", "x", "o" }, "[m", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end, { desc = "Previous function start" })

			vim.keymap.set({ "n", "x", "o" }, "]]", function()
				move.goto_next_start("@class.outer", "textobjects")
			end, { desc = "Next class start" })

			vim.keymap.set({ "n", "x", "o" }, "[[", function()
				move.goto_previous_start("@class.outer", "textobjects")
			end, { desc = "Previous class start" })
		end,
	},
}
