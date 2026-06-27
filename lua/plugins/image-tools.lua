return {
	{
		"image-tools-keymaps",
		dir = vim.fn.stdpath("config"),
		lazy = false,
		config = function()
			local image_exts = {
				avif = true,
				bmp = true,
				gif = true,
				ico = true,
				jpeg = true,
				jpg = true,
				png = true,
				svg = true,
				webp = true,
			}

			local function is_image(path)
				local ext = vim.fn.fnamemodify(path, ":e"):lower()
				return image_exts[ext] == true
			end

			local function resolve_path(path)
				if path == nil or path == "" then
					return nil
				end

				path = path:gsub('^"', ""):gsub('"$', "")
				local candidates = {
					path,
					vim.fn.expand("%:p:h") .. "/" .. path,
					vim.fn.getcwd() .. "/" .. path,
				}

				for _, candidate in ipairs(candidates) do
					local full_path = vim.fn.fnamemodify(candidate, ":p")
					if vim.fn.filereadable(full_path) == 1 and is_image(full_path) then
						return full_path
					end
				end

				return nil
			end

			local function get_image_path()
				return resolve_path(vim.fn.expand("<cfile>")) or resolve_path(vim.fn.expand("%:p"))
			end

			local function open_image()
				local path = get_image_path()
				if not path then
					vim.notify("Khong tim thay image file o cursor hoac buffer hien tai", vim.log.levels.WARN)
					return
				end

				vim.ui.open(path)
			end

			local function preview_image()
				local path = get_image_path()
				if not path then
					vim.notify("Khong tim thay image file o cursor hoac buffer hien tai", vim.log.levels.WARN)
					return
				end

				if vim.fn.executable("wezterm") ~= 1 then
					vim.notify("Khong tim thay wezterm CLI, dang mo bang app mac dinh", vim.log.levels.WARN)
					vim.ui.open(path)
					return
				end

				vim.cmd("botright split")
				vim.cmd("resize 24")
				vim.cmd("terminal wezterm imgcat --width 100% --height 95% --hold " .. vim.fn.shellescape(path))
				vim.cmd("startinsert")
			end

			vim.keymap.set("n", "<leader>io", open_image, { desc = "Open image externally" })
			vim.keymap.set("n", "<leader>ip", preview_image, { desc = "Preview image in terminal" })
		end,
	},
}
