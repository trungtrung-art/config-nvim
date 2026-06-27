local M = {}

M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
M.is_mac = vim.fn.has("macunix") == 1
M.is_linux = vim.fn.has("linux") == 1
M.is_wsl = M.is_linux and (vim.env.WSL_DISTRO_NAME ~= nil or vim.env.WSL_INTEROP ~= nil)
M.path_sep = package.config:sub(1, 1)

function M.executable(name)
	return vim.fn.executable(name) == 1
end

return M
