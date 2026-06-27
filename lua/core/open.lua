local os = require("core.os")

local M = {}

local function run_detached(command)
	local ok, job_id = pcall(vim.fn.jobstart, command, { detach = true })
	return ok and type(job_id) == "number" and job_id > 0
end

local function wsl_windows_path(path)
	if not os.executable("wslpath") then
		return nil
	end

	local result = vim.fn.systemlist({ "wslpath", "-w", path })
	if vim.v.shell_error ~= 0 then
		return nil
	end

	return result[1]
end

function M.open_path(path)
	if path == nil or path == "" then
		return false
	end

	if os.is_wsl then
		if os.executable("wslview") and run_detached({ "wslview", path }) then
			return true
		end

		local windows_path = wsl_windows_path(path)
		if windows_path and os.executable("explorer.exe") and run_detached({ "explorer.exe", windows_path }) then
			return true
		end
	end

	if os.is_windows and run_detached({ "cmd.exe", "/c", "start", "", path }) then
		return true
	end

	if os.is_mac and os.executable("open") and run_detached({ "open", path }) then
		return true
	end

	if os.is_linux and os.executable("xdg-open") and run_detached({ "xdg-open", path }) then
		return true
	end

	if vim.ui and vim.ui.open then
		local ok = pcall(vim.ui.open, path)
		if ok then
			return true
		end
	end

	vim.notify("Khong the mo file bang app he dieu hanh: " .. path, vim.log.levels.WARN)
	return false
end

function M.wezterm_imgcat_command(path)
	local wezterm = os.first_executable({ "wezterm", "wezterm.exe" })
	if not wezterm then
		return nil
	end

	return ("%s imgcat --width 100%% --height 95%% --hold %s"):format(wezterm, vim.fn.shellescape(path))
end

return M
