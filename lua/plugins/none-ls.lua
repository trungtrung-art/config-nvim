return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local sources = {}

		local function add_if_executable(executable, source)
			if vim.fn.executable(executable) == 1 then
				table.insert(sources, source)
			end
		end

		add_if_executable("stylua", null_ls.builtins.formatting.stylua)
		add_if_executable("prettier", null_ls.builtins.formatting.prettier)
		add_if_executable("black", null_ls.builtins.formatting.black)
		add_if_executable("isort", null_ls.builtins.formatting.isort)
		add_if_executable("gofumpt", null_ls.builtins.formatting.gofumpt)

		null_ls.setup({
			sources = sources,
		})

		vim.keymap.set("n", "<leader>p", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Format buffer" })
	end,
}
