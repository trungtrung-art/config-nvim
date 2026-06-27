local os = require("core.os")

if os.is_windows then
	local shell = os.first_executable({ "pwsh", "powershell" })
	if shell then
		vim.opt.shell = shell
		vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
		vim.opt.shellquote = ""
		vim.opt.shellxquote = ""
		vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
		vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	end
end

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.mouse = "a"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.colorcolumn = "94"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.incsearch = true

if os.is_wsl and os.executable("win32yank.exe") then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "white" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ead84e" })
