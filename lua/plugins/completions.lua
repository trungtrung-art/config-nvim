return {
	-- 🔹 Snippet Engine (LuaSnip)
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets", -- ✨ Snippets có sẵn cho HTML, React, JS, TS, Tailwind...
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load() -- Tự load snippet vscode
		end,
	},

	-- 🔹 Các source bổ trợ cho completion
	{
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
	},

	-- 🧩 Frontend-focused sources (HTML, CSS, Tailwind, npm, emoji, ...)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- 🧠 Thêm plugin gợi ý npm package
			"David-Kunz/cmp-npm",
			-- 🎨 Hiển thị màu Tailwind trong popup completion
			"roobert/tailwindcss-colorizer-cmp.nvim",
			-- 😄 Emoji gợi ý (optional, có thể bỏ nếu bạn không cần)
			"hrsh7th/cmp-emoji",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- 🟢 Setup màu cho Tailwind class suggestion
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})

			-- 🧠 Setup chính
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				-- 🎹 Keybinding giống VSCode
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				-- 🧩 Các nguồn gợi ý code chính
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- Gợi ý từ LSP (html, cssls, ts_ls, tailwindcss,...)
					{ name = "luasnip" }, -- Snippet mở rộng
					{ name = "path" }, -- Gợi ý đường dẫn
					{ name = "buffer" }, -- Gợi ý từ nội dung trong buffer
					{ name = "npm" }, -- Gợi ý package.json
					{ name = "emoji" }, -- Emoji gợi ý
				}),
			})
		end,
	},

	-- ⚙️ (Optional) — Tích hợp highlight màu Tailwind
	-- 👉 Nếu sau này bạn dùng tailwindcss-colorizer-cmp riêng, có thể tách plugin này ra đây.
	-- {
	-- 	"roobert/tailwindcss-colorizer-cmp.nvim",
	-- 	config = function()
	-- 		require("tailwindcss-colorizer-cmp").setup({
	-- 			color_square_width = 2,
	-- 		})
	-- 	end,
	-- },
}
