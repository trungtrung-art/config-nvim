local os = require("core.os")

local M = {}

local required_executables = {
	{ label = "Git", commands = { "git" }, reason = "plugin install, Fugitive, Diffview, Git Graph" },
	{ label = "Node.js", commands = { "node" }, reason = "TypeScript LSP, formatters, JS debug/test workflows" },
	{ label = "npm", commands = { "npm" }, reason = "frontend tooling and Mason npm packages" },
	{ label = "Python", commands = { "python3", "python" }, reason = "Python LSP/formatters and provider support" },
	{ label = "ripgrep", commands = { "rg" }, reason = "Telescope live grep" },
	{ label = "fd", commands = { "fd", "fdfind" }, reason = "fast file finding" },
	{ label = "unzip", commands = { "unzip" }, reason = "Mason package extraction" },
}

local optional_executables = {
	{ label = "tmux", commands = { "tmux" }, reason = "optional terminal multiplexer workflow" },
	{ label = "WezTerm", commands = { "wezterm" }, reason = "optional inline image preview" },
}

local mason_packages = {
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
}

local treesitter_parsers = {
	"lua",
	"vim",
	"vimdoc",
	"javascript",
	"typescript",
	"tsx",
	"html",
	"css",
	"json",
	"python",
	"go",
}

local function start(message)
	if vim.health and vim.health.start then
		vim.health.start(message)
	end
end

local function ok(message)
	if vim.health and vim.health.ok then
		vim.health.ok(message)
	end
end

local function warn(message, advice)
	if vim.health and vim.health.warn then
		vim.health.warn(message, advice)
	end
end

local function error(message, advice)
	if vim.health and vim.health.error then
		vim.health.error(message, advice)
	end
end

local function info(message)
	if vim.health and vim.health.info then
		vim.health.info(message)
	end
end

local function executable_from(candidates)
	for _, command in ipairs(candidates) do
		if os.executable(command) then
			return command
		end
	end

	return nil
end

local function check_executables(title, tools, required)
	start(title)

	for _, tool in ipairs(tools) do
		local command = executable_from(tool.commands)
		if command then
			ok(("%s available as `%s`"):format(tool.label, command))
		elseif required then
			error(("%s is missing"):format(tool.label), { ("Install it for %s."):format(tool.reason) })
		else
			warn(("%s is missing"):format(tool.label), { ("Install it if you use %s."):format(tool.reason) })
		end
	end
end

local function mason_package_path(name)
	return vim.fn.stdpath("data") .. "/mason/packages/" .. name
end

local function check_mason_packages()
	start("Mason packages")

	for _, package in ipairs(mason_packages) do
		if vim.uv.fs_stat(mason_package_path(package)) then
			ok(("Mason package installed: %s"):format(package))
		else
			warn(("Mason package missing: %s"):format(package), {
				"Run :MasonToolsInstall after the first plugin install pass.",
			})
		end
	end
end

local function check_treesitter_parsers()
	start("Treesitter parsers")

	local ok_parsers, parsers = pcall(require, "nvim-treesitter.parsers")
	if not ok_parsers then
		warn("nvim-treesitter parser API is not available yet", {
			"Run :Lazy sync, restart Neovim, then run :TSUpdate.",
		})
		return
	end

	for _, parser in ipairs(treesitter_parsers) do
		if parsers.has_parser(parser) then
			ok(("Treesitter parser installed: %s"):format(parser))
		else
			warn(("Treesitter parser missing: %s"):format(parser), {
				"Run :TSUpdate or :TSInstall " .. parser,
			})
		end
	end
end

local function check_os_helpers()
	start("OS helpers")

	if os.is_windows then
		ok("Detected Windows native Neovim")
		if executable_from({ "pwsh", "powershell" }) then
			ok("PowerShell shell available")
		else
			error("PowerShell shell is missing", {
				"Install PowerShell or make sure powershell.exe is in PATH.",
			})
		end
	elseif os.is_wsl then
		ok("Detected WSL")
		if os.executable("win32yank.exe") then
			ok("win32yank.exe available for clipboard integration")
		else
			warn("win32yank.exe is missing", {
				"Install it if clipboard sync with Windows is needed.",
			})
		end

		if executable_from({ "wslview", "explorer.exe" }) then
			ok("WSL external file opener available")
		else
			warn("No WSL external file opener found", {
				"Install wslu for wslview or ensure explorer.exe is reachable.",
			})
		end
	elseif os.is_mac then
		ok("Detected macOS")
		if os.executable("open") then
			ok("macOS `open` command available")
		else
			warn("macOS `open` command missing from PATH")
		end
	elseif os.is_linux then
		ok("Detected Linux")
		if os.executable("xdg-open") then
			ok("xdg-open available")
		else
			warn("xdg-open is missing", {
				"Install xdg-utils if you want external file/image opening.",
			})
		end
	else
		warn("Unknown operating system")
	end

	local compiler = executable_from({ "cc", "gcc", "clang", "cl" })
	if compiler then
		ok(("C compiler available as `%s`"):format(compiler))
	else
		warn("No C compiler found", {
			"Install LLVM, GCC, Xcode command line tools, or Visual Studio Build Tools for Treesitter parser builds.",
		})
	end
end

local function read_package_json()
	local package_json = vim.fn.getcwd() .. "/package.json"
	if not vim.uv.fs_stat(package_json) then
		return nil
	end

	local lines = vim.fn.readfile(package_json)
	local ok_decode, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
	if ok_decode then
		return decoded
	end

	warn("package.json exists but could not be parsed")
	return nil
end

local function has_package_dependency(package_json, name)
	for _, key in ipairs({ "dependencies", "devDependencies", "peerDependencies" }) do
		if package_json[key] and package_json[key][name] then
			return true
		end
	end

	return false
end

local function has_script_containing(package_json, needle)
	if not package_json.scripts then
		return false
	end

	for _, script in pairs(package_json.scripts) do
		if type(script) == "string" and script:find(needle, 1, true) then
			return true
		end
	end

	return false
end

local function check_project_context()
	start("Current project")

	local cwd = vim.fn.getcwd()
	info("cwd: " .. cwd)

	local git_root = vim.fn.systemlist({ "git", "-C", cwd, "rev-parse", "--show-toplevel" })
	if vim.v.shell_error == 0 and git_root[1] then
		ok("Git repository detected: " .. git_root[1])
	else
		warn("Current cwd is not inside a Git repository")
	end

	local package_json = read_package_json()
	if not package_json then
		info("No package.json found in cwd")
		return
	end

	ok("package.json found in cwd")

	if has_package_dependency(package_json, "jest") or has_script_containing(package_json, "jest") then
		ok("Jest project signals detected")
	else
		info("No Jest dependency/script detected")
	end

	if has_package_dependency(package_json, "vitest") or has_script_containing(package_json, "vitest") then
		ok("Vitest project signals detected")
	else
		info("No Vitest dependency/script detected")
	end
end

function M.check()
	start("Neovim config")

	if vim.fn.has("nvim-0.11") == 1 then
		ok("Neovim version is 0.11 or newer")
	else
		error("Neovim 0.11 or newer is required", {
			"Upgrade Neovim before using this config on a new machine.",
		})
	end

	check_executables("Required executables", required_executables, true)
	check_executables("Optional executables", optional_executables, false)
	check_os_helpers()
	check_mason_packages()
	check_treesitter_parsers()
	check_project_context()
end

return M
