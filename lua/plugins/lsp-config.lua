return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"tailwindcss",
					"jsonls",
					"pyright",
					"eslint",
				},
				automatic_enable = true,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua-language-server",
				"typescript-language-server",
				"html-lsp",
				"css-lsp",
				"tailwindcss-language-server",
				"json-lsp",
				"pyright",
				"eslint-lsp",
				"stylua",
				"prettier",
				"black",
				"isort",
				"gofumpt",
				"js-debug-adapter",
				"debugpy",
			},
			auto_update = false,
			run_on_start = true,
			start_delay = 3000,
			debounce_hours = 24,
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = false,
							},
						},
					},
				},
				ts_ls = {},
				html = {},
				cssls = {},
				tailwindcss = {},
				jsonls = {},
				pyright = {},
				eslint = {},
			}

			for name, config in pairs(servers) do
				config.capabilities = capabilities
				vim.lsp.config(name, config)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>lf", function()
						require("core.format").format_buffer({ bufnr = event.buf })
					end, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				end,
			})

			vim.diagnostic.config({
				virtual_text = { spacing = 2, prefix = "●" },
				float = { border = "rounded" },
				severity_sort = true,
			})
		end,
	},
}
